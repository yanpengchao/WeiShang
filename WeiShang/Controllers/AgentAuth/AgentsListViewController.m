//
//  AgentsListViewController.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/17.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "AgentsListViewController.h"
#import "AgentInfoDAO.h"
#import "AgentInfoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AgentRegisterViewController.h"

static NSString *CellTableIdentifier = @"AgentInfoTableViewCell";

@interface AgentsListViewController () <UISearchBarDelegate, UIScrollViewDelegate>

@property (nonatomic, strong)NSArray* agentInfoList;
@property (nonatomic, strong)UISearchBar* customSearchBar;

@end

@implementation AgentsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"代理授权";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UINib *cellNib = [UINib nibWithNibName:@"AgentInfoTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:CellTableIdentifier];
    [self addNaviButtons];
    [self fakeData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 导航栏的搜索框定制

- (void)addNaviButtons
{
    UIBarButtonItem* searchButon = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                 target:self
                                                                                 action:@selector(showSearchBar)];
    self.navigationItem.rightBarButtonItem = searchButon;
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAgent)];
    self.navigationItem.leftBarButtonItem = addButton;
}

- (void)addAgent
{
    AgentRegisterViewController *registerViewController = [[AgentRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:YES];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.agentInfoList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AgentInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];    
    AgentInfoDAO* info = self.agentInfoList[indexPath.row];
    [self updateCell:cell withInfo:info];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray* mArray = [self.agentInfoList mutableCopy];
        [mArray removeObjectAtIndex:indexPath.row];
        self.agentInfoList = mArray;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideSearchBar];
    AgentRegisterViewController *registerViewController = [[AgentRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

#pragma mark - private functions

- (void)fakeData
{
    NSMutableArray* mArray = [NSMutableArray array];
    
    AgentInfoDAO* agentItem = [[AgentInfoDAO alloc] init];
    agentItem.agentId = @"100";
    agentItem.name = @"王宝强（微信名）";
    agentItem.agentState = eAgentStateNotAuth;
    agentItem.agentLevel = eAgentLevelCu;
    agentItem.avatarImageUrl = @"http://www.iconpng.com/download/png/12662";
    [mArray addObject:agentItem];
    
    agentItem = [[AgentInfoDAO alloc] init];
    agentItem.agentId = @"100";
    agentItem.name = @"张三丰（微信名）";
    agentItem.agentState = eAgentStateAuth;
    agentItem.agentLevel = eAgentLevelAg;
    agentItem.avatarImageUrl = @"http://www.iconpng.com/download/png/1181";
    [mArray addObject:agentItem];
    
    agentItem = [[AgentInfoDAO alloc] init];
    agentItem.agentId = @"100";
    agentItem.name = @"噼里啪啦（微信名）";
    agentItem.agentState = eAgentStateNotAuth;
    agentItem.agentLevel = eAgentLevelAu;
    agentItem.avatarImageUrl = @"http://www.iconpng.com/download/png/1131";
    [mArray addObject:agentItem];
    
    agentItem = [[AgentInfoDAO alloc] init];
    agentItem.agentId = @"100";
    agentItem.name = @"张东健（微信名）";
    agentItem.agentState = eAgentStateAuth;
    agentItem.agentLevel = eAgentLevelCu;
    agentItem.avatarImageUrl = @"http://www.iconpng.com/download/png/1135";
    [mArray addObject:agentItem];
    
    agentItem = [[AgentInfoDAO alloc] init];
    agentItem.agentId = @"100";
    agentItem.name = @"顾长卫（微信名）";
    agentItem.agentState = eAgentStateNotAuth;
    agentItem.agentLevel = eAgentLevelDiamond;
    agentItem.avatarImageUrl = @"http://www.iconpng.com/download/png/10307";
    [mArray addObject:agentItem];
    
    agentItem = [[AgentInfoDAO alloc] init];
    agentItem.agentId = @"100";
    agentItem.name = @"习大大（微信名）";
    agentItem.agentState = eAgentStateAuth;
    agentItem.agentLevel = eAgentLevelCu;
    agentItem.avatarImageUrl = @"http://www.iconpng.com/download/png/1094";
    [mArray addObject:agentItem];
    
    agentItem = [[AgentInfoDAO alloc] init];
    agentItem.agentId = @"100";
    agentItem.name = @"鄢明远（一休）";
    agentItem.agentState = eAgentStateAuth;
    agentItem.agentLevel = eAgentLevelDiamond;
    agentItem.avatarImageUrl = @"http://www.iconpng.com/download/png/83021";
    [mArray addObject:agentItem];
    
    agentItem = [[AgentInfoDAO alloc] init];
    agentItem.agentId = @"100";
    agentItem.name = @"胖常见发到空间发的发的快递方式及（微信名）";
    agentItem.agentState = eAgentStateAuth;
    agentItem.agentLevel = eAgentLevelNormal;
    agentItem.avatarImageUrl = @"http://www.iconpng.com/download/png/100897";
    [mArray addObject:agentItem];
    
    agentItem = [[AgentInfoDAO alloc] init];
    agentItem.agentId = @"100";
    agentItem.name = @"我房间打开附件是大家都（微信名）";
    agentItem.agentState = eAgentStateAuth;
    agentItem.agentLevel = eAgentLevelCu;
    agentItem.avatarImageUrl = @"http://www.iconpng.com/download/png/91119";
    [mArray addObject:agentItem];

    self.agentInfoList = mArray;
}

- (void)updateCell:(AgentInfoTableViewCell*)cell withInfo:(AgentInfoDAO*)info
{
    cell.nameLabel.text = info.name;
    cell.stateLabel.text = [AgentInfoDAO stateTextWithState:info.agentState];
    cell.levelLabel.text = [AgentInfoDAO levelTextWithLevel:info.agentLevel];
    UIImage* image = [UIImage imageNamed:[AgentInfoDAO levelImageWithLevel:info.agentLevel]];
    [cell.levelImageView setImage:image];
    NSURL* url = [NSURL URLWithString:info.avatarImageUrl];
    UIImage* placeholderImage = [UIImage imageNamed:@"downloading"];
    [cell.avatarImageView sd_setImageWithURL:url placeholderImage:placeholderImage];
}

#pragma mark - UIScrollViewDelegate functions

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
