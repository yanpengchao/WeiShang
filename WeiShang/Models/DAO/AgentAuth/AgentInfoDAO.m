//
//  AgentInfoDAO.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/17.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "AgentInfoDAO.h"

@implementation AgentInfoDAO

+ (NSString*)stateTextWithState:(EAgentState)state
{
    switch (state) {
        case eAgentStateUnknown:
            return @"未知状态";
        case eAgentStateNotAuth:
            return @"未授权";
        case eAgentStateAuth:
            return @"已授权";
        default:
            break;
    }
    
    return @"未知状态";
}

+ (NSString*)levelTextWithLevel:(EAgentLevel)level
{
    switch (level) {
        case eAgentLevelUnknown:
            return @"未知等级";
        case eAgentLevelNormal:
            return @"普通等级";
        case eAgentLevelCu:
            return @"青铜级";
        case eAgentLevelAg:
            return @"白银级";
        case eAgentLevelAu:
            return @"黄金级";
        case eAgentLevelDiamond:
            return @"钻石级";
        default:
            break;
    }
    
    return @"";
}

+ (NSString*)levelImageWithLevel:(EAgentLevel)level
{
    switch (level) {
        case eAgentLevelUnknown:
            return @"unknownLevel";
        case eAgentLevelNormal:
            return @"normalLevel";
        case eAgentLevelCu:
            return @"cu";
        case eAgentLevelAg:
            return @"ag";
        case eAgentLevelAu:
            return @"au";
        case eAgentLevelDiamond:
            return @"diamond";
        default:
            break;
    }
    
    return @"unknownLevel";
}

@end
