//
//  DYInterfaceRequestHelper.h
//  IntelligenceResearchReport
//
//  Created by datayes on 15/10/21.
//  Copyright © 2015年 datayes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYInterfaceIdDef.h"

typedef void (^DYInterfaceResultBlock)(id data, NSError *error, id requestInfo);

@class DYInterfaceRequesterBase;

@interface DYInterfaceRequestHelper : NSObject

/**
 *	@brief	展示数据请求
 */
@property (nonatomic, strong)DYInterfaceRequesterBase* dataInfoRequest;


/**
 *	@brief	获取单例对象
 *
 *	@return	返回单例对象
 */
+ (instancetype)shareInstance;

/**
 *	@brief	获取展示数据请求的主URL
 *
 *	@return	返回url
 */
+ (NSString*)dataInfoInterfaceBasicUrl;


/**
 *	@brief	发送接口请求
 *
 *	@param 	msgId 	接口Id
 *	@param 	params 	上行参数
 *	@param 	usingCacheFlag 	是否启用缓存，YES为启用，NO为不启用
 *	@param 	reloadFlag 	是否忽略之前的请求，强制重新加载，YES为重新加载，NO则请求可能被忽略
 *	@param 	showError 	是否自动显示网络不通畅的错误
 *	@param 	resultBlock 	返回结果的block
 */
- (void)sendRequestWithMsgId:(EInterfaceId)msgId
                  parameters:(id)params
               canUsingCache:(BOOL)usingCacheFlag
                 forceReload:(BOOL)reloadFlag
 showNetWorkUnAvaliableError:(BOOL)showError
                 resultBlock:(DYInterfaceResultBlock)resultBlock;

/**
 *	@brief	将需要重发的接口参数先保存起来
 *
 *	@param 	msgId 	接口Id
 *	@param 	params 	上行参数
 *	@param 	usingCacheFlag 	是否启用缓存，YES为启用，NO为不启用
 *	@param 	reloadFlag 	是否忽略之前的请求，强制重新加载，YES为重新加载，NO则请求可能被忽略
 *	@param 	showError 	是否自动显示网络不通畅的错误
 *	@param 	resultBlock 	返回结果的block
 */
- (void)addRequestIntoResumeQueueWithMsgId:(EInterfaceId)msgId
                                parameters:(id)params
                             canUsingCache:(BOOL)usingCacheFlag
                               forceReload:(BOOL)reloadFlag
               showNetWorkUnAvaliableError:(BOOL)showError
                               resultBlock:(DYInterfaceResultBlock)resultBlock;

/**
 *	@brief	恢复所有需要重发的请求
 */
- (void)resumeAllRequstNeedToBeResume;

@end
