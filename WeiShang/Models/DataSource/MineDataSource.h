//
//  MineDataSource.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/5/8.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "DYDataSourceBase.h"

@interface MineDataSource : DYDataSourceBase

/**
 *	@brief	登陆
 *
 *	@param 	uid 	登陆使用的UID
 *	@param 	resultBlock 	接收返回值的block
 */
- (void)loginWithUID:(NSString*)uid withResultBlock:(DYInterfaceResultBlock)resultBlock;

@end
