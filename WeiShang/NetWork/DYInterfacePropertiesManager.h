//
//  DYInterfacePropertiesManager.h
//  IntelligenceResearchReport
//
//  Created by datayes on 15/10/22.
//  Copyright © 2015年 datayes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYAppModuleItem.h"
#import "DYInterfaceIdDef.h"

@interface DYInterfacePropertiesManager : NSObject

/**
 *	@brief	开发环境BaseUrl
 */
@property (nonatomic, strong)NSString* devBaseUrl;

/**
 *	@brief	测试环境BaseUrl
 */
@property (nonatomic, strong)NSString* qaBaseUrl;

/**
 *	@brief	仿真环境BaseUrl
 */
@property (nonatomic, strong)NSString* stageBaseUrl;

/**
 *	@brief	线上环境BaseUrl
 */
@property (nonatomic, strong)NSString* productBaseUrl;

/**
 *	@brief	接口参数列表
 */
@property (nonatomic, strong)NSArray<DYAppModuleItem>* interfaceModules;

+ (instancetype)shareInstance;
+ (DYInterfaceInfo*)interfaceInfoWithInterfaceId:(EInterfaceId)msgId;

@end
