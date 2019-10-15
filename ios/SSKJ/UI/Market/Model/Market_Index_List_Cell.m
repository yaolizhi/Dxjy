//
//  Market_Index_List_Cell.m
//  ZYW_MIT
//
//  Created by James on 2018/8/22.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Index_List_Cell.h"
//#import "UILabel+WJFUN.h"
@implementation Market_Index_List_Cell

#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.contentView.backgroundColor=kMainWihteColor;
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [self createUI];
    }
    
    return self;
}

#pragma mark - 创建UI
-(void)createUI
{
    
    //币种名称
    [self coinNameLabel];
    
    //代码
    [self codeLabel];
    
    //价格
    [self priceLabel];
    
    //涨跌幅
    [self rateButton];
    
    //分割线
    [self lineView];
    
}


#pragma mark - 名称
-(UILabel *)coinNameLabel
{
    if (_coinNameLabel==nil)
    {
        _coinNameLabel=[[UILabel alloc] init];
        
        _coinNameLabel.font=WLFontSize(14.0);
        
        _coinNameLabel.text = @"中国黄金";
        
        _coinNameLabel.textColor=kMainBlackColor;
        
        [self.contentView addSubview:_coinNameLabel];
        
        [_coinNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@15);
            
            make.top.equalTo(@15);
            
            make.height.equalTo(@20);
        }];
    }
    
    return _coinNameLabel;
}

#pragma mark - 代码
-(UILabel *)codeLabel
{
    if (_codeLabel==nil)
    {
        _codeLabel=[[UILabel alloc] init];
        
        _codeLabel.font=WLFontSize(14.0);
        
        _codeLabel.text = @"234";
        
        _codeLabel.textColor=kMainDarkBlackColor;
        
        [self.contentView addSubview:_codeLabel];
        
        [_codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@15);
            
            make.bottom.equalTo(@(-15));
            
            make.height.equalTo(@20);
        }];
    }
    
    return _codeLabel;
}



#pragma mark - 涨跌幅按钮
-(UIButton *)rateButton
{
    if (_rateButton==nil)
    {
        _rateButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_rateButton setBackgroundColor:RED_HEX_COLOR];
        
        [_rateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_rateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        _rateButton.titleLabel.font=WLFontSize(14.0);
        
        [_rateButton setTitle:@"+2.00%" forState:UIControlStateNormal];
        
        _rateButton.layer.masksToBounds=YES;
        
        _rateButton.layer.cornerRadius=35/2;
        
        [self.contentView addSubview:_rateButton];
        
        [_rateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            
            make.centerY.equalTo(self.contentView.mas_centerY);
            
            make.height.equalTo(@35);
            
            make.width.equalTo(@80);
        }];
    }
    
    return _rateButton;
}

#pragma mark - 价格
-(UILabel *)priceLabel
{
    if (_priceLabel==nil)
    {
        _priceLabel=[[UILabel alloc] init];
        
        _priceLabel.font=WLFontSize(14.0);
        
        _priceLabel.textColor=kMainBlackColor;
        
        _priceLabel.text = @"3000.0000";
        
        [self.contentView addSubview:_priceLabel];
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.contentView.mas_centerX).offset(20);
            
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    
    return _priceLabel;
}

#pragma mark - 分割线
-(UIView *)lineView
{
    if (_lineView==nil)
    {
        _lineView=[[UIView alloc] init];
        
        _lineView.backgroundColor=UIColorFromRGB(0xF5F5F5);

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

//-(void)initWithCellModel:(Market_Index_List_Model *)model
//{
//    //币种图标
//    self.coinIMV.image=[UIImage imageNamed:model.name];
//
//    //币种名称
//    self.coinNameLabel.text=[NSString stringWithFormat:@"%@/USDT",model.name];
//    [self.coinNameLabel text:@"/USDT" color:UIColorFromRGB(0x999999) font:WLFontSize(14.0)];
//
//    //价格
//     self.priceLabel.text=[NSString stringWithFormat:@"%.4f",[model.price doubleValue] ];
//
//    //人民币
//    self.cnyLabel.text=[NSString stringWithFormat:@"≈%@ CNY",[WLTools notRounding:[model.cnyPrice floatValue] afterPoint:2]];
//
//    //涨跌幅
//    if ([model.changeRate containsString:@"-"])
//    {
//        [self.rateButton setBackgroundColor:LowTextColor];
//
//        [self.rateButton setTitle:model.changeRate forState:UIControlStateNormal];
//
//    }
//    else
//    {
//        [self.rateButton setBackgroundColor:HeightTextColor];
//
//        [self.rateButton setTitle:[NSString stringWithFormat:@"+%@",model.changeRate] forState:UIControlStateNormal];
//    }
//
//
//
//    //最新价格
//    self.priceLabel.textColor = self.rateButton.backgroundColor;
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC);
//    WS(weakSelf);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//        weakSelf.priceLabel.textColor = UIColorFromRGB(0xffffff);
//    });
//
//
//}

-(NSString *)decimalNumberWithDouble:(double)conversionValue
{
    NSString *doubleString  = [NSString stringWithFormat:@"%.4lf", conversionValue];
    
    NSDecimalNumber *decNumber  = [NSDecimalNumber decimalNumberWithString:doubleString];
    
    return [decNumber stringValue];
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
