//
//  MainPageViewController.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/14.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "MainPageViewController.h"
#import "WebViewController.h"

@interface MainPageViewController () <UIScrollViewDelegate>


@property (nonatomic, strong)UISegmentedControl* segmentedControl;
@property (nonatomic, strong)IBOutlet UIScrollView* scrollView;
@property (weak, nonatomic) IBOutlet UIWebView *webView1;
@property (weak, nonatomic) IBOutlet UIWebView *webView2;
@property (weak, nonatomic) IBOutlet UIWebView *webView3;

@end

@implementation MainPageViewController

#pragma mark - viewController life-cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    [self addCustomNaviBar];
    
    self.scrollView.bounces = NO;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.alwaysBounceHorizontal = YES;
    
    [self loadWebViews];
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self segmentedValueChanged];
}

#pragma mark - 导航条顶部资讯分类

- (void)addCustomNaviBar
{
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"动态", @"视频", @"公告", nil];
    
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    
    // 设置显示范围
    CGRect mainViewBounds = self.navigationController.view.bounds;
    CGFloat vGap = 4.0f;
    CGFloat hGap = 44.0f;
    [segmentedControl setFrame:CGRectMake(hGap, vGap, mainViewBounds.size.width - hGap*2 , 44 - vGap*2)];
    
    // 设置响应时间
    [segmentedControl addTarget:self
                         action:@selector(segmentedValueChanged)
               forControlEvents:UIControlEventValueChanged];
    
    // 设置默认选择项索引
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor grayColor];
    
    [self.navigationItem setTitleView:segmentedControl];
    self.segmentedControl = segmentedControl;
}

- (void)segmentedValueChanged
{
    CGRect scrollViewBounds = self.scrollView.bounds;
    CGFloat width = scrollViewBounds.size.width;
    NSInteger selectedIndex = self.segmentedControl.selectedSegmentIndex;
    
    switch (selectedIndex) {
        case 0:
        {
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
            break;
        case 1:
        {
            [self.scrollView setContentOffset:CGPointMake(width, 0) animated:YES];
        }
            break;
        case 2:
        {
            [self.scrollView setContentOffset:CGPointMake(width*2, 0) animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - webview加载

- (void)loadWebViews
{
    NSURL* webUrl = [NSURL URLWithString:@"http://news.qq.com"];
    NSURLRequest* request =[NSURLRequest requestWithURL:webUrl cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:3600];
    [self.webView1 loadRequest:request];
    
    webUrl = [NSURL URLWithString:@"http://www.baidu.com"];
    request =[NSURLRequest requestWithURL:webUrl cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:3600];
    [self.webView2 loadRequest:request];
    
    webUrl = [NSURL URLWithString:@"http://www.jd.com"];
    request =[NSURLRequest requestWithURL:webUrl cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:3600];
    [self.webView3 loadRequest:request];
}


#pragma mark - UIScrollViewDelegate functions

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        CGPoint offsetPoint = scrollView.contentOffset;
        CGSize scrollViewSize = scrollView.frame.size;
        if (offsetPoint.x < scrollViewSize.width) {
            [self.segmentedControl setSelectedSegmentIndex:0];
        }
        else if (offsetPoint.x < scrollViewSize.width*2) {
            [self.segmentedControl setSelectedSegmentIndex:1];
        }
        else {
            [self.segmentedControl setSelectedSegmentIndex:2];
        }
    }
    else {
        //
    }
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
