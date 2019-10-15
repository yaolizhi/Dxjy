//
//  Market_Chart_Detail_Price_Section_View.m
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Chart_Detail_Price_Section_View.h"
#define bottomLineHeight 5.f
#define headLineHeight 1.f
@interface Market_Chart_Detail_Price_Section_View()

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UIView *headerLine;

@end
@implementation Market_Chart_Detail_Price_Section_View

#pragma mark - 初始化
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithReuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.contentView.backgroundColor=[WLTools stringToColor:@"#ffffff"];
        
        [self createUI];
    }
    
    return self;
}
-(UIView *)headerLine{
    if (!_headerLine) {
        _headerLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, headLineHeight)];
        [self addSubview:_headerLine];
    }
    return _headerLine;
}
#pragma mark - 创建UI
-(void)createUI
{
    [self headerLine];
    //当前价格
    [self priceLabel];
    
    //涨跌幅
    [self rateLabel];
    //人民币
    [self cnyPriceLabel];
  
    
    //高
    
    [self heightValueLabel];
    
    [self heightLabel];
    
   
    
    //低
    [self lowValueLabel];
    
    [self lowLabel];
    
   
    [self addSubview:self.bottomLine];
    
    [self senctionView];
}

-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.bottom - bottomLineHeight , ScreenWidth, bottomLineHeight)];
        _bottomLine.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _bottomLine;
}

#pragma mark - 人民币
-(UILabel *)cnyPriceLabel
{
    if (_cnyPriceLabel==nil)
    {
        _cnyPriceLabel=[[UILabel alloc] init];
        
        _cnyPriceLabel.text=@"";
        
        _cnyPriceLabel.font=WLFontSize(14.0);
        
        _cnyPriceLabel.hidden = YES;
        
        _cnyPriceLabel.textColor=UIColorFromRGB(0x5c6c90);
        
        [self addSubview:_cnyPriceLabel];
        
        [_cnyPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.rateLabel.mas_right).offset(12);
        
            
            make.top.equalTo(self.priceLabel.mas_bottom).offset(12);
        }];
    }
    
    return _cnyPriceLabel;
}

#pragma mark - 当前价格
-(UILabel *)priceLabel
{
    if (_priceLabel==nil)
    {
        _priceLabel=[[UILabel alloc] init];
        
        _priceLabel.font=[UIFont boldSystemFontOfSize:30.0];
        
        _priceLabel.textColor=RED_HEX_COLOR;
        
        [self.contentView addSubview:_priceLabel];
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@15);
            
            make.top.equalTo(@20);
        }];
        
    }
    
    return _priceLabel;
}

#pragma mark  - 涨跌幅
-(UILabel *)rateLabel
{
    if (_rateLabel==nil)
    {
        _rateLabel=[[UILabel alloc] init];
        
        _rateLabel.font=WLFontSize(16.0);
        
        _rateLabel.textColor=RED_HEX_COLOR;
        
        [self.contentView addSubview:_rateLabel];
        
        [_rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.priceLabel.mas_left);
            
            make.top.equalTo(self.priceLabel.mas_bottom).offset(12);
        }];
    }
    
    return _rateLabel;
}

#pragma mark - 高标签
-(UILabel *)heightLabel
{
    if (_heightLabel==nil)
    {
        _heightLabel=[[UILabel alloc] init];
        
        _heightLabel.textColor=RGBCOLOR16(0x666666);
        
        _heightLabel.font=WLFontSize(14.0);
        
        _heightLabel.text=SSKJLocalized(@"高 ", nil);
        
        [self.contentView addSubview:_heightLabel];
        
        [_heightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.priceLabel.mas_top).offset(5);
            
            make.right.equalTo(@(ScaleW(-115)));
        }];
    }
    
    return _heightLabel;
}

#pragma mark - 高 值标签
-(UILabel *)heightValueLabel
{
    if (_heightValueLabel==nil)
    {
        _heightValueLabel=[[UILabel alloc] init];
        
        _heightValueLabel.textColor=RGBCOLOR16(0x666666);
        
        _heightValueLabel.font=WLFontSize(14.0);
        
        [self.contentView addSubview:_heightValueLabel];
        
        [_heightValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.heightLabel.mas_bottom);
            
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];
    }
    
    return _heightValueLabel;
}

#pragma mark - 低标签
-(UILabel *)lowLabel
{
    if (_lowLabel==nil)
    {
        _lowLabel=[[UILabel alloc] init];
        
        _lowLabel.textColor=RGBCOLOR16(0x666666);
        
        _lowLabel.font=WLFontSize(14.0);
        
        _lowLabel.text=SSKJLocalized(@"低 ", nil);
        
        [self.contentView addSubview:_lowLabel];
        
        [_lowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.heightLabel.mas_left);
            
            make.bottom.equalTo(self.cnyPriceLabel.mas_bottom);
            
        }];
    }
    
    return _lowLabel;
}

#pragma mark - 低 值标签
-(UILabel *)lowValueLabel
{
    if (_lowValueLabel==nil)
    {
        _lowValueLabel=[[UILabel alloc] init];
        
        _lowValueLabel.textColor=RGBCOLOR16(0x666666);
        
        _lowValueLabel.font=WLFontSize(14.0);
        
        [self.contentView addSubview:_lowValueLabel];
        
        [_lowValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.heightValueLabel.mas_right);
            
            make.bottom.equalTo(self.cnyPriceLabel.mas_bottom);
        }];
    }
    
    return _lowValueLabel;
}

-(UIView *)senctionView
{
    if (!_senctionView) {
        _senctionView = [[UIView alloc]init];
        _senctionView.width = Screen_Width;
        _senctionView.height = 10;
        _senctionView.top = 100;
        _senctionView.left = 0;
        _senctionView.backgroundColor = RGBCOLOR16(0xf5F5F5);
        [self addSubview:_senctionView];
    }
    return _senctionView;
}

#pragma mark - 各个控件赋值
-(void)initWithSectionModel:(Market_Main_List_Model *)model
{
    //当前价格
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",model.price.doubleValue];
//    [WLTools noroundingStringWith:model.price.doubleValue afterPointNumber:6];
    //涨跌幅
    self.rateLabel.text=model.changeRate;
    
    if ([model.changeRate containsString:@"-"])
    {
        self.rateLabel.textColor=GREEN_HEX_COLOR ;
        
        self.priceLabel.textColor=GREEN_HEX_COLOR;
    }
    else
    {
        self.rateLabel.textColor=RED_HEX_COLOR;
        
        self.priceLabel.textColor=RED_HEX_COLOR;
        
        self.rateLabel.text=[NSString stringWithFormat:@"+%@",model.changeRate];

    }
    
    //高
//    self.heightValueLabel.text= [NSString stringWithFormat:@"%.2f",model.stockProductVO.high.doubleValue];
    self.heightValueLabel.text = [WLTools noroundingStringWith:model.high.doubleValue afterPointNumber:2];
    
    //低
//    self.lowValueLabel.text=[NSString stringWithFormat:@"%.2f",model.stockProductVO.low.doubleValue];
    self.lowValueLabel.text = [WLTools noroundingStringWith:model.low.doubleValue afterPointNumber:2];
    
    //人民币
    self.cnyPriceLabel.text=[NSString stringWithFormat:@"≈%.2fCNY",model.stockProductVO.cnyPrice.doubleValue];
}

#pragma mark - 各个控件赋值

- (void)setSocketProductModel:(Market_Main_List_SocketProduct_Model *)socketProductModel
{
    _socketProductModel = socketProductModel;
    //当前价格
  
    if (_priceLabel.text.doubleValue == 0) {
    }
//      self.priceLabel.text=[NSString stringWithFormat:@"%.2f",_socketProductModel.price.doubleValue];
    self.priceLabel.text = [WLTools noroundingStringWith:_socketProductModel.price.doubleValue afterPointNumber:6];
    
    
    //涨跌幅
    self.rateLabel.text=_socketProductModel.changeRate;
    
    if ([_socketProductModel.changeRate containsString:@"-"])
    {
        self.rateLabel.textColor=RED_HEX_COLOR;
        
        self.priceLabel.textColor=RED_HEX_COLOR;
    }
    else
    {
        self.rateLabel.textColor=GREEN_HEX_COLOR;
        
        self.priceLabel.textColor=GREEN_HEX_COLOR;
        
    }
    
    //高
    self.heightValueLabel.text=[WLTools noZero:[_socketProductModel.high doubleValue] afterPoint:2];
//    self.heightValueLabel.text = _socketProductModel.high.doubleValue;
    
    //低
    self.lowValueLabel.text=[WLTools noZero:[_socketProductModel.low doubleValue] afterPoint:2];
//    self.lowValueLabel.text = _socketProductModel.low;
    
    self.cnyPriceLabel.text=[NSString stringWithFormat:@"≈%.2fCNY",_socketProductModel.cnyPrice.doubleValue];
    
    
}

- (void)setIsLightSkin:(BOOL)isLightSkin
{
    _isLightSkin = isLightSkin;
    
    if (isLightSkin)
    {
        self.contentView.backgroundColor = [WLTools stringToColor:@"#141724"];
        
        self.cnyPriceLabel.textColor = RGBCOLOR16(0x999999);

        //高
        self.heightValueLabel.textColor = RGBCOLOR16(0x7591b4);

        //低
        self.lowValueLabel.textColor = RGBCOLOR16(0x7591b4);
        
        self.heightLabel.textColor = RGBCOLOR16(0x7591b4);
        
        self.lowLabel.textColor = RGBCOLOR16(0x7591b4);
    }
    
}

-(void)changeUIAction
{
//    if (_priceLabel==nil)
//    {
//        _priceLabel=[[UILabel alloc] init];
//
//        _priceLabel.font=[UIFont boldSystemFontOfSize:30.0];
//
//        _priceLabel.textColor=RedColor;
//
//        [self.contentView addSubview:_priceLabel];
//
//        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(@15);
//
//            make.top.equalTo(@20);
//        }];
//
//    }
//
//    return _priceLabel;
   _priceLabel.font=[UIFont boldSystemFontOfSize:17.0];
    _heightLabel.textColor = _lowLabel.textColor = _heightValueLabel.textColor = _lowValueLabel.textColor = [WLTools stringToColor:@"#adc1f1"];
    
};
@end
