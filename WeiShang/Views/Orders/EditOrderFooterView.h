//
//  EditOrderFooterView.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/5/3.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditOrderFooterView : UIView

@property (weak, nonatomic) IBOutlet UIButton *commitButton;

+ (instancetype)createView;
@end
