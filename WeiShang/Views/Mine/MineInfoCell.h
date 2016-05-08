//
//  MineInfoCell.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/5/8.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mineAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *mineNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mineLevelLabel;
@end
