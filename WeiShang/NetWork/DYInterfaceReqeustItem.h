//
//  DYInterfaceReqeustItem.h
//  IntelligenceResearchReport
//
//  Created by datayes on 16/2/2.
//  Copyright © 2016年 datayes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYInterfaceIdDef.h"
#import "DYInterfaceRequestHelper.h"

@interface DYInterfaceReqeustItem : NSObject

@property (nonatomic)EInterfaceId msgId;
@property (nonatomic, strong)id params;
@property (nonatomic)BOOL usingCacheFlag;
@property (nonatomic)BOOL reloadFlag;
@property (nonatomic)BOOL showError;
@property (nonatomic, strong)DYInterfaceResultBlock resultBlock;

@end
