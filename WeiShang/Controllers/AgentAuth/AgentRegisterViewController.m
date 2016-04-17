//
//  AgentRegisterViewController.m
//  WeiShang
//
//  Created by 鄢彭超 on 16/4/17.
//  Copyright © 2016年 鄢彭超. All rights reserved.
//

#import "AgentRegisterViewController.h"
#import "AgentRegisterTableViewCell.h"
#import "AgentRegisterFooterTableViewCell.h"
#import "DYAuthorizationStatus.h"

typedef NS_ENUM(NSUInteger, ERegisterInfoType) {
    eRegisterInfoName = 0,                  // 姓名
    eRegisterInfoMobilePhone,               // 手机
    eRegisterInfoIdentity,                  // 身份证
    eRegisterInfoWeiXin,                    // 微信
    eRegisterInfoQQ,                        // QQ
    eRegisterInfoAddress,                   // 地址
    eRegisterInfoImage,                     // 图像
};

@interface AgentRegisterViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, strong)NSArray* registerCellArray;
@property (strong, nonatomic)UIImagePickerController *imagePickerController;
@property (nonatomic, strong)UIImage* image;

@end

@implementation AgentRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self loadAllCell];
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
    return [self.registerCellArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.registerCellArray[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < eRegisterInfoImage) {
        return 44;
    }
    return 140;
}

#pragma mark - private functions

- (void)loadAllCell {
    NSArray* registerInfoArray = @[@"姓名", @"手机", @"身份证号码", @"微信号", @"QQ", @"地址"];
    NSMutableArray* mArray = [NSMutableArray array];
    for (NSInteger i = eRegisterInfoName ; i < eRegisterInfoImage ; i ++) {
        AgentRegisterTableViewCell* cell = [AgentRegisterTableViewCell createCell];
        cell.descriptionLabel.text = registerInfoArray[i];
        cell.inputTextField.placeholder = [NSString stringWithFormat:@"请输入您的%@", registerInfoArray[i]];
        
        [mArray addObject:cell];
    }
    
    AgentRegisterFooterTableViewCell* cell = [AgentRegisterFooterTableViewCell createCell];
    [cell.imageButton addTarget:self action:@selector(fetchImage) forControlEvents:UIControlEventTouchUpInside];
    [cell.commitButton addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    
    [mArray addObject:cell];
    
    self.registerCellArray = mArray;
}

- (void)fetchImage
{
    [self hideKeyboard];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          if (![DYAuthorizationStatus checkCameraAuthorization]) {
                                                              return;
                                                          }
                                                          self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                          [self presentViewController:self.imagePickerController
                                                                             animated:YES completion:nil];
                                                      }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"从手机相册选择"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          if (![DYAuthorizationStatus checkPhotoAuthorization]) {
                                                              return;
                                                          }
                                                          self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                          [self presentViewController:self.imagePickerController
                                                                             animated:YES completion:nil];
                                                          
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                      }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)commit
{
    [self hideKeyboard];
}

- (void)hideKeyboard
{
//    if ([self.registerCellArray count] > 0) {
//        for (NSInteger i = eRegisterInfoName ; i < eRegisterInfoImage ; i ++) {
//            AgentRegisterTableViewCell* cell = self.registerCellArray[i];
//            [cell.inputTextField resignFirstResponder];
//        }
//    }
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark - 获取照片

- (UIImagePickerController*)imagePickerController
{
    if (_imagePickerController == nil) {
        _imagePickerController =[[UIImagePickerController alloc]init];
        _imagePickerController.allowsEditing =YES;
        _imagePickerController.delegate = self;
    }
    
    return _imagePickerController;
}

#pragma mark - UIImagePickerControllerDelegate functions
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"] && picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        self.image = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    else if ([type isEqualToString:@"public.image"] && picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        self.image = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    
//    NSData *imageData = UIImagePNGRepresentation(self.image);
    AgentRegisterFooterTableViewCell* cell = self.registerCellArray[eRegisterInfoImage];
    [cell.imageButton setBackgroundImage:self.image forState:UIControlStateNormal];
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:eRegisterInfoImage inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate functions
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }
    else if (buttonIndex == 1) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }
}

@end
