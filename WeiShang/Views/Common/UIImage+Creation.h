//
//  UIImage+Creation.h
//  IntelligenceResearchReport
//
//  Created by datayes on 15/8/19.
//  Copyright (c) 2015年 datayes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Creation)

/**
 * @author zhizhong.zhou
 *
 * 根据颜色生成图片
 *
 * @param color 颜色
 *
 * @return image
 */
+ (UIImage *)pureimageWithColor:(UIColor *)color;


+ (UIImage *)pureImageWithSize:(CGSize)size
                         color:(UIColor *)color;


+ (UIImage *)pureImageWithSize:(CGSize)size
                         color:(UIColor *)color
                  CornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)pureImageWithSize:(CGSize)size
                         color:(UIColor *)color
                  CornerRadius:(CGFloat)cornerRadius
                   borderWidth:(CGFloat)borderWith
                   borderColor:(UIColor *)borderColor;
@end
