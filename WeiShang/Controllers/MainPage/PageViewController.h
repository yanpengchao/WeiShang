//
//  PageViewController.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/24.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"

@interface PageViewController : BasicViewController <UIWebViewDelegate>

@property (nonatomic, strong)NSString* url;

@end
