//
//  BaseOrderDAO.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/20.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "BaseOrderDAO.h"

@implementation BaseOrderDAO

+ (NSString*)stateStringWithState:(EOrderState)state
{
    switch (state) {
        case eOrderStateUnknown:
            return @"未知状态";
        case eOrderStatePreChecking:
            return @"待审核";
        case eOrderStateChecking:
            return @"审核中";
        case eOrderStateChecked:
            return @"审核完成";
        case eOrderStatePrePay:
            return @"等待付款";
        case eOrderStatePayed:
            return @"付款成功";
        case eOrderStatePreSend:
            return @"准备发货";
        case eOrderStateSending:
            return @"正在发货";
        case eOrderStateSent:
            return @"已发货";
        case eOrderStatePreReceive:
            return @"正在配送";
        case eOrderStateReceived:
            return @"已收货";
        case eOrderStateFinished:
            return @"已完成";
        default:
            break;
    }
    
    return @"未知状态";
}

@end
