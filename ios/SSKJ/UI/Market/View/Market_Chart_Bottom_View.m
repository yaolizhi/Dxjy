//
//  Market_Chart_Bottom_View.m
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Chart_Bottom_View.h"

@interface Market_Chart_Bottom_View()

@property(nonatomic,assign)CGFloat spaceWidth;

@end



@implementation Market_Chart_Bottom_View

#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if (self)
    {
        
        self.spaceWidth=(ScreenWidth-10*2-13)/2;
        
        self.backgroundColor=[WLTools stringToColor:@"#ffffff"];
        
        [self createUI];
    }
    
    return self;
}

#pragma mark - 创建UI
-(void)createUI
{
    //币币交易
    [self coinButton];
    
    //合约交易
    [self contractButton];
}

#pragma mark - 币币交易
-(UIButton *)coinButton
{
    if (_coinButton==nil)
    {
        _coinButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        _coinButton.height = 45;
        _coinButton.width = self.spaceWidth;
        _coinButton.left = 10;
        _coinButton.centerY = self.height/2.f;
        
        [_coinButton setTitle:SSKJLocalized(@"做多", nil) forState:UIControlStateNormal];
        
        [_coinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _coinButton.titleLabel.font=WLFontSize(15.0);
        
        _coinButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        _coinButton.layer.masksToBounds=YES;
        
        _coinButton.layer.cornerRadius=5;
        
        [_coinButton setBackgroundColor:RED_HEX_COLOR];
        
        [_coinButton addTarget:self action:@selector(contract_Button_Event:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_coinButton];
        
//        [_coinButton mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(@10);
//
//            make.centerY.equalTo(self.mas_centerY);
//
//            make.height.equalTo(@45);
//
//            make.width.equalTo(@(self.spaceWidth));
//        }];
      
       
    }
    
    return _coinButton;
}

#pragma mark - 合约交易
-(UIButton *)contractButton
{
    if (_contractButton==nil)
    {
        _contractButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        _contractButton.width = _coinButton.width;
        _contractButton.height = _coinButton.height;
        _contractButton.left = _coinButton.right + 13;
        _contractButton.centerY = self.height/2.f;
        
        [_contractButton setTitle:SSKJLocalized(@"做空", nil) forState:UIControlStateNormal];
        
        [_contractButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _contractButton.titleLabel.font=WLFontSize(15.0);
        
        _contractButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        _contractButton.layer.masksToBounds=YES;
        
        _contractButton.layer.cornerRadius=5;
        
        [_contractButton setBackgroundColor:GREEN_HEX_COLOR];
        
        [_contractButton addTarget:self action:@selector(coin_Button_Event:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_contractButton];
        
//        [_contractButton mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(self.coinButton.mas_right).offset(13);
//
//            make.centerY.equalTo(self.mas_centerY);
//
//            make.height.equalTo(self.coinButton.mas_height);
//
//            make.width.equalTo(self.coinButton.mas_width);
//        }];
        
      
    }
    
    return _contractButton;
}

#pragma mark - 币币交易按钮 点击事件
-(void)coin_Button_Event:(UIButton *)sender
{
    if (self.itmeBlock)
    {
        self.itmeBlock(1);
    }
}

#pragma mark - 合约交易按钮 点击事件
-(void)contract_Button_Event:(UIButton *)sender
{
    if (self.itmeBlock)
    {
        self.itmeBlock(2);
    }
}

-(void)oneSingleClicked
{
    _contractButton.hidden = NO;
    _coinButton.hidden = YES;
    
    _contractButton.width = (ScreenWidth-10*2-13);
    _contractButton.height = 45;
    _contractButton.left   = 10;
    _contractButton.centerX = ScreenWidth/2.f;
   

};


@end
