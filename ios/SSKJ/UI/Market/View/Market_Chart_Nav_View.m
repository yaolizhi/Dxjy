//
//  Market_Chart_Nav_View.m
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Chart_Nav_View.h"

@implementation Market_Chart_Nav_View

#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = kMainColor;
        
        [self createUI];
    }
    
    return self;
}


#pragma mark - 创建UI
-(void)createUI
{
    //返回按钮
    [self backButton];
    
    //标题
    [self titleLabel];
    
    //透明
    [self alphaButton];
}

#pragma mark - 透明按钮
-(UIButton *)alphaButton
{
    if (_alphaButton==nil)
    {
        _alphaButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_alphaButton setBackgroundColor:[UIColor clearColor]];
        
        [_alphaButton addTarget:self action:@selector(back_Button_Event:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_alphaButton];
        
        [_alphaButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@0);
            
            make.top.equalTo(@0);
            
            make.bottom.equalTo(self.mas_bottom);
            
            make.width.equalTo(@100);
        }];
    }
    
    return _alphaButton;
}


#pragma mark - 返回按钮
-(UIButton *)backButton
{
    if (_backButton==nil)
    {
        UIImage *image=[UIImage imageNamed:@"public_back"];
        
        _backButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_backButton setBackgroundImage:image forState:UIControlStateNormal];
        
       // [_backButton addTarget:self action:@selector(back_Button_Event:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_backButton];
        
        [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@15);
            
            make.centerY.equalTo(self.mas_centerY).offset(10);
            
            make.width.equalTo(@(image.size.width));
            
            make.height.equalTo(@(image.size.height));
        }];
    }
    
    return _backButton;
}

#pragma mark - 标题
-(UILabel *)titleLabel
{
    if (_titleLabel==nil)
    {
        _titleLabel=[[UILabel alloc] init];
        
        _titleLabel.font=WLFontSize(17.0);
        
        _titleLabel.textColor=[UIColor whiteColor];
        
        [self addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.mas_centerX);
            
            make.centerY.equalTo(self.backButton.mas_centerY);
        }];
    }
    
    return _titleLabel;
}

#pragma mark - 返回按钮 点击事件
-(void)back_Button_Event:(UIButton *)sender
{
    if (self.backBtnBlock)
    {
        self.backBtnBlock();
    }
}



@end
