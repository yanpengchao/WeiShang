//
//  MainPageViewController.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/14.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "MainPageViewController.h"
#import "WebViewController.h"

@interface MainPageViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation MainPageViewController

#pragma mark - viewController life-cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    NSURL* webUrl = [NSURL URLWithString:@"http://news.qq.com"];
    NSURLRequest* request =[NSURLRequest requestWithURL:webUrl cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:3600];
    [self.webView loadRequest:request];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIWebViewDelegate functions
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (UIWebViewNavigationTypeLinkClicked == navigationType) {
        WebViewController* webViewController = [[WebViewController alloc] init];
        webViewController.urlString = request.URL.absoluteString;
        [self.navigationController pushViewController:webViewController animated:YES];
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    //
}

@end
