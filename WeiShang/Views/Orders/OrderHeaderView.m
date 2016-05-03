//
//  OrderHeaderView.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/30.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "OrderHeaderView.h"

@implementation OrderHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)createView
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"OrderHeaderView" owner:nil options:nil];
    OrderHeaderView* headerView = [nibContents lastObject];
    
    return headerView;
}

@end
