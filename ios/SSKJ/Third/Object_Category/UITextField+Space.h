//
//  UITextField+Space.h
//  MIT_Integrated
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 apple. All rights reserved.
/***************************************
 ClassName： UITextField (Space)
 Created_Date： 20150916
 Created_People： GT
 Function_description： 设置光标位置
 ***************************************/

#import <UIKit/UIKit.h>
typedef enum {
    kLeftEdge = 0,//左边距
    kRightEdge,//右边距
    kNone
}ShowDirection;
@interface UITextField (Space)

-(void)setDirection:(ShowDirection)direction edgeSpace:(CGFloat)space;
-(void)setDirection:(ShowDirection)direction placeImage:(UIImage*)image;
-(void)setDirection:(ShowDirection)direction placeTitle:(NSString*)title;

-(void)setTextFieldSelectedBackGroundImage;

-(void)setTextFieldUnselectedBackGroundImage;

@end
