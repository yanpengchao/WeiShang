//
//  GoodsListViewController.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/30.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "GoodsListViewController.h"
#import "NinaPagerView.h"
#import "GoodsPageViewController.h"

@interface GoodsListViewController ()

@property (weak, nonatomic) IBOutlet UIView *footerRootView;
@property (weak, nonatomic) IBOutlet UIButton *addOrderButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelOrderButton;
@property (weak, nonatomic) IBOutlet UILabel *totalCountLabel;
@end

@implementation GoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPagers];
    
    [self.view bringSubviewToFront:self.footerRootView];
    // Do any additional setup after loading the view from its nib.
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

- (void)setupPagers
{
    //Need You Edit
    /**<  上方显示标题  Titles showing on the topTab   **/
    NSArray *titleArray =   @[@"产品类", @"物料类", @"积分兑换"];
    /**< 每个标题下对应的控制器，只需将您创建的控制器类名加入下列数组即可(注意:数量应与上方的titles数量保持一致，若少于titles数量，下方会打印您缺少相应的控制器，同时默认设置的最大控制器数量为10)  。
     ViewControllers to the titles on the topTab.Just add your VCs' Class Name to the array. Wanning:the number of ViewControllers should equal to the titles.Meanwhile,default max VC number is 10.
     **/
    GoodsPageViewController* page1 = [[GoodsPageViewController alloc] initWithNibName:@"GoodsPageViewController" bundle:nil];
    GoodsPageViewController* page2 = [[GoodsPageViewController alloc] initWithNibName:@"GoodsPageViewController" bundle:nil];
    GoodsPageViewController* page3 = [[GoodsPageViewController alloc] initWithNibName:@"GoodsPageViewController" bundle:nil];
    
    NSArray *vcsArray = @[page1, page2, page3];
    /**< 您可以选择是否要改变标题选中的颜色(默认为黑色)、未选中的颜色(默认为灰色)或者下划线的颜色(默认为色值是ff6262)。如果传入颜色数量不够，则按顺序给相应的部分添加颜色。
     You can choose whether change your titles' selectColor(default is black),unselectColor(default is gray) and underline color(default is Color value ff6262).**/
    NSArray *colorArray = @[
                            [UIColor redColor], /**< 选中的标题颜色 Title SelectColor  **/
                            [UIColor grayColor], /**< 未选中的标题颜色  Title UnselectColor **/
                            [UIColor redColor], /**< 下划线颜色 Underline Color   **/
                            [UIColor whiteColor], /**<  上方菜单栏的背景颜色 TopTab Background Color   **/
                            ];
    
    NinaPagerView *ninaPagerView = [[NinaPagerView alloc] initWithTitles:titleArray WithVCs:vcsArray WithColorArrays:colorArray];
    ninaPagerView.titleScale = 1.2;
    [self.view addSubview:ninaPagerView];
    ninaPagerView.pushEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - action functions

- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)createOrderButtonClicked:(id)sender {
}

@end
