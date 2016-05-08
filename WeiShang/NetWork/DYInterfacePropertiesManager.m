//
//  DYInterfacePropertiesManager.m
//  IntelligenceResearchReport
//
//  Created by datayes on 15/10/22.
//  Copyright © 2015年 datayes. All rights reserved.
//

#import "DYInterfacePropertiesManager.h"

static DYInterfacePropertiesManager* gInterfacePropertiesManager = nil;

@implementation DYInterfacePropertiesManager

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gInterfacePropertiesManager = [DYInterfacePropertiesManager objectWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"interfaceUri" ofType:@"plist"]];
    });
    
    return gInterfacePropertiesManager;
    
}

+ (DYInterfaceInfo*)interfaceInfoWithInterfaceId:(EInterfaceId)msgId
{
    if (gInterfacePropertiesManager == nil) {
        DDLogError(@"未完成初始化，请先调用（initWithContentsOfFile:）方法完成初始化");
        return nil;
    }
    
    NSInteger moduleIndex = msgId/100;
    NSInteger interfaceIndex = msgId%100;
    
    if ([gInterfacePropertiesManager.interfaceModules count] > moduleIndex)
    {
        DYAppModuleItem* item = gInterfacePropertiesManager.interfaceModules[moduleIndex];
        if ([item.interfaces count] > interfaceIndex) {
            return item.interfaces[interfaceIndex];
        }
    }
    
    DDLogError(@"未从配置文件中找到msgId为：%ld的接口配置信息，请检查interfaceUri.plist文件", (long)msgId);
    
    return nil;
}

@end
