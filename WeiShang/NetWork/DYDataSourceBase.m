//
//  DYDataSourceBase.m
//  IntelligenceResearchReport
//
//  Created by datayes on 15/8/19.
//  Copyright (c) 2015年 datayes. All rights reserved.
//

#import "DYDataSourceBase.h"
#import "DYInterfaceRequestHelper.h"

@implementation DYDataSourceBase

- (void)sendRequestWithMsgId:(EInterfaceId)msgId
                  parameters:(id)params
               canUsingCache:(BOOL)usingCacheFlag
                 forceReload:(BOOL)reloadFlag
 showNetWorkUnAvaliableError:(BOOL)showError
                 resultBlock:(DYInterfaceResultBlock)resultBlock
{
    [[DYInterfaceRequestHelper shareInstance] sendRequestWithMsgId:msgId
                                                        parameters:params
                                                     canUsingCache:usingCacheFlag
                                                       forceReload:reloadFlag
                                       showNetWorkUnAvaliableError:YES
                                                       resultBlock:resultBlock];
}

- (void)sendRequestWithMsgId:(EInterfaceId)msgId
                  parameters:(id)params
                 resultBlock:(DYInterfaceResultBlock)resultBlock
{
    [self sendRequestWithMsgId:msgId
                    parameters:params
                 canUsingCache:YES
                   forceReload:NO
   showNetWorkUnAvaliableError:YES
                   resultBlock:resultBlock];
}

@end
