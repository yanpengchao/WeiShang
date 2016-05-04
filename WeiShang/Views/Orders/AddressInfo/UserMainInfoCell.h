//
//  UserMainInfoCell.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/5/4.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserMainInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *selectContractButton;

@end
