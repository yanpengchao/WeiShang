//
//  DYJsonRequestWithJsonResponseRequest.m
//  IntelligenceResearchReport
//
//  Created by datayes on 15/10/20.
//  Copyright © 2015年 datayes. All rights reserved.
//

#import "DYJsonRequestWithJsonResponseRequest.h"
#import "AFHTTPRequestOperationManager.h"

#define TIMEOUT_VALUE       30.0f                               // 超时时长

@implementation DYJsonRequestWithJsonResponseRequest

- (void)setupRequestOperationManager
{
    self.requestOperationManager = [[DYHttpRequestWithCacheOperationManager alloc] init];
    self.requestOperationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.requestOperationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [self.requestOperationManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.requestOperationManager.requestSerializer.timeoutInterval = TIMEOUT_VALUE;
    [self.requestOperationManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    self.requestOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.requestOperationManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", nil]];
}

@end
