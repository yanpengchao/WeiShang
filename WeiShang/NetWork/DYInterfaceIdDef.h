//
//  DYInterfaceIdDef.h
//  IntelligenceResearchReport
//
//  Created by datayes on 15/10/21.
//  Copyright © 2015年 datayes. All rights reserved.
//

#ifndef DYInterfaceIdDef_h
#define DYInterfaceIdDef_h

typedef NS_ENUM(NSUInteger, EInterfaceId) {
    // ------------------------------------------------我的
    eLogin = 0,                         // 登录
    eGC,                                // 通用代码接口
    
    // ------------------------------------------------产品
    eGetProductList = 100,              // 获取产品列表
    eGetProductDetail,                  // 获取产品详情
    
    // ------------------------------------------------代理
    eGetAgentList = 200,                // 代理商列表
    eGetAgentDetail,                    // 读取单个代理商数据
    eSaveAgent,                         // 代理商保存
    eUploadID,                          // 身份证上传
    eDeleteAgent,                       // 代理商删除
    
    // ------------------------------------------------订单
    eGetOrdersList = 300,               // 订单列表
    
    // ------------------------------------------------新闻
    eGetNewsList = 400,                 // 获取文章列表
    eGetNewsContent,                    // 获取文章内容
    
    eMaxInterfaceID                     // 最大ID，所有ID都不会大于这个值
};

#endif /* DYInterfaceIdDef_h */
