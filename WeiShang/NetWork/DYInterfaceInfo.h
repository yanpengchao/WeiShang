//
//  DYInterfaceInfo.h
//  IntelligenceResearchReport
//
//  Created by datayes on 15/8/10.
//  Copyright (c) 2015年 datayes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Representation.h"

typedef NS_ENUM(NSInteger, ERequestType) {
    eRequestTypeUnkown = 0,                     // 0 未知类型
    eRequestTypeGet = eRequestTypeUnkown,       // 0 GET方式上传数据
    eRequestTypePost,                           // 1 POST方式上传数据
    eRequestTypePut,                            // 2 PUT方式上传数据
    eRequestMutipartFormDataPost,               // 3 mutipart-form data
    eRequestTypeDelete,                         // 4 DELETE方式上传数据

};

typedef NS_ENUM(NSInteger, EResponseBodyTiedType) {
    eResponseBodyTiedTypeUnkown = 0,                            // 返回数据为未知数据格式，默认为json
    eResponseBodyTiedTypeJson = eResponseBodyTiedTypeUnkown,    // JSON格式
    eResponseBodyTiedTypeGBuf,                                  // GBuf格式
    eResponseBodyTiedTypeXml,                                   // XML格式
};

typedef NS_ENUM(NSInteger, ENeedAuthInfoType) {
    eNeedNoAuthInfo = 0,        // 不需要认证信息
    eNeedAuthInfo,              // 需要认证信息
    eNeedAuthInfoIfLogin,       // 如果登录了，则需要认证信息；未登录，不需要
    eIamAuthInfo,               // 我就是获取认证信息的接口
    eNotifyInfo,                // 获取站内信（通知）
    eAppPushInfo,               // 我就是App推送的接口
    eCMSInfo,                   // cms的接口
    eCMSNeedAutoInfo,           // cms需要认证的接口
    eAddMutipartData,           // 为笔记增加图片
};

#define MUTIPART_FORM_DATA_MIME_TYPE_KEY        @"mutipart_form_data_mime_type_key"
#define MUTIPART_FORM_DATA_NAME_KEY             @"mutipart_form_data_name_key"
#define MUTIPART_FORM_DATA_FILE_NAME_KEY        @"mutipart_form_data_file_name_key"
#define MUTIPART_FORM_DATA_KEY                  @"mutipart_form_data_key"

REP_COLLECTION_TYPE(DYInterfaceInfo)

@interface DYInterfaceInfo : NSObject

/**
 *	@brief	路径
 */
@property (nonatomic, strong)NSString* subUrl;

/**
 *	@brief	请求类型
 */
@property (nonatomic)ERequestType requestType;

/**
 *	@brief	返回值数据类型
 */
@property (nonatomic)EResponseBodyTiedType responseBodyTiedType;

/**
 *	@brief	返回数据的载体类（Json或Xml）或解析类（GBuf）
 */
@property (nonatomic, strong)NSString* parseClass;

/**
 *	@brief	接口说明
 */
@property (nonatomic, strong)NSString* comment;

/**
 *	@brief	是否允许多个请求一起发起
 */
@property (nonatomic)BOOL allowMutableRequest;

/**
 *	@brief	是否需要使用认证信息
 */
@property (nonatomic)ENeedAuthInfoType needAuthInfoType;

/**
 *	@brief	处理错误的类名
 */
@property (nonatomic, strong)NSString* errorHandlerClass;

/**
 *	@brief	接口版本号
 */
@property (nonatomic, strong)NSString* version;

/**
 *	@brief	缓存过期时间，默认为0，即不缓存
 */
@property (nonatomic) NSUInteger cacheExpireTime;

/**
 *	@brief	接口版本号
 */
@property (nonatomic) NSString *apiVersion;


@end
