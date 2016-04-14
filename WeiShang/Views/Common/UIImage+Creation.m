//
//  UIImage+Creation.m
//  IntelligenceResearchReport
//
//  Created by datayes on 15/8/19.
//  Copyright (c) 2015年 datayes. All rights reserved.
//

#import "UIImage+Creation.h"

@implementation UIImage (Creation)


+ (UIImage *)pureimageWithColor:(UIColor *)color
{
    return  [[self pureImageWithSize:CGSizeMake(2, 2) color:color]resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
}


+ (UIImage *)pureImageWithSize:(CGSize)size
                         color:(UIColor *)color
{
  return   [self pureImageWithSize:size color:color CornerRadius:0];
}


+ (UIImage *)pureImageWithSize:(CGSize)size
                         color:(UIColor *)color
                  CornerRadius:(CGFloat)cornerRadius
{
    return [self pureImageWithSize:size color:color CornerRadius:0 borderWidth:0 borderColor:nil];
}


+ (UIImage *)pureImageWithSize:(CGSize)size
                         color:(UIColor *)color
                  CornerRadius:(CGFloat)cornerRadius
                   borderWidth:(CGFloat)borderWith
                   borderColor:(UIColor *)borderColor
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGRect rect = CGRectZero;
    rect.size = size;
    UIBezierPath *path;
    CGRect contentRect = rect;
    contentRect.origin.x += fabs(cornerRadius - borderWith);
    contentRect.origin.y += fabs(cornerRadius - borderWith);
    contentRect.size.width -= 2 *fabs(cornerRadius - borderWith);
    contentRect.size.height -=2*fabs(cornerRadius - borderWith);
    if (cornerRadius >0) {
        path = [UIBezierPath bezierPathWithRoundedRect:contentRect cornerRadius:cornerRadius];
    }else{
        path = [UIBezierPath bezierPathWithRect:contentRect];
    }
    [color setFill];
    [path fill];
    if (borderWith && borderColor) {
        UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:contentRect cornerRadius:cornerRadius];
        [borderColor setStroke];
        [path appendPath:borderPath];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
