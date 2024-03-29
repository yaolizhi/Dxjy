//
//  UIView+Extension.h
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>


//常用定义
#define edge   10.f
#define Screen_Width    [UIScreen mainScreen].bounds.size.width
#define Screen_Height   [UIScreen mainScreen].bounds.size.height
#define IS_IPHONE_X (Screen_Height == 812.0f) ? YES : NO
#define Height_StatusBar (((IS_IPHONE_X ) == (YES))?(44.0): (20.0))
#define Height_NavBar (((IS_IPHONE_X ) == (YES))?(88.0): (64.0))
#define Height_TabBar (((IS_IPHONE_X ) == (YES))?(83.0): (49.0))
static NSString *blackColor = @"#0f303c";
static NSString *greyColor = @"#e3e8e9";
//static NSString *redColor = @"#f27750";
//static NSString *greenColor = @"#03c38a";
@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;

@property (nonatomic, assign ,readonly) CGRect oneRightNextRect;
@property (nonatomic, assign ,readonly) CGRect oneBottomNextRect;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;


-(CGRect)rightNextRectWithWidth:(CGFloat)width andHeight:(CGFloat)height;
-(CGRect)bottomNextRectWithWidth:(CGFloat)width andHeight:(CGFloat)height;

@property (nonatomic, assign) CGFloat cornerRadius;
-(void)setBorderWithWidth:(CGFloat)width andColor:(UIColor *)color;
-(void)label:(UILabel *)lable font:(float)font textColor:(UIColor *)color text:(NSString *)text;
-(void)btn:(UIButton *)btn font:(float)font textColor:(UIColor *)color text:(NSString *)text image:(UIImage*)imge;
-(void)btn:(UIButton *)btn font:(float)font textColor:(UIColor *)color text:(NSString *)text image:(UIImage*)imge sel:(SEL)sel taget:(id)taget;
-(void)textField:(UITextField *)textField textFont:(CGFloat)textFont placeHolderFont:(CGFloat)placeHolderFont text:(NSString *)text placeText:(NSString *)placeText textColor:(UIColor *)textColor placeHolderTextColor:(UIColor *)placeHolderTextColor;
-(CGFloat)returnHeight:(NSString *)str font:(float)font width:(float)width;
-(void)widthToFit;
-(void)heightToFit;
-(CGFloat)returnWidth:(NSString *)str font:(float)font;

-(UILabel *)labelFrame:(CGRect)frame;

-(UILabel *)labelNew;
-(UIColor *)color:(NSString *)color;


@end
