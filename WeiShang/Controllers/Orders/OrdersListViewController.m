//
//  OrdersListViewController.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/18.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "OrdersListViewController.h"
#import "MyOrdersTableViewCell.h"
#import "SubOrdersTableViewCell.h"
#import "MyOrderDAO.h"
#import "SubOrderDAO.h"

#import "UIImageView+WebCache.h"

static NSString *MyOrderCellTableIdentifier = @"MyOrdersTableViewCell";
static NSString *SubOrderCellTableIdentifier = @"SubOrdersTableViewCell";

@interface OrdersListViewController () <UIScrollViewDelegate, UISearchBarDelegate, UIScrollViewDelegate>

@property (nonatomic, strong)UISegmentedControl* segmentedControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *myOrdersTableView;
@property (weak, nonatomic) IBOutlet UITableView *subOrdersTableView;
@property (nonatomic, strong)UISearchBar* customSearchBar;

@end

@implementation OrdersListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addCustomNaviBar];
    [self addNaviButtons];
    
    self.scrollView.bounces = NO;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.alwaysBounceHorizontal = YES;
    
    UINib *cellNib = [UINib nibWithNibName:@"MyOrdersTableViewCell" bundle:nil];
    [self.myOrdersTableView registerNib:cellNib forCellReuseIdentifier:MyOrderCellTableIdentifier];
    
    cellNib = [UINib nibWithNibName:@"SubOrdersTableViewCell" bundle:nil];
    [self.subOrdersTableView registerNib:cellNib forCellReuseIdentifier:SubOrderCellTableIdentifier];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGSize scrollViewSize = self.scrollView.frame.size;
    CGSize contentSize = self.scrollView.contentSize;
    CGPoint contentOffset = self.scrollView.contentOffset;
    
    [self.scrollView setContentSize:CGSizeMake(contentSize.width, scrollViewSize.height)];
    [self.scrollView setContentOffset:CGPointMake(contentOffset.x, 0)];
}

#pragma mark - 导航条顶部资讯分类

- (void)addCustomNaviBar
{
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"我的订单", @"下级订单", nil];
    
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    
    // 设置显示范围
    CGRect mainViewBounds = self.navigationController.view.bounds;
    CGFloat vGap = 4.0f;
    CGFloat hGap = 88.0f;
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
    CGPoint contentOffset = self.scrollView.contentOffset;
    NSInteger selectedIndex = self.segmentedControl.selectedSegmentIndex;
    
    switch (selectedIndex) {
        case 0:
        {
            [self.scrollView setContentOffset:CGPointMake(0, contentOffset.y) animated:YES];
        }
            break;
        case 1:
        {
            [self.scrollView setContentOffset:CGPointMake(width, contentOffset.y) animated:YES];
        }
            break;
        default:
            break;
    }
}


#pragma mark - 导航栏的搜索框定制

- (void)addNaviButtons
{
    UIBarButtonItem* searchButon = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                 target:self
                                                                                 action:@selector(showSearchBar)];
    self.navigationItem.rightBarButtonItem = searchButon;
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(addOrder)];
    self.navigationItem.leftBarButtonItem = addButton;
}

- (void)addOrder
{
    //
}

- (void)showSearchBar
{
    [self showSearchBar:@YES];
}

- (void)hideSearchBar
{
    [self showSearchBar:@NO];
}

- (void)showSearchBar:(NSNumber*)show
{
    static BOOL showStatus = NO;
    if (showStatus == [show boolValue]) {
        return ;
    }
    
    showStatus = [show boolValue];
    
    [UIView animateWithDuration:.3 animations:^{
        CGRect mainViewBounds = self.navigationController.view.bounds;
        if ([show boolValue]) {
            [self.customSearchBar setFrame:CGRectMake(CGRectGetMinX(mainViewBounds),
                                                      CGRectGetMinY(mainViewBounds) + 20,
                                                      mainViewBounds.size.width,
                                                      44)];
            [self.customSearchBar becomeFirstResponder];
        }
        else {
            [self.customSearchBar setFrame:CGRectMake(CGRectGetMinX(mainViewBounds) + mainViewBounds.size.width,
                                                      CGRectGetMinY(mainViewBounds) + 20,
                                                      mainViewBounds.size.width,
                                                      44)];
            [self.customSearchBar resignFirstResponder];
        }
    }];
}

- (UISearchBar*)customSearchBar
{
    if (_customSearchBar == nil) {
        CGRect mainViewBounds = self.navigationController.view.bounds;
        _customSearchBar = [[UISearchBar alloc]
                            initWithFrame:CGRectMake(CGRectGetMinX(mainViewBounds) + mainViewBounds.size.width,
                                                     CGRectGetMinY(mainViewBounds) + 20,
                                                     mainViewBounds.size.width,
                                                     44)];
        _customSearchBar.delegate = self;
        _customSearchBar.showsCancelButton = YES;
        
        [self.navigationController.view addSubview:self.customSearchBar];
    }
    
    return _customSearchBar;
}

#pragma mark - private functions

- (void)updateMyCell:(MyOrdersTableViewCell*)cell withInfo:(MyOrderDAO*)info
{
    NSURL* url = [NSURL URLWithString:@"http://www.iconpng.com/download/png/1135"];
    UIImage* placeholderImage = [UIImage imageNamed:@"downloading"];
    [cell.goodsImageView sd_setImageWithURL:url placeholderImage:placeholderImage];
}

- (void)updateSubCell:(SubOrdersTableViewCell*)cell withInfo:(SubOrderDAO*)info
{
    //
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.agentInfoList count];
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    AgentInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
//    AgentInfoDAO* info = self.agentInfoList[indexPath.row];
//    [self updateCell:cell withInfo:info];
    
    if (tableView == self.myOrdersTableView) {
        MyOrdersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyOrderCellTableIdentifier];
        [self updateMyCell:cell withInfo:nil];
        return cell;
    }
    else {
        SubOrdersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SubOrderCellTableIdentifier];
        [self updateSubCell:cell withInfo:nil];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.myOrdersTableView) {
        return 85;
    }
    else {
        return 44;
    }
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideSearchBar];
    //
}

#pragma mark - UIScrollViewDelegate functions

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        CGPoint offsetPoint = scrollView.contentOffset;
        CGSize scrollViewSize = scrollView.frame.size;
        
        if (offsetPoint.y < 0) {
            [self.scrollView setContentOffset:CGPointMake(offsetPoint.x, 0) animated:YES];
        }
        
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

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self hideSearchBar];
}

#pragma mark - UISearchBarDelegate functions

// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.customSearchBar resignFirstResponder];
    
    // TODO:搜索点东西吧
}

// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self hideSearchBar];
}

@end
