//
//  GoodsInfoTableViewCell.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/30.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *goodsUnitSegmentedControl;
@property (weak, nonatomic) IBOutlet UIView *stepperRootView;
@property (weak, nonatomic) IBOutlet UIButton *stepperSubButton;
@property (weak, nonatomic) IBOutlet UIButton *stepperAddButton;
@property (weak, nonatomic) IBOutlet UILabel *stepperCountLabel;
@end
