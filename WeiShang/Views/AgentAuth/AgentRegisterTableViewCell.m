//
//  AgentRegisterTableViewCell.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/17.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "AgentRegisterTableViewCell.h"

@implementation AgentRegisterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)createCell
{
    UINib *nib = [UINib nibWithNibName:@"AgentRegisterTableViewCell" bundle:[NSBundle mainBundle]];
    NSArray *nibs = [nib instantiateWithOwner:nil options:nil];
    if ([nibs count] > 0) {
        return nibs[0];
    }
    return nil;
}
@end
