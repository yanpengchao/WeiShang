//
//  EditOrderFooterView.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/5/3.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "EditOrderFooterView.h"

@implementation EditOrderFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)createView
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"EditOrderFooterView" owner:nil options:nil];
    EditOrderFooterView* footerView = [nibContents lastObject];
    footerView.commitButton.layer.shadowOffset = CGSizeMake(0, 1);
    footerView.commitButton.layer.shadowOpacity = 0.50;
    
    return footerView;
}

@end
