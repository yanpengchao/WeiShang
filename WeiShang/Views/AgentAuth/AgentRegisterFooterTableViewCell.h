//
//  AgentRegisterFooterTableViewCell.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/17.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgentRegisterFooterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
+ (instancetype)createCell;

@end
