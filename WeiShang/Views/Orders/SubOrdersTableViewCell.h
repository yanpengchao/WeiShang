//
//  SubOrdersTableViewCell.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/18.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubOrdersTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsCarriageLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsStateDetailLabel;

@property (weak, nonatomic) IBOutlet UIButton *takeBackButton;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@end
