//
//  DYErrorHelper.m
//  IntelligenceResearchReport
//
//  Created by datayes on 15/8/11.
//  Copyright (c) 2015年 datayes. All rights reserved.
//

#import "DYErrorHelper.h"
#import "PromptView.h"

NSString* const kNetWorkingErrorDomain = @"com.networking.error";
NSString* const kCodingErrorDomain = @"com.coding.error";
NSString* const kParameterErrorDomain = @"com.paramter.error";
NSString* const kAuthorityrErrorDomain = @"com.authority.error";
NSString* const kInterfaceDataError = @"com.interfaceData.error";
NSString* const kRequestError = @"com.request.error";

@implementation DYErrorHelper

+ (void)dealWithError:(NSError*)error
{
    if ([error.domain isEqualToString:NSURLErrorDomain]) {
        if (error.code != NSURLErrorCancelled) {
            [PromptView showWithPrompt:@"网络不给力，请稍后再试"];
        }
    }
    else if (error.code == kCFURLErrorBadServerResponse)
    {
        [PromptView showWithPrompt:@"网络不给力，请稍后再试"];
    }
    else
    {
        [PromptView showWithPrompt:@"网络不给力，请稍后再试"];
    }
}

+ (BOOL)checkIfNeedRefreshAccessTokenWith:(id)data
{
    if ([data isKindOfClass:[NSDictionary class]]) {
        if ([data[@"errorcode"] intValue] == NeedLogin ||
            [data[@"code"] intValue] == NeedLogin) {
            return YES;
        }
    }
    
    return NO;
}
@end
