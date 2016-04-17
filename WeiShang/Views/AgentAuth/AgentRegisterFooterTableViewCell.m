//
//  AgentRegisterFooterTableViewCell.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/17.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "AgentRegisterFooterTableViewCell.h"

@implementation AgentRegisterFooterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.commitButton.layer.cornerRadius = 3;
    self.commitButton.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    self.imageButton.layer.borderWidth = 1;
    self.imageButton.layer.borderColor = [[UIColor colorWithRed:0.55 green:0.55 blue:0.55 alpha:1] CGColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)createCell
{
    UINib *nib = [UINib nibWithNibName:@"AgentRegisterFooterTableViewCell" bundle:[NSBundle mainBundle]];
    NSArray *nibs = [nib instantiateWithOwner:nil options:nil];
    if ([nibs count] > 0) {
        return nibs[0];
    }
    return nil;
}
@end
