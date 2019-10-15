//
//  NSString+TextSize.h
//  CollectionViewTest
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 apple. All rights reserved.
/***************************************
 ClassName：  NSString (TextSize)
 Created_Date： 20150916
 Created_People： GT
 Function_description： 计算字符串实际长度
 ***************************************/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (TextSize)
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize paragraphStyle:(NSMutableParagraphStyle*)paragraphStyle;
@end
