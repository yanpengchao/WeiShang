//
//  DYDataSourceBase.h
//  IntelligenceResearchReport
//
//  Created by datayes on 15/8/19.
//  Copyright (c) 2015年 datayes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYInterfaceIdDef.h"
#import "DYInterfaceRequestHelper.h"

@interface DYDataSourceBase : NSObject

- (void)sendRequestWithMsgId:(EInterfaceId)msgId
                  parameters:(id)params
               canUsingCache:(BOOL)usingCacheFlag
                 forceReload:(BOOL)reloadFlag
 showNetWorkUnAvaliableError:(BOOL)showError
                 resultBlock:(DYInterfaceResultBlock)resultBlock;

- (void)sendRequestWithMsgId:(EInterfaceId)msgId
                  parameters:(id)params
                 resultBlock:(DYInterfaceResultBlock)resultBlock;

@end
