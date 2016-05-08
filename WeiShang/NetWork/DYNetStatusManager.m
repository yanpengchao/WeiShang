//
//  DYNetStatusManager.m
//  IntelligenceResearchReport
//
//  Created by datayes on 15/10/23.
//  Copyright © 2015年 datayes. All rights reserved.
//

#import "DYNetStatusManager.h"
#import "PromptView.h"

static DYNetStatusManager* gNetStatusManager = nil;

@implementation DYNetStatusManager

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gNetStatusManager = [[DYNetStatusManager alloc] init];
    });
    
    return gNetStatusManager;
}

- (BOOL)isNetWorkAvaliable
{
    return !self.isStatusValid || self.netWorkStatus == AFNetworkReachabilityStatusReachableViaWWAN || self.netWorkStatus == AFNetworkReachabilityStatusReachableViaWiFi;
}

- (BOOL)netWorkIsWifi
{
    return self.netWorkStatus == AFNetworkReachabilityStatusReachableViaWiFi;
}

- (void)startMonitorNetWork
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    __weak __typeof(self)weakSelf = self;
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        weakSelf.netWorkStatus = status;
        weakSelf.isStatusValid = YES;
        
        if (status == AFNetworkReachabilityStatusNotReachable || status ==AFNetworkReachabilityStatusUnknown) {
            [PromptView showWithPrompt:@"网络正在开小差，请稍后再试!"];
        }
        else {
            [[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_ENABLE_NOTIFY object:nil];
        }
    }];
}

@end
