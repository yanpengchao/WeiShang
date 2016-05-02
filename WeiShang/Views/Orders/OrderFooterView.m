//
//  OrderFooterView.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/5/2.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "OrderFooterView.h"

@implementation OrderFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)createView
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"OrderFooterView" owner:nil options:nil];
    return [nibContents lastObject];
}

@end
