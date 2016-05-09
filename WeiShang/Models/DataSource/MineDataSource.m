//
//  MineDataSource.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/5/8.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "MineDataSource.h"

@implementation MineDataSource

- (void)loginWithUID:(NSString*)uid withResultBlock:(DYInterfaceResultBlock)resultBlock
{
    [self sendRequestWithMsgId:eLogin parameters:nil resultBlock:^(id data, NSError *error, id requestInfo) {
        dispatch_async(dispatch_get_main_queue(), ^{
            resultBlock(data, error, requestInfo);
        });
    }];
}

@end
