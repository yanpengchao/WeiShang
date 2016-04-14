//
//  WebViewController.h
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/14.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong)NSString* urlString;
@end
