//
//  OrderHeaderView.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/30.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;

+ (instancetype)createView;

@end
