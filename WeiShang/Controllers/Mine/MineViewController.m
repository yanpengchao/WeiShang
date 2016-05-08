//
//  MineViewController.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/5/8.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "MineViewController.h"
#import "MineInfoCell.h"
#import "UIImageView+WebCache.h"

static NSString *MineInfoCellTableIdentifier = @"MineInfoCell";

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    
    UINib *cellNib = [UINib nibWithNibName:@"MineInfoCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:MineInfoCellTableIdentifier];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 56;
    }
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MineInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:MineInfoCellTableIdentifier];
        [self updateMineInfoCell:cell];
        return cell;
    }
    else
    {
        NSArray* array = @[@"我的头像", @"我的余额", @"我的积分", @"我的团队业绩", @"扫码发货", @"更多设置"];
        NSArray* value = @[@"", @"8800.88", @"8888", @"本月：1800.88", @"", @""];
        
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"contactInfoCell"];
        cell.textLabel.text = array[indexPath.row];
        cell.detailTextLabel.text = value[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
    
    return nil;
}

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

#pragma mark - local functions

- (void)updateMineInfoCell:(MineInfoCell*)cell
{
    NSURL* url = [NSURL URLWithString:@"http://www.iconpng.com/download/png/12662"];
    UIImage* placeholderImage = [UIImage imageNamed:@"downloading"];
    [cell.mineAvatarImageView sd_setImageWithURL:url placeholderImage:placeholderImage];
    
    cell.mineNameLabel.text = @"王宝强";
    cell.mineLevelLabel.text = @"等级：黄钻";
}

@end
