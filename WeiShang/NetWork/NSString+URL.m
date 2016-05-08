//
//  NSString+URL.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/5/8.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

- (NSString*)urlEncodeString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

- (NSString *)urlDecodedString
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8));
}

@end
