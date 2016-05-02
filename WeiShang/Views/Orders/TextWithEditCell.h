//
//  TextWithEditCell.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/5/3.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextWithEditCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *leftTextLabel;
@property (weak, nonatomic) IBOutlet UITextField *rightEditTextField;

+ (instancetype)createCell;

@end
