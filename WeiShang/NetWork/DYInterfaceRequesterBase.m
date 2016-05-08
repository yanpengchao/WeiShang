//
//  DYInterfaceRequesterBase.m
//  IntelligenceResearchReport
//
//  Created by datayes on 15/10/20.
//  Copyright © 2015年 datayes. All rights reserved.
//

#import "DYInterfaceRequesterBase.h"
#import "DYInterfacePropertiesManager.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "DYErrorHelper.h"
#import "NSString+URL.h"

#define MAX_CONCURRENT_OPERATION_COUNT  5                       // 最大并发请求数

static NSString* const kOperationMsgIdKey = @"msgIdKey";        // 字典里msgId的key
static NSString* const kInterfaceInfoKey = @"interfaceInfoKey"; // 字典里interface info的key
static NSString* const kParametersKey = @"parametersKey";       // 字典里参数的key

@implementation DYInterfaceRequesterBase

- (void)sendRequestWithMsgId:(EInterfaceId)msgId
                  parameters:(id)params
               canUsingCache:(BOOL)usingCacheFlag
                 forceReload:(BOOL)reloadFlag
                 resultBlock:(DYRequestResultBlock)resultBlock
{
    __weak __typeof(self)weakSelf = self;
    __block id blockParams = [params copy];
    dispatch_async(self.networkProcessingQueue, ^{
        DYInterfaceInfo* interfaceInfo = [DYInterfacePropertiesManager interfaceInfoWithInterfaceId:msgId];
        if (interfaceInfo != nil) {
            // 检查是否已经存在这个请求了
            AFHTTPRequestOperation* urlConnectionOperation = [weakSelf operationWithMsgId:msgId];
            if (urlConnectionOperation != nil) {
                // 强制重新加载
                if (reloadFlag) {
                    [urlConnectionOperation cancel];
                    urlConnectionOperation = nil;
                }
                // 不允许多个并发请求时，直接返回
                else if (!interfaceInfo.allowMutableRequest)
                {
                    DDLogInfo(@"请求 （%@） 被忽略", interfaceInfo.comment);
                    resultBlock(nil, nil, [NSError errorWithDomain:kRequestError code:RepeatedRequest userInfo:nil]);
                    return ;
                }
            }
            
            NSString* url = [self urlWithInterfaceInfo:interfaceInfo];
            if (interfaceInfo.requestType == eRequestTypeGet && [blockParams isKindOfClass:[NSString class]]) {
                url = [NSString stringWithFormat:@"%@/%@", url, blockParams];
                blockParams = @"";
            }
            else if ([blockParams isKindOfClass:[NSDictionary class]])
            {
                NSString* extraAddedSubUrl = [blockParams objectForKey:kExtraAddedSubUrlKey];
                if (extraAddedSubUrl != nil) {
                    url = [NSString stringWithFormat:@"%@/%@", url, extraAddedSubUrl];
                    
                    NSMutableDictionary* mDic = [NSMutableDictionary dictionary];
                    for (id key in [blockParams allKeys]) {
                        if ([key isKindOfClass:[NSString class]] && ![key isEqualToString:kExtraAddedSubUrlKey]) {
                            [mDic setObject:[blockParams objectForKey:key] forKey:key];
                        }
                    }
                    blockParams = mDic;
                }
                else
                {
                    // do nothing
                }
            }
            
            NSMutableDictionary* mDic = [NSMutableDictionary dictionary];
            [mDic setObject:@(msgId) forKey:kOperationMsgIdKey];
            [mDic setObject:interfaceInfo forKey:kInterfaceInfoKey];
            if (blockParams != nil) {
                [mDic setObject:blockParams forKey:kParametersKey];
            }
            
            void (^ successBlock)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject) {
                if (responseObject != nil) {
                    if (interfaceInfo.responseBodyTiedType == eResponseBodyTiedTypeGBuf) {
                        id resultInfo = nil;
                        @try {
                            if ([interfaceInfo.parseClass length] > 0) {
                                Class passClass = NSClassFromString(interfaceInfo.parseClass);
                                if (passClass != Nil) {
//                                    resultInfo = [passClass parseFromData:(NSData*)responseObject];
                                }
                                else
                                {
                                    DDLogError(@"未找到 %@ 对应的类", interfaceInfo.parseClass);
                                }
                            }
                            else
                            {
//                                resultInfo = [Result parseFromData:(NSData*)responseObject];
                            }
                        }
                        @catch (NSException *exception) {
                            NSLog(@"%@接口GBuffer解析异常", interfaceInfo.comment);
                            NSString* contentType = [operation.request valueForHTTPHeaderField:@"Content-Type"];
                            if ([contentType isEqualToString:@"application/json"]) {
                                NSError* error = nil;
                                NSDictionary* tryDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                                       options:NSJSONReadingMutableLeaves
                                                                                         error:&error];
                                if (error != nil) {
                                    DDLogInfo(@"GBuffer解析异常后，尝试Json解析失败，原因：%@", error);
                                }
                                else {
                                    DDLogInfo(@"GBuffer解析异常后，尝试Json解析，结果为：%@", tryDic);
                                    resultInfo = tryDic;
                                }
                            }
                            else
                            {
                                DDLogInfo(@"GBuffer解析异常，数据contentType为：%@", contentType);
                            }
                        }
                        @finally {
                            if (resultInfo != nil) {
                                DDLogInfo(@"%@\nURL为：\n%@\n参数为：\n%@\n调用结果已返回", [self stringWithInterfaceInfo:interfaceInfo], url, blockParams);
                                resultBlock(operation, resultInfo, nil);
                            }
                            else
                            {
                                NSError* err = [NSError errorWithDomain:kCodingErrorDomain code:GBufferDecodeError userInfo:nil];
                                resultBlock(operation, nil, err);
                                DDLogInfo(@"%@\nURL为：\n%@\n参数为：\n%@\n返回异常：\n%@", [self stringWithInterfaceInfo:interfaceInfo], url, blockParams, err);
                            }
                        }
                    }
                    else if (interfaceInfo.responseBodyTiedType == eResponseBodyTiedTypeJson)
                    {
                        DDLogInfo(@"%@\nURL为：\n%@\n参数为：\n%@\n调用结果已返回:%@", [self stringWithInterfaceInfo:interfaceInfo], url, blockParams, responseObject);
                        resultBlock(operation, responseObject, nil);
                    }
                }
                else
                {
                    NSError* err = [NSError errorWithDomain:kInterfaceDataError code:NullData userInfo:nil];
                    resultBlock(operation, nil, err);
                    DDLogInfo(@"%@\nURL为：\n%@\n参数为：\n%@\n返回异常：\n%@", [self stringWithInterfaceInfo:interfaceInfo], url, blockParams, err);
                }
            };
            
            void (^failureBlock)(AFHTTPRequestOperation *operation, NSError *error) = ^(AFHTTPRequestOperation *operation, NSError *error) {
                DDLogInfo(@"%@\nURL为：\n%@\n参数为：\n%@\n返回异常：\n%@", [self stringWithInterfaceInfo:interfaceInfo], url, blockParams, error);
                [DYErrorHelper dealWithError:error];
                resultBlock(operation, nil, error);
            };
            
            DDLogInfo(@"%@被调用, here is httpheader:%@", [self stringWithInterfaceInfo:interfaceInfo], weakSelf.requestOperationManager.requestSerializer.HTTPRequestHeaders);
            DDLogInfo(@"%@被调用, url为：%@，参数为：%@", [self stringWithInterfaceInfo:interfaceInfo], url, blockParams);
            
            
            //获取cacheExpireTime
            self.requestOperationManager.cacheExpireTime = interfaceInfo.cacheExpireTime;
            
            //添加接口版本号；
            NSString *apiVersion;
            if (interfaceInfo.apiVersion == nil) {
                apiVersion = @"2.2.0";
            }else{
                apiVersion = interfaceInfo.apiVersion;
            }
            
            if ([blockParams isKindOfClass:[NSDictionary class]]){
                NSMutableDictionary *dic = [(NSDictionary *)blockParams mutableCopy];
                [dic setObject:apiVersion forKey:@"apiVersion"];
                blockParams = dic;
            }
            
            
            switch (interfaceInfo.requestType) {
                case eRequestTypeGet:
                {
                    urlConnectionOperation =
                    [weakSelf.requestOperationManager GET:url
                                                   parameters:blockParams
                                                      success:successBlock
                                                      failure:failureBlock];
                }
                    break;
                case eRequestTypePost:
                {
                    urlConnectionOperation =
                    [weakSelf.requestOperationManager POST:url
                                                    parameters:blockParams
                                                       success:successBlock
                                                       failure:failureBlock];
                }
                    break;
                case eRequestTypePut:
                {
                    NSDictionary* mDic = nil;
                    if ([blockParams isKindOfClass:[NSDictionary class]]) {
                        NSDictionary* paramsDic = blockParams;
                        if ([paramsDic count] > 3) {
                            mDic = [blockParams mutableCopy];
                        }
                    }
                    
                    NSString* composedUrl = url;
                    if (mDic == nil) {
                        composedUrl = [self composeUrl:url WithStringParamters:blockParams];
                    }
                    
                    urlConnectionOperation = 
                    [weakSelf.requestOperationManager PUT:composedUrl
                                                parameters:mDic
                                                   success:successBlock
                                                   failure:failureBlock];
                }
                    break;
                case eRequestMutipartFormDataPost:
                {
                    NSData* fileData = [blockParams objectForKey:MUTIPART_FORM_DATA_KEY];
                    NSString* name = [blockParams objectForKey:MUTIPART_FORM_DATA_NAME_KEY];
                    NSString* fileName = [blockParams objectForKey:MUTIPART_FORM_DATA_FILE_NAME_KEY];
                    NSString* mimeType = [blockParams objectForKey:MUTIPART_FORM_DATA_MIME_TYPE_KEY];
                    [weakSelf.requestOperationManager POST:url
                                                parameters:nil
                                 constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                                     [formData appendPartWithFileData:fileData
                                                                 name:name
                                                             fileName:fileName
                                                             mimeType:mimeType];
                                 }
                                                   success:successBlock
                                                   failure:failureBlock];
                }
                    break;
                case eRequestTypeDelete:
                {
                    urlConnectionOperation =
                    [weakSelf.requestOperationManager DELETE:url parameters:blockParams success:successBlock failure:failureBlock];
                }
                    break;
                    
                default:
                    break;
            }
            
            urlConnectionOperation.userInfo = mDic;
        }
    });
}

- (NSString*)composeUrl:(NSString*)url WithStringParamters:(NSDictionary*)params
{
    NSMutableString* mString = [NSMutableString stringWithString:url];
    BOOL firstOne = YES;
    for (NSString* key in [params allKeys]) {
        if (firstOne) {
            [mString appendString:@"?"];
            firstOne = NO;
        }
        else
        {
            [mString appendString:@"&"];
        }
        
        NSString* value = [params objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            value = [value urlEncodeString];
        }
        [mString appendFormat:@"%@=%@", key, value];
    }
    
    return mString;
}

- (AFHTTPRequestOperation *)operationWithMsgId:(NSInteger)msgId
{
    NSArray *operations = [self.requestOperationManager.operationQueue operations];
    if ([operations count] > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.userInfo.msgIdKey == %@", @(msgId)];
        NSArray *array = [operations filteredArrayUsingPredicate:predicate];
        return [array lastObject];
    }
    
    return nil;
}

- (NSString*)urlWithInterfaceInfo:(DYInterfaceInfo*)interfaceInfo
{
    return [NSString stringWithFormat:@"%@%@", self.basicUrl , interfaceInfo.subUrl];
}

- (instancetype)init
{
    NSAssert(nil, @"请调用 initWithUrl: 来初始化对象");
    return nil;
}

- (instancetype)initWithUrl:(NSString*)url
{
    self = [super init];
    if (self) {
        if ([url length] > 0) {
            self.basicUrl = url;
        }
        else
        {
            NSAssert(nil, @"url 无效");
        }
        
        [self setupRequestOperationManager];
        [self setupNetWorkProcessingQueue];
    }
    return self;
}

- (void)setAccessToken:(NSString*)accessToken
{
    if ([accessToken length] > 0) {
        NSString* accessTokenWithHeader = [NSString stringWithFormat:@"Bearer %@", accessToken];
        NSLog(@"accessToken %@", accessTokenWithHeader);
        [self.requestOperationManager.requestSerializer setValue:accessTokenWithHeader forHTTPHeaderField:@"Authorization"];
    }
    else
    {
        [self.requestOperationManager.requestSerializer setValue:nil forHTTPHeaderField:@"Authorization"];
    }
}

- (void)setupRequestOperationManager
{
    //
}

- (void)setupNetWorkProcessingQueue
{
    self.networkProcessingQueue = dispatch_queue_create("com.network.jgrequest", NULL);
    __weak __typeof(self)weakSelf = self;
    dispatch_async(self.networkProcessingQueue, ^{

        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        [weakSelf.requestOperationManager.operationQueue setMaxConcurrentOperationCount:MAX_CONCURRENT_OPERATION_COUNT];
    });
}

- (NSString *)stringWithInterfaceInfo:(DYInterfaceInfo*)interfaceinfo
{
    NSString *requestTypeString = nil;
    switch (interfaceinfo.requestType) {
        case eRequestTypeGet:
            requestTypeString = @"GET";
            break;
        case eRequestTypePost:
            requestTypeString = @"POST";
            break;
        case eRequestTypePut:
            requestTypeString = @"PUT";
            break;
        case eRequestMutipartFormDataPost:
            requestTypeString = @"mutipart-form-data post";
            break;
        case eRequestTypeDelete:
            requestTypeString = @"DELETE";
            break;
        default:
            requestTypeString = @"Unknown";
            break;
    }
    return [NSString stringWithFormat:@"接口【%@】%@", requestTypeString, interfaceinfo.comment];
}

@end
