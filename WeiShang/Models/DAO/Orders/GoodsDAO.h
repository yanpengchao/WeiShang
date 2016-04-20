//
//  GoodsDAO.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/20.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "BasicDAO.h"

typedef NS_ENUM(NSUInteger, EGoodsState) {
    eGoodsStateUnknown = 0,     // 未知状态
    eGoodsStatePreChecking,     // 待审核
    eGoodsStateChecking,        // 审核中
    eGoodsStateChecked,         // 审核完成
    eGoodsStatePrePay,          // 等待付款
    eGoodsStatePayed,           // 付款成功
    eGoodsStatePreSend,         // 准备发货
    eGoodsStateSending,         // 正在发货
    eGoodsStateSent,            // 已发货
    eGoodsStatePreReceive,      // 正在配送
    eGoodsStateReceived,        // 已收货
    eGoodsStateFinished,        // 已完成
};

@interface GoodsDAO : BasicDAO

/**
 *	@brief	商品Id
 */
@property (nonatomic, strong)NSString* goodsId;

/**
 *	@brief	商品图片链接
 */
@property (strong, nonatomic) NSString* imageUrl;

/**
 *	@brief	商品名称
 */
@property (strong, nonatomic) NSString* name;

/**
 *	@brief	商品单价
 */
@property (nonatomic) CGFloat price;

/**
 *	@brief	商品单位
 */
@property (nonatomic) NSString* unit;

/**
 *	@brief	商品状态
 */
@property (nonatomic) EGoodsState state;

/**
 *	@brief	商品运费
 */
@property (nonatomic) CGFloat carriage;

/**
 *	@brief	商品数量
 */
@property (nonatomic) CGFloat count;

/**
 *	@brief	商品状态详情
 */
@property (strong, nonatomic) NSString* stateDetail;

+ (NSString*)stateStringWithState:(EGoodsState)state;

@end
