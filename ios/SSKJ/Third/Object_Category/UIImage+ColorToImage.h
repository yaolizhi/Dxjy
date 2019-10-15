//
//  UIImage+ColorToImage.h
//  MIT_Integrated
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 apple. All rights reserved.
/***************************************
 ClassName：  UIImage (ColorToImage)
 Created_Date： 20150916
 Created_People： GT
 Function_description： 根据颜色绘制图片
 ***************************************/

#import <UIKit/UIKit.h>

@interface UIImage (ColorToImage)
//根据给定的颜色设置图片
+(UIImage*) createImageWithColor:(UIColor*)color frame:(CGRect)frame;
// 高斯模糊
- (UIImage *)cyl_blurredImageWithRadius:(CGFloat)radius
                             iterations:(NSUInteger)iterations
                              tintColor:(UIColor *)tintColor;
+ (UIImage *)stretchableImageNamed:(NSString *)name;
+(UIImage *) imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
@end
