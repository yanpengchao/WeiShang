//
//  PCTabBarViewController.m
//  SellerTool
//
//  Created by 鄢彭超 on 16/4/14.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "PCTabBarViewController.h"
#import "UIImage+Creation.h"
#import "PCNavigationViewController.h"
#import "MainPageViewController.h"
#import "ViewController.h"

@interface PCTabBarViewController ()

@end

@implementation PCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - all public functions

- (void)setupAllSubViewControllers
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    UIImage *buttonImage = [UIImage pureimageWithColor:[UIColor whiteColor]];
    CGSize tabBarSize = self.tabBar.frame.size;
    buttonImage = [buttonImage stretchableImageWithLeftCapWidth:tabBarSize.width topCapHeight:tabBarSize.height];
    self.tabBar.backgroundImage = buttonImage;
    
    NSArray *titleArray = @[@"首页", @"产品", @"代理", @"订单", @"我的"];
    NSArray *imageArray = @[@"tabIcon1UnSel", @"tabIcon2UnSel", @"tabIcon3UnSel", @"tabIcon4UnSel", @"tabIcon5UnSel"];
    NSArray *seletedImageArray = @[@"tabIcon1", @"tabIcon2", @"tabIcon3", @"tabIcon4", @"tabIcon5"];
    
    // 我的
    MainPageViewController *vc0 = [[MainPageViewController alloc] init];
    PCNavigationViewController *nav0 = [[PCNavigationViewController alloc]initWithRootViewController:vc0];
    [self navigationVCComPare:nav0 SetTitle:titleArray[0] image:imageArray[0] selImage:seletedImageArray[0]];
    
    // 产品
    UIViewController *vc1 = [[UIViewController alloc] init];
    PCNavigationViewController *nav1 = [[PCNavigationViewController alloc]initWithRootViewController:vc1];
    [self navigationVCComPare:nav1 SetTitle:titleArray[1] image:imageArray[1] selImage:seletedImageArray[1]];
    
    // 代理
    UIViewController *vc2 = [[UIViewController alloc] init];
    PCNavigationViewController *nav2 = [[PCNavigationViewController alloc]initWithRootViewController:vc2];
    [self navigationVCComPare:nav2 SetTitle:titleArray[2] image:imageArray[2] selImage:seletedImageArray[2]];
    
    // 订单
    UIViewController *vc3 = [[UIViewController alloc] init];
    PCNavigationViewController *nav3 = [[PCNavigationViewController alloc]initWithRootViewController:vc3];
    [self navigationVCComPare:nav3 SetTitle:titleArray[3] image:imageArray[3] selImage:seletedImageArray[3]];
    
    // 我的
    UIViewController *vc4 = [[UIViewController alloc] init];
    PCNavigationViewController *nav4 = [[PCNavigationViewController alloc]initWithRootViewController:vc4];
    [self navigationVCComPare:nav4 SetTitle:titleArray[4] image:imageArray[4] selImage:seletedImageArray[4]];
    
    self.tabBar.tintColor = [PCTabBarViewController colorWithRGB:0x3d77c7];
    self.viewControllers = @[nav0, nav1, nav2, nav3, nav4];
    self.selectedIndex = 0;
}

- (void)navigationVCComPare:(PCNavigationViewController *)navigationVC
                   SetTitle:(NSString *)titleStr
                      image:(NSString *)imageStr
                   selImage:(NSString *)selImageStr
{
    [navigationVC setTitle:titleStr];
    navigationVC.tabBarItem.image =  [UIImage imageNamed:imageStr];
    UIImage *img3 =[UIImage imageNamed:selImageStr];
    img3 = [img3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationVC.tabBarItem.selectedImage = img3;
    navigationVC.interactivePopGestureRecognizer.enabled =NO;
}

+ (UIColor *)colorWithRGB:(NSUInteger)rgb
{
    return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0
                           green:((float)((rgb & 0xFF00) >> 8))/255.0
                            blue:((float)(rgb & 0xFF))/255.0
                           alpha:1.0];
}

@end
