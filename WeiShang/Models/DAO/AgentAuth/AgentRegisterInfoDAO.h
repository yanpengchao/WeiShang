//
//  AgentRegisterInfoDAO.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/17.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "BasicDAO.h"

@interface AgentRegisterInfoDAO : BasicDAO

/**
 *	@brief	姓名
 */
@property (nonatomic, strong)NSString* name;

/**
 *	@brief	手机
 */
@property (nonatomic, strong)NSString* mobilePhone;

/**
 *	@brief	身份证号
 */
@property (nonatomic, strong)NSString* identity;

/**
 *	@brief	微信号
 */
@property (nonatomic, strong)NSString* weixin;

/**
 *	@brief	QQ
 */
@property (nonatomic, strong)NSString* qq;

/**
 *	@brief	地址
 */
@property (nonatomic, strong)NSString* address;

/**
 *	@brief	身份证
 */
@property (nonatomic, strong)NSString* image;

@end
