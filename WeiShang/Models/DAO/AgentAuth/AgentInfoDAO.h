//
//  AgentInfoDAO.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/17.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "BasicDAO.h"

typedef NS_ENUM(NSUInteger, EAgentState) {
    eAgentStateUnknown = 0,             // 未知
    eAgentStateNotAuth,                 // 未授权
    eAgentStateAuth,                    // 已授权
};

typedef NS_ENUM(NSUInteger, EAgentLevel) {
    eAgentLevelUnknown = 0,             // 未知
    eAgentLevelNormal,                  // 普通会员
    eAgentLevelCu,                      // 铜牌会员
    eAgentLevelAg,                      // 银牌会员
    eAgentLevelAu,                      // 金牌会员
    eAgentLevelDiamond,                 // 钻石会员
};

@interface AgentInfoDAO : BasicDAO

/**
 *	@brief	代理Id
 */
@property (nonatomic, strong)NSString* agentId;

/**
 *	@brief	代理名称
 */
@property (nonatomic, strong)NSString* name;

/**
 *	@brief	代理头像URL
 */
@property (nonatomic, strong)NSString* avatarImageUrl;

/**
 *	@brief	代理状态
 */
@property (nonatomic)EAgentState agentState;

/**
 *	@brief	代理等级
 */
@property (nonatomic)EAgentLevel agentLevel;

/**
 *	@brief	根据状态获取状态描述
 *
 *	@param 	state 	状态
 *
 *	@return	状态描述
 */
+ (NSString*)stateTextWithState:(EAgentState)state;

/**
 *	@brief	根据等级返回等级描述
 *
 *	@param 	level 	等级
 *
 *	@return	等级描述
 */
+ (NSString*)levelTextWithLevel:(EAgentLevel)level;

/**
 *	@brief	根据等级返回等级图片代号
 *
 *	@param 	level 	等级
 *
 *	@return	图片代号
 */
+ (NSString*)levelImageWithLevel:(EAgentLevel)level;

@end
