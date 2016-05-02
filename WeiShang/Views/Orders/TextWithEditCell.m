//
//  TextWithEditCell.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/5/3.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "TextWithEditCell.h"

@implementation TextWithEditCell

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
    UINib *nib = [UINib nibWithNibName:@"TextWithEditCell" bundle:[NSBundle mainBundle]];
    NSArray *nibs = [nib instantiateWithOwner:nil options:nil];
    if ([nibs count] > 0) {
        return nibs[0];
    }
    return nil;
}

@end
