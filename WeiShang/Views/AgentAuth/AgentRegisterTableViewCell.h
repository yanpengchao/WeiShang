//
//  AgentRegisterTableViewCell.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/17.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgentRegisterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

+ (instancetype)createCell;

@end
