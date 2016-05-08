//
//  DYHttpRequestWithCacheOperationManager.h
//  IntelligenceResearchReport
//
//  Created by datayes on 16/3/2.
//  Copyright © 2016年 datayes. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface DYHttpRequestWithCacheOperationManager : AFHTTPRequestOperationManager

/**
 *	@brief	缓存过期时间，如果需要定制过期时间，请发起调用前设置该参数
 */
@property (nonatomic)NSUInteger cacheExpireTime;

@end
