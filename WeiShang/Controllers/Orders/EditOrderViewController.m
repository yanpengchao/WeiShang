//
//  EditOrderViewController.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/5/2.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "EditOrderViewController.h"
#import "MyOrderDAO.h"
#import "GoodsDAO.h"
#import "OrderHeaderView.h"
#import "OrderFooterView.h"
#import "MyOrdersTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "TextWithEditCell.h"
#import "EditOrderFooterView.h"
#import "SelectAddressViewController.h"

static NSString *MyOrderCellTableIdentifier = @"MyOrdersTableViewCell";
//static NSString *TextWithEditCellIdentifier = @"TextWithEditCell";

@interface EditOrderViewController ()

/**
 *	@brief	订单信息
 */
@property (nonatomic, strong)MyOrderDAO* order;
@property (nonatomic, strong)NSArray* registerCellArray;

@end

@implementation EditOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fakeData];
    
    UINib *cellNib = [UINib nibWithNibName:@"MyOrdersTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:MyOrderCellTableIdentifier];
    
    if (self.directOrder) {
        [self loadAllCell];
    }
    
    [self addTableViewFooterView];
    
//    cellNib = [UINib nibWithNibName:@"TextWithEditCell" bundle:nil];
//    [self.tableView registerNib:cellNib forCellReuseIdentifier:TextWithEditCellIdentifier];
    
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.directOrder) {
        switch (section) {
            case 0:
                return 1;
            case 1:
                return [self.order.goodsArray count];
            case 2:
                return 10;
        }
    }
    else {
        switch (section) {
            case 0:
                return 1;
            case 1:
                return [self.order.goodsArray count];
            case 2:
                return 1;
        }
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
        case 1:
            return 32;
        case 2:
            return 0;
        default:
            break;
    }
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return nil;
        }
        case 1:
        {
            OrderHeaderView* orderHeaderView = [OrderHeaderView createView];
            orderHeaderView.frame = (CGRect){0, 0, self.view.frame.size.width, 32};
            [self updateOrderHeaderView:orderHeaderView withInfo:self.order];
            return orderHeaderView;
        }
        case 2:
        {
            return nil;
        }
        default:
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
        case 1:
            return 32;
        case 2:
            return 0;
        default:
            break;
    }
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return nil;
        }
        case 1:
        {
            OrderFooterView* orderFooterView = [OrderFooterView createView];
            orderFooterView.frame = (CGRect){0, 0, self.view.frame.size.width, 32};
            [self updateOrderFooterView:orderFooterView withInfo:self.order];
            return orderFooterView;
        }
        case 2:
        {
            return nil;
        }
        default:
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    }
    else if (indexPath.section == 1) {
        return 85;
    }
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"contactInfoCell"];
        cell.textLabel.text = @"徐存斌：13761125111";
        cell.detailTextLabel.text = @"上海市浦东新区周浦镇秀浦路2500号6号楼803";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else if (indexPath.section == 1) {
        MyOrdersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyOrderCellTableIdentifier];
        GoodsDAO* goodsDao = self.order.goodsArray[indexPath.row];
        [self updateCell:cell withInfo:goodsDao];
        return cell;
    }
    else {
        if (self.directOrder) {
            return self.registerCellArray[indexPath.row];
        }
        else
        {
            TextWithEditCell* cell = [TextWithEditCell createCell];
            cell.leftTextLabel.text = @"订单备注";
            cell.rightEditTextField.placeholder = [NSString stringWithFormat:@"请输入%@", @"订单备注信息"];
            return cell;
        }
    }
    
    return nil;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.directOrder) {
        if (indexPath.section == 0) {
            SelectAddressViewController* saVC = [[SelectAddressViewController alloc] init];
            [self.navigationController pushViewController:saVC animated:YES];
        }
    }
    else
    {
        if (indexPath.section == 0) {
            SelectAddressViewController* saVC = [[SelectAddressViewController alloc] init];
            [self.navigationController pushViewController:saVC animated:YES];
        }
    }
}

#pragma mark - local functions

- (void)fakeData
{
    MyOrderDAO* myOrder = [[MyOrderDAO alloc] init];
    myOrder.orderId = @"1";
    myOrder.state = eOrderStateChecking;
    
    NSMutableArray* mGoodsArray = [NSMutableArray array];
    GoodsDAO* goods = [[GoodsDAO alloc] init];
    goods.goodsId = @"1";
    goods.imageUrl = @"http://c.hiphotos.baidu.com/image/pic/item/d439b6003af33a876bcce3f7c35c10385243b5be.jpg";
    goods.name = @"祖传贴膜";
    goods.price = 100.0f;
    goods.unit = @"张";
    goods.state = eGoodsStateChecked;
    goods.carriage = 10.0f;
    goods.count = 10;
    goods.stateDetail = @"商品暂时缺货，需要临时调度";
    [mGoodsArray addObject:goods];
    
    goods = [[GoodsDAO alloc] init];
    goods.goodsId = @"2";
    goods.imageUrl = @"http://c.hiphotos.baidu.com/image/pic/item/d439b6003af33a876bcce3f7c35c10385243b5be.jpg";
    goods.name = @"iPhone 6S手机，双卡双待";
    goods.price = 10000.0f;
    goods.unit = @"台";
    goods.state = eGoodsStatePayed;
    goods.carriage = 100.0f;
    goods.count = 10;
    goods.stateDetail = @"已付款，马上就要发货了哈";
    [mGoodsArray addObject:goods];
    
    myOrder.goodsArray = mGoodsArray;
    self.order = myOrder;
}

- (void)updateOrderHeaderView:(OrderHeaderView*)view withInfo:(MyOrderDAO*)info
{
    view.orderIdLabel.text = [NSString stringWithFormat:@"订单编号：%@", info.orderId];
    [view.orderStateLabel setHidden:YES];
}

- (void)updateOrderFooterView:(OrderFooterView*)view withInfo:(MyOrderDAO*)info
{
    view.textLabel.text = @"合计：￥5914.00(含运费 34.00)";
}

- (void)updateCell:(MyOrdersTableViewCell*)cell withInfo:(GoodsDAO*)info
{
    NSURL* url = [NSURL URLWithString:info.imageUrl];
    UIImage* placeholderImage = [UIImage imageNamed:@"downloading"];
    [cell.goodsImageView sd_setImageWithURL:url placeholderImage:placeholderImage];
    
    cell.goodsNameLabel.text = info.name;
    cell.goodsStateLabel.text = [GoodsDAO stateStringWithState:info.state];
    cell.goodsCountLabel.text = [NSString stringWithFormat:@"x%.00f", info.count];
    cell.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%.02f", info.price];
    cell.goodsStateDetailLabel.text = info.stateDetail;
    cell.goodsCarriageLabel.text = [NSString stringWithFormat:@"运费：%.02f", info.carriage];
}

- (void)loadAllCell {
    NSArray* registerInfoArray = @[@"下单日期", @"支付日期", @"快递公司", @"总运费", @"支付方式", @"支付金额", @"付款户名", @"付款凭证号", @"付款说明", @"订单备注"];
    NSMutableArray* mArray = [NSMutableArray array];
    
    for (NSInteger i = 0 ; i < [registerInfoArray count] ; i ++) {
        switch (i) {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            {
                UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"contactInfoCell"];
                cell.textLabel.text = registerInfoArray[i];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@信息", registerInfoArray[i]];
                
                [mArray addObject:cell];
            }
                break;
            case 6:
            case 7:
            case 8:
            case 9:
            {
                TextWithEditCell* cell = [TextWithEditCell createCell];
                cell.leftTextLabel.text = registerInfoArray[i];
                cell.rightEditTextField.placeholder = [NSString stringWithFormat:@"请输入%@", registerInfoArray[i]];
                
                [mArray addObject:cell];
            }
                break;
            default:
                break;
        }
    }
    
    self.registerCellArray = mArray;
}

- (void)commitButtonClicked:(id)sender
{
    //
}

- (void)addTableViewFooterView
{
    EditOrderFooterView* footerView = [EditOrderFooterView createView];
    [footerView.commitButton addTarget:self action:@selector(commitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = footerView;
}

@end
