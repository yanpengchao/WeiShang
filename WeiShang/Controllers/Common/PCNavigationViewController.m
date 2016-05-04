//
//  PCNavigationViewController.m
//  SellerTool
//
//  Created by 鄢彭超 on 16/4/14.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "PCNavigationViewController.h"

@interface PCNavigationViewController () <UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation PCNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof (self) weakSelf = self;
    self.delegate = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    self.interactivePopGestureRecognizer.enabled =NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
    [[viewControllers lastObject] setHidesBottomBarWhenPushed:[viewControllers count] > 1];
    if ([viewControllers count] > 1) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    else
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super setViewControllers:viewControllers animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    
    UIViewController *controller = self.viewControllers.firstObject;
    controller.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if ([self.viewControllers count] == 2) {
        UIViewController *controller = self.viewControllers.firstObject;
        controller.hidesBottomBarWhenPushed = NO;
    }
    
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *controller = self.viewControllers.firstObject;
    if (viewController == controller) {
        controller.hidesBottomBarWhenPushed = NO;
    }
    
    return [super popToViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    UIViewController *controller = self.viewControllers.firstObject;
    controller.hidesBottomBarWhenPushed = NO;

    return [super popToRootViewControllerAnimated:animated];
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if ([navigationController.viewControllers count] > 1) {
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
        else
        {
            navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

#pragma mark - Oriention
- (BOOL)shouldAutorotate
{
    
    return [self.topViewController shouldAutorotate];
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
    return [self.topViewController supportedInterfaceOrientations];
}

@end
