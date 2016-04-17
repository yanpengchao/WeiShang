//
//  DYAuthorizationStatus.h
//  IntelligenceResearchReport
//
//  Created by 鄢彭超 on 16/3/30.
//  Copyright © 2016年 datayes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface DYAuthorizationStatus : NSObject

+ (BOOL)checkCameraAuthorization;
+ (BOOL)checkPhotoAuthorization;

@end
