//
//  GoodsDAO.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/20.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "GoodsDAO.h"

@implementation GoodsDAO

+ (NSString*)stateStringWithState:(EGoodsState)state
{
    switch (state) {
        case eGoodsStateUnknown:
            return @"未知状态";
        case eGoodsStatePreChecking:
            return @"待审核";
        case eGoodsStateChecking:
            return @"审核中";
        case eGoodsStateChecked:
            return @"审核完成";
        case eGoodsStatePrePay:
            return @"等待付款";
        case eGoodsStatePayed:
            return @"付款成功";
        case eGoodsStatePreSend:
            return @"准备发货";
        case eGoodsStateSending:
            return @"正在发货";
        case eGoodsStateSent:
            return @"已发货";
        case eGoodsStatePreReceive:
            return @"正在配送";
        case eGoodsStateReceived:
            return @"已收货";
        case eGoodsStateFinished:
            return @"已完成";
        default:
            break;
    }
    
    return @"未知状态";
}

@end
