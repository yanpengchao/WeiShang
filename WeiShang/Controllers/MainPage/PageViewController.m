//
//  PageViewController.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/24.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadWebViewWithUrl:self.url];
}

- (void)loadWebViewWithUrl:(NSString*)url
{
    NSURL* webUrl = [NSURL URLWithString:url];
    NSURLRequest* request =[NSURLRequest requestWithURL:webUrl
                                            cachePolicy:NSURLRequestReloadRevalidatingCacheData
                                        timeoutInterval:3600];
    [self.webView loadRequest:request];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
