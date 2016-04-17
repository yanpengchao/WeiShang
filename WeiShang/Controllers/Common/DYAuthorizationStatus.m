//
//  DYAuthorizationStatus.m
//  IntelligenceResearchReport
//
//  Created by datayes on 16/3/30.
//  Copyright © 2016年 datayes. All rights reserved.
//

#import "DYAuthorizationStatus.h"

@implementation DYAuthorizationStatus
+ (BOOL)checkCameraAuthorization
{
    BOOL isAvalible = YES;
    //ios 7.0以上的系统新增加摄像头权限检测
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        //获取对摄像头的访问权限。
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (authStatus) {
            case AVAuthorizationStatusRestricted://此应用程序没有被授权访问的照片数据。可能是家长控制权限。
                isAvalible = NO;
                NSLog(@"Restricted");
                break;
            case AVAuthorizationStatusDenied://用户已经明确否认了这一照片数据的应用程序访问.
                NSLog(@"Denied");
                isAvalible = NO;
                break;
            case AVAuthorizationStatusAuthorized://用户已授权应用访问照片数据.
                NSLog(@"Authorized");
                break;
            case AVAuthorizationStatusNotDetermined://用户尚未做出了选择这个应用程序的问候
                isAvalible =[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
                break;
            default:
                break;
        }
    }
    if (!isAvalible) {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"您关闭了相机权限，无法进行拍照。可以在手机 > 设置 > 隐私 > 相机中开启权限。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [errorAlert show];
        errorAlert = nil;
    }
    
    return isAvalible;
}

+ (BOOL)checkPhotoAuthorization
{
    BOOL isAvalible = YES;
    //ios 7.0以上的系统新增加摄像头权限检测
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        //获取对摄像头的访问权限。
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        switch (authStatus) {
            case ALAuthorizationStatusRestricted://此应用程序没有被授权访问的照片数据。可能是家长控制权限。
                NSLog(@"Restricted");
                isAvalible = NO;
                break;
            case ALAuthorizationStatusDenied://用户已经明确否认了这一照片数据的应用程序访问.
                NSLog(@"Denied");
                isAvalible = NO;
                break;
            case ALAuthorizationStatusAuthorized://用户已授权应用访问照片数据.
                NSLog(@"Authorized");
                break;
            case ALAuthorizationStatusNotDetermined://用户尚未做出了选择这个应用程序的问候
                isAvalible =[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
                break;
            default:
                break;
        }
    }
    if (!isAvalible) {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"您关闭了照片权限，无法进行拍照。可以在手机 > 设置 > 隐私 > 照片中开启权限。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [errorAlert show];
        errorAlert = nil;
    }
    
    return isAvalible;
}
@end
