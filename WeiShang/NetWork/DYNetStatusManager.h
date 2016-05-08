//
//  DYNetStatusManager.h
//  IntelligenceResearchReport
//
//  Created by datayes on 15/10/23.
//  Copyright © 2015年 datayes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"

#define NETWORK_ENABLE_NOTIFY   @"networkEnableNotify"

@interface DYNetStatusManager : NSObject
{
    //
}

/**
 *	@brief	网络状态是否已有效
 */
@property (nonatomic)BOOL isStatusValid;

/**
 *	@brief	当前网络状态
 */
@property (atomic)AFNetworkReachabilityStatus netWorkStatus;


/**
 *	@brief	获取认证token管理对象
 *
 *	@return	返回单例对象
 */
+ (instancetype)shareInstance;

/**
 *	@brief	当前网络是否可用
 *
 *	@return	返回YES表示可用，返回NO表示不可用
 */
- (BOOL)isNetWorkAvaliable;

/**
 *	@brief	当前网络是否为WIFI
 *
 *	@return	返回YES表示为WIFI网络，返回NO表示不是WIFI网络
 */
- (BOOL)netWorkIsWifi;

/**
 *	@brief	开始监听网络
 */
- (void)startMonitorNetWork;

@end
