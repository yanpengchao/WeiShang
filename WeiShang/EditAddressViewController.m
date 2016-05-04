//
//  EditAddressViewController.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/5/4.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "EditAddressViewController.h"
#import "UserMainInfoCell.h"
#import "TextWithEditCell.h"
#import "DefaultSettingCell.h"

static NSString *TextWithEditCellIdentifier = @"TextWithEditCell";
static NSString *UserMainInfoCellIdentifier = @"UserMainInfoCell";
static NSString *DefaultSettingCellIdentifier = @"DefaultSettingCell";

@interface EditAddressViewController ()

@end

@implementation EditAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"UserMainInfoCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:UserMainInfoCellIdentifier];
    
    cellNib = [UINib nibWithNibName:@"TextWithEditCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:TextWithEditCellIdentifier];
    
    cellNib = [UINib nibWithNibName:@"DefaultSettingCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:DefaultSettingCellIdentifier];
    
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
    if (self.editFlag) {
        return 3;
    }
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 84;
        case 1:
            return 44;
        case 2:
            return 44;
        case 3:
            return 58;
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UserMainInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:UserMainInfoCellIdentifier];
        return cell;
    }
    else if (indexPath.row == 1) {
        TextWithEditCell *cell = [tableView dequeueReusableCellWithIdentifier:TextWithEditCellIdentifier];
        cell.leftTextLabel.text = @"所在地区";
        cell.rightEditTextField.placeholder = @"填写所在地区";
        return cell;
    }
    else if (indexPath.row == 2) {
        TextWithEditCell *cell = [tableView dequeueReusableCellWithIdentifier:TextWithEditCellIdentifier];
        cell.leftTextLabel.text = @"详细地址";
        cell.rightEditTextField.placeholder = @"街道、楼牌号等";
        return cell;
    }
    else {
        DefaultSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:DefaultSettingCellIdentifier];
        return cell;
    }
    return nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
