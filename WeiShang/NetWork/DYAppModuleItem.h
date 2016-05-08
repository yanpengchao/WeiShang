//
//  DYAppModuleItem.h
//  IntelligenceResearchReport
//
//  Created by datayes on 15/10/22.
//  Copyright © 2015年 datayes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYInterfaceInfo.h"

REP_COLLECTION_TYPE(DYAppModuleItem)

@interface DYAppModuleItem : NSObject

/**
 *	@brief	模块名称
 */
@property (nonatomic, strong)NSString* moduleName;

/**
 *	@brief	模块接口起始Id名称
 */
@property (nonatomic, strong)NSNumber* startIndex;

/**
 *	@brief	接口信息列表
 */
@property (nonatomic, strong)NSArray<DYInterfaceInfo>* interfaces;

@end
