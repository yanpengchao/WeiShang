//
//  BaseOrderDAO.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/20.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "BasicDAO.h"

typedef NS_ENUM(NSUInteger, EOrderState) {
    eOrderStateUnknown = 0,     // 未知状态
    eOrderStatePreChecking,     // 待审核
    eOrderStateChecking,        // 审核中
    eOrderStateChecked,         // 审核完成
    eOrderStatePrePay,          // 等待付款
    eOrderStatePayed,           // 付款成功
    eOrderStatePreSend,         // 准备发货
    eOrderStateSending,         // 正在发货
    eOrderStateSent,            // 已发货
    eOrderStatePreReceive,      // 正在配送
    eOrderStateReceived,        // 已收货
    eOrderStateFinished,        // 已完成
};

@interface BaseOrderDAO : BasicDAO

/**
 *	@brief	订单Id
 */
@property (nonatomic, strong)NSString* orderId;

/**
 *	@brief	订单状态
 */
@property (nonatomic)EOrderState state;

/**
 *	@brief	订单包含的商品列表
 */
@property (nonatomic, strong)NSArray* goodsArray;

+ (NSString*)stateStringWithState:(EOrderState)state;

@end
