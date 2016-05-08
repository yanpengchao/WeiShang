//
//  DYHttpRequestWithCacheOperationManager.m
//  IntelligenceResearchReport
//
//  Created by datayes on 16/3/2.
//  Copyright © 2016年 datayes. All rights reserved.
//

#import "DYHttpRequestWithCacheOperationManager.h"

@implementation DYHttpRequestWithCacheOperationManager

- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request
                                                    success:(void (^)(AFHTTPRequestOperation *operation,
                                                                      id responseObject))success
                                                    failure:(void (^)(AFHTTPRequestOperation *operation,
                                                                      NSError *error))failure
{
    NSMutableURLRequest *modifiedRequest = request.mutableCopy;
    AFNetworkReachabilityManager *reachability = self.reachabilityManager;
    if (!reachability.isReachable)
    {
        modifiedRequest.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    }
    
    AFHTTPRequestOperation *operation = [super HTTPRequestOperationWithRequest:modifiedRequest
                                                                       success:success
                                                                       failure:failure];
    
    [operation setCacheResponseBlock: ^NSCachedURLResponse *(NSURLConnection *connection,
                                                             NSCachedURLResponse *cachedResponse)
     {
         NSURLResponse *response = cachedResponse.response;
         if (![response isKindOfClass:NSHTTPURLResponse.class])
             return cachedResponse;
         
         NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse*)response;
         NSDictionary *headers = HTTPResponse.allHeaderFields;
         if (headers[@"Cache-Control"] != nil)
             return cachedResponse;
         
         NSMutableDictionary *modifiedHeaders = headers.mutableCopy;
         
         //获取到plist里定义的cacheExpireTime，默认为0，即不缓存
         if (self.cacheExpireTime > 0) {
             modifiedHeaders[@"Cache-Control"] = [NSString stringWithFormat:@"max-age=%lu", (unsigned long)self.cacheExpireTime];
         }else{
             modifiedHeaders[@"Cache-Control"] = [NSString stringWithFormat:@"no-cache"];
         }
         
         
         NSHTTPURLResponse *modifiedResponse = [[NSHTTPURLResponse alloc]
                                                initWithURL:HTTPResponse.URL
                                                statusCode:HTTPResponse.statusCode
                                                HTTPVersion:@"HTTP/1.1"
                                                headerFields:modifiedHeaders];
         
         cachedResponse = [[NSCachedURLResponse alloc]
                           initWithResponse:modifiedResponse
                           data:cachedResponse.data
                           userInfo:cachedResponse.userInfo
                           storagePolicy:cachedResponse.storagePolicy];
         return cachedResponse;
     }];
    
    return operation;
}

@end
