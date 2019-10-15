//
//  Market_Index_Title_Section_View.m
//  ZYW_MIT
//
//  Created by James on 2018/8/22.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Index_Title_Section_View.h"

@implementation Market_Index_Title_Section_View

#pragma mark - 初始化
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithReuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
        self.contentView.backgroundColor=kMainWihteColor;
        
        [self createUI];
    }
    
    return self;
}

#pragma mark - 创建UI
-(void)createUI
{
    //币种
    [self coinLabel];
    
    //最新价格
    [self priceLabel];
    
    //涨跌幅
    [self rateLabel];
    
    //分割线
    [self lineView];
}

#pragma mark - 币种
-(UILabel *)coinLabel
{
    if (_coinLabel==nil)
    {
        _coinLabel=[[UILabel alloc] init];
        
        _coinLabel.font=WLFontSize(14.0);
        
        _coinLabel.textColor=UIColorFromRGB(0xbbbbbb);
        
        _coinLabel.text=SSKJLocalized(@"名称/代码", nil);
        
        [self.contentView addSubview:_coinLabel];
        
        [_coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@15);
            
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    
    return _coinLabel;
}

#pragma mark - 最新价格
-(UILabel *)priceLabel
{
    if (_priceLabel==nil)
    {
        _priceLabel=[[UILabel alloc] init];
        
        _priceLabel.font=WLFontSize(14.0);
        
        _priceLabel.textColor=UIColorFromRGB(0xbbbbbb);
        
        _priceLabel.text=SSKJLocalized(@"最新价格", nil);
        
        [self.contentView addSubview:_priceLabel];
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.contentView.mas_centerX).offset(20);
            
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    
    return _priceLabel;
}

#pragma mark - 涨跌幅
-(UILabel *)rateLabel
{
    if (_rateLabel==nil)
    {
        _rateLabel=[[UILabel alloc] init];
        
        _rateLabel.font=WLFontSize(14.0);
        
        _rateLabel.textColor=UIColorFromRGB(0xbbbbbb);
        
        _rateLabel.text=SSKJLocalized(@"涨跌幅", nil);
        
        [self.contentView addSubview:_rateLabel];
        
        [_rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    
    return _rateLabel;
}

#pragma mark - 分割线
-(UIView *)lineView
{
    if (_lineView==nil)
    {
        _lineView=[[UIView alloc] init];
        
        _lineView.backgroundColor=LineGrayColor;

        [self.contentView addSubview:_lineView];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@0);
            
            make.width.equalTo(@(ScreenWidth));
            
            make.height.equalTo(@0.5);
            
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
    
    return _lineView;
}


@end
