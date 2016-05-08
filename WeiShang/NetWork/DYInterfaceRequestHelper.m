//
//  DYInterfaceRequestHelper.m
//  IntelligenceResearchReport
//
//  Created by datayes on 15/10/21.
//  Copyright © 2015年 datayes. All rights reserved.
//

#import "DYInterfaceRequestHelper.h"
#import "DYInterfacePropertiesManager.h"
#import "DYJsonRequestWithJsonResponseRequest.h"
#import "DYNetStatusManager.h"
#import "DYErrorHelper.h"
#import "DYInterfaceReqeustItem.h"
#import "PromptView.h"

static DYInterfaceRequestHelper* gInterfaceRequestHelper;

@interface DYInterfaceRequestHelper ()

@property (nonatomic, strong)NSMutableArray* mResumeRequestItemArray;

@end

@implementation DYInterfaceRequestHelper

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gInterfaceRequestHelper = [[DYInterfaceRequestHelper alloc] init];
    });
    
    return gInterfaceRequestHelper;
}

+ (NSString*)dataInfoInterfaceBasicUrl
{
#ifdef BUILD_FOR_DEV
    return [DYInterfacePropertiesManager shareInstance].devBaseUrl;
#endif
#ifdef BUILD_FOR_QA
    return [DYInterfacePropertiesManager shareInstance].qaBaseUrl;
#endif
#ifdef BUILD_FOR_STAGE
    return [DYInterfacePropertiesManager shareInstance].stageBaseUrl;
#endif
#ifdef BUILD_FOR_PRODUCT
    return [DYInterfacePropertiesManager shareInstance].productBaseUrl;
#endif
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupRequesters];
    }
    
    return self;
}

- (void)setupRequesters
{
    NSString* basicUrl = [DYInterfaceRequestHelper dataInfoInterfaceBasicUrl];
    self.dataInfoRequest = [[DYJsonRequestWithJsonResponseRequest alloc] initWithUrl:basicUrl];
}

- (void)sendRequestWithMsgId:(EInterfaceId)msgId
                  parameters:(id)params
               canUsingCache:(BOOL)usingCacheFlag
                 forceReload:(BOOL)reloadFlag
 showNetWorkUnAvaliableError:(BOOL)showError
                 resultBlock:(DYInterfaceResultBlock)resultBlock
{
    __block DYInterfaceReqeustItem* item = [self createRequestInfoItemWithMsgId:msgId
                                                                     parameters:params
                                                                  canUsingCache:usingCacheFlag
                                                                    forceReload:reloadFlag
                                                    showNetWorkUnAvaliableError:showError
                                                                    resultBlock:resultBlock];
    
    if (![DYNetStatusManager shareInstance].isNetWorkAvaliable)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 0.1f* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (showError) {
                [PromptView showWithPrompt:@"网络正在开小差，请稍后再试!"];
            }
            
            resultBlock(nil, [NSError errorWithDomain:kNetWorkingErrorDomain code:NetAccessError userInfo:nil], item);
        });
        
    }
    
    DYInterfaceInfo* interfaceInfo = [DYInterfacePropertiesManager interfaceInfoWithInterfaceId:msgId];
    DYInterfaceRequesterBase* dealRequester = nil;
    if (interfaceInfo != nil) {
        switch (interfaceInfo.needAuthInfoType) {
            case eNeedNoAuthInfo:
                dealRequester = self.dataInfoRequest;
                break;
            default:
                break;
        }
        
        if (dealRequester != nil) {
            [dealRequester sendRequestWithMsgId:msgId
                                     parameters:params
                                  canUsingCache:usingCacheFlag
                                    forceReload:reloadFlag
                                    resultBlock:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    resultBlock(data, nil, item);
                }
                else
                {
                    resultBlock(data, error, item);
                }
            }];
        }
    }
}

- (NSMutableArray*)mResumeRequestItemArray
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mResumeRequestItemArray = [[NSMutableArray alloc] init];
    });
    
    return _mResumeRequestItemArray;
}

- (void)addRequestIntoResumeQueueWithMsgId:(EInterfaceId)msgId
                                parameters:(id)params
                             canUsingCache:(BOOL)usingCacheFlag
                               forceReload:(BOOL)reloadFlag
               showNetWorkUnAvaliableError:(BOOL)showError
                               resultBlock:(DYInterfaceResultBlock)resultBlock
{
    DYInterfaceReqeustItem* item = [self createRequestInfoItemWithMsgId:msgId
                                                             parameters:params
                                                          canUsingCache:usingCacheFlag
                                                            forceReload:reloadFlag
                                            showNetWorkUnAvaliableError:showError
                                                            resultBlock:resultBlock];
    
    [self.mResumeRequestItemArray addObject:item];
}

- (DYInterfaceReqeustItem*)createRequestInfoItemWithMsgId:(EInterfaceId)msgId
                                               parameters:(id)params
                                            canUsingCache:(BOOL)usingCacheFlag
                                              forceReload:(BOOL)reloadFlag
                              showNetWorkUnAvaliableError:(BOOL)showError
                                              resultBlock:(DYInterfaceResultBlock)resultBlock
{
    DYInterfaceReqeustItem* item = [[DYInterfaceReqeustItem alloc] init];
    item.msgId = msgId;
    item.params = params;
    item.usingCacheFlag = usingCacheFlag;
    item.reloadFlag = reloadFlag;
    item.showError = showError;
    item.resultBlock = resultBlock;
    
    return item;
}

- (void)resumeAllRequstNeedToBeResume
{
    @synchronized(self.mResumeRequestItemArray) {
        NSUInteger count = [self.mResumeRequestItemArray count];
        for (NSUInteger i = 0 ; i < count ; i ++) {
            DYInterfaceReqeustItem* requestItem = self.mResumeRequestItemArray[0];
            [self sendRequestWithMsgId:requestItem.msgId
                            parameters:requestItem.params
                         canUsingCache:requestItem.usingCacheFlag
                           forceReload:requestItem.reloadFlag
           showNetWorkUnAvaliableError:requestItem.showError
                           resultBlock:requestItem.resultBlock];
            [self.mResumeRequestItemArray removeObjectAtIndex:0];
        }
    }
}

@end
