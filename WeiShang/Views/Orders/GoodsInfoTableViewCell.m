//
//  GoodsInfoTableViewCell.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/30.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "GoodsInfoTableViewCell.h"

@implementation GoodsInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)subButtonClicked:(id)sender {
    NSString* sCount = self.stepperCountLabel.text;
    NSInteger nCount = [sCount integerValue];
    nCount --;
    self.stepperCountLabel.text = [NSString stringWithFormat:@"%ld", (long)nCount];
}
- (IBAction)addButtonClicked:(id)sender {
    NSString* sCount = self.stepperCountLabel.text;
    NSInteger nCount = [sCount integerValue];
    nCount ++;
    self.stepperCountLabel.text = [NSString stringWithFormat:@"%ld", (long)nCount];
}
@end
