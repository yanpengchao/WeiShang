//
//  BasicAddressCell.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/5/3.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicAddressCell : UITableViewCell

@property (nonatomic, weak)IBOutlet UILabel* addressLabel;
@property (nonatomic, weak)IBOutlet UILabel* nameLabel;
@property (nonatomic, weak)IBOutlet UILabel* phoneNumberLabel;
@property (nonatomic, weak)IBOutlet UIButton* editButton;

@end
