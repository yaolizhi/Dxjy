//
//  Market_Chart_Detail_Type_Section_View.m
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Chart_Detail_Type_Section_View.h"
@interface Market_Chart_Detail_Type_Section_View()
@property (nonatomic, strong) UIView *movingLine;

@property (nonatomic, strong) UIView *introLine;
@end
@implementation Market_Chart_Detail_Type_Section_View

#pragma mark - 初始化
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithReuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.contentView.backgroundColor = [WLTools stringToColor:@"#151824"];
        
        [self createUI];
    }
    
    return self;
}

#pragma mark - 创建UI
-(void)createUI
{
    //成交
//    [self dealButton];
    
    //简介
    [self introButton];
    
    //分割线
    [self lineView];
    
//    [self movingLine];
    
    [self introLine];
}

#pragma mark - 成交按钮
-(UIButton *)dealButton
{
    if (_dealButton==nil)
    {
        _dealButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_dealButton setTitle:SSKJLocalized(@"成交", nil) forState:UIControlStateNormal];
        
        
        [_dealButton setTitleColor:UIColorFromRGB(0xeeeeee)  forState:UIControlStateNormal];
        
        [_dealButton setTitleColor:UIColorFromRGB(0x87abfe) forState:UIControlStateSelected];
        
        _dealButton.titleLabel.font=WLFontSize(16.0);
        
        _dealButton.selected=YES;
        
        [_dealButton addTarget:self action:@selector(deal_Button_Event:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_dealButton];
        
        [_dealButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@90);
            
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    
    return _dealButton;
    
}

#pragma mark - 简介按钮
-(UIButton *)introButton
{
    if (_introButton==nil)
    {
        _introButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_introButton setTitle:SSKJLocalized(@"简介", nil) forState:UIControlStateNormal];
        
        [_introButton setTitleColor:UIColorFromRGB(0xeeeeee) forState:UIControlStateNormal];
        
        [_introButton setTitleColor:UIColorFromRGB(0x87abfe) forState:UIControlStateSelected];
        
        _introButton.titleLabel.font=WLFontSize(16.0);
        
        [_introButton addTarget:self action:@selector(intro_Button_Event:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_introButton];
        
        [_introButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.contentView.mas_centerX);
            
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    
    return _introButton;
    
}

#pragma mark - 分割线
-(UIView *)lineView
{
    if (_lineView==nil)
    {
        _lineView=[[UIView alloc] init];
        
        _lineView.backgroundColor=UIColorFromRGB(0x070a14);
        
        [self.contentView addSubview:_lineView];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.contentView.mas_bottom);
            
            make.height.equalTo(@2.0);
            
            make.left.equalTo(@0);
            
            make.width.equalTo(@(ScreenWidth));
        }];
    }
    
    return _lineView;
}

-(UIView *)movingLine
{
    if (!_movingLine) {
        _movingLine = [[UIView alloc]init];
        float width = [self returnWidth:@"简介" font:16];
        [self addSubview:_movingLine];
        _movingLine.backgroundColor = UIColorFromRGB(0x87abfe);
        [_movingLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.lineView);
            make.width.equalTo(@(width));
            make.centerY.equalTo(self.lineView);
            make.centerX.equalTo(self.dealButton);
        }];
        _movingLine.hidden = NO;
        
    }
    return _movingLine;
}

-(UIView *)introLine
{
    if (!_introLine) {
        _introLine = [[UIView alloc]init];
        float width = [self returnWidth:@"简介" font:16];
        [self addSubview:_introLine];
        _introLine.backgroundColor = UIColorFromRGB(0x87abfe);
        [_introLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.lineView);
            make.width.equalTo(@(width));
            make.centerY.equalTo(self.lineView);
            make.centerX.equalTo(self.introButton);
        }];
        _introLine.hidden = YES;
    }
    return _introLine;
}


#pragma mark - 简介按钮 点击事件
-(void)intro_Button_Event:(UIButton *)sender
{
    self.introButton.selected=YES;
    
    self.dealButton.selected=NO;
    
    _introLine.hidden = NO;
    
    _movingLine.hidden = YES;
    
    if (self.itemBlock)
    {
        self.itemBlock(2);
    }
}

#pragma mark - 成交按钮 点击事件
-(void)deal_Button_Event:(UIButton *)sender
{

    
    self.dealButton.selected=YES;
    
    self.introButton.selected=NO;
    
    _introLine.hidden = YES;
    
    _movingLine.hidden = NO;
    
    if (self.itemBlock)
    {
        self.itemBlock(1);
    }
}




@end
