//
//  AgentInfoTableViewCell.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/17.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgentInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UIImageView *levelImageView;

@end
