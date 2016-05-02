//
//  OrderFooterView.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/5/2.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderFooterView : UIView

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
+ (instancetype)createView;

@end
