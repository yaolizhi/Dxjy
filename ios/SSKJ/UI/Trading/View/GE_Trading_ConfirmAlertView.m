//
//  GE_Trading_ConfirmAlertView.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Trading_ConfirmAlertView.h"

@interface GE_Trading_ConfirmAlertView()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIView *showView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *codeLabel;

@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *statusLabel;


@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UILabel *stopWinLabel;

@property (nonatomic, strong) UILabel *stopLowLabel;

@property (nonatomic, strong) UILabel *nametitle;

@property (nonatomic, strong) UILabel *codetitle;

@property (nonatomic, strong) UILabel *typetitle;

@property (nonatomic, strong) UILabel *statustitle;

@property (nonatomic, strong) UILabel *pricetitle;

@property (nonatomic, strong) UILabel *numbertitle;

@property (nonatomic, strong) UILabel *stopWintitle;

@property (nonatomic, strong) UILabel *stopLowtitle;

@property (nonatomic, strong) UIButton *cancleButton;           // 取消按钮

@property (nonatomic, strong) UIButton *confirmButton;          // 确认按钮

@property (nonatomic, strong) NSDictionary *dic;

@end

@implementation GE_Trading_ConfirmAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.backView];
        
        [self addSubview:self.showView];
        
        [self nametitle];
        
        [self nameLabel];
        
        [self codetitle];
        
        [self codeLabel];
        
        [self typetitle];
        
        [self typeLabel];
        
        [self statustitle];
        
        [self statusLabel];
        
        [self pricetitle];
        
        [self priceLabel];
        
        [self stopWintitle];
        
        [self stopWinLabel];
        
        [self numbertitle];
        
        [self numberLabel];
        
        [self stopLowtitle];
        
        [self stopLowLabel];
        
        
        
        
        [self.showView addSubview:self.cancleButton];
        
        [self.showView addSubview:self.confirmButton];
 
        self.showView.centerX = ScreenWidth / 2;
        
        self.showView.centerY = ScreenHeight / 2;
    }
    return self;
}


-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.3;
    }
    return _backView;
}

-(UIView *)showView
{
    if (nil == _showView) {
        _showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - ScaleW(60),ScaleH(205))];
        _showView.backgroundColor = [UIColor whiteColor];
        _showView.layer.cornerRadius = 5.0f;
        _showView.layer.masksToBounds = YES;
    }
    return _showView;
}

- (UILabel *)nametitle
{
    if (!_nametitle) {
        
        _nametitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"名称" textColor:kMainBlackColor font:systemFont(ScaleW(13))];
        
        _nametitle.adjustsFontSizeToFitWidth = YES;
        
        [self.showView addSubview:_nametitle];
        
        [_nametitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(ScaleH(35)));
            
            make.left.equalTo(@(ScaleW(40)));
            
            make.height.equalTo(@(ScaleH(15)));
            
            make.width.equalTo(@(ScaleW(30)));
        }];
    }
    return _nametitle;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        
        _nameLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kMainGrayColor font:systemFont(ScaleW(13))];
        
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        
        [self.showView addSubview:_nameLabel];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@(ScaleH(35)));
            
            make.left.equalTo(self.nametitle.mas_right).offset(ScaleW(15));
            
            make.height.equalTo(@(ScaleH(15)));
            
        }];
    }
    return _nameLabel;
}

- (UILabel *)codetitle
{
    if (!_codetitle) {
        
        _codetitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"代码" textColor:kMainBlackColor font:systemFont(ScaleW(13))];
        
        _codetitle.adjustsFontSizeToFitWidth = YES;
        
        [self.showView addSubview:_codetitle];
        
        [_codetitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(ScaleH(35)));
            
            make.left.equalTo(@(ScreenWidth / 2 + ScaleW(10)));
            
            make.height.equalTo(@(ScaleH(15)));
            
            make.width.equalTo(@(ScaleW(30)));
        }];
    }
    return _codetitle;
}

- (UILabel *)codeLabel
{
    if (!_codeLabel) {
        
        _codeLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kMainGrayColor font:systemFont(ScaleW(13))];
        
         _codeLabel.adjustsFontSizeToFitWidth = YES;
        
        [self.showView addSubview:_codeLabel];
        
        [_codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@(ScaleH(35)));
            
            make.left.equalTo(self.codetitle.mas_right).offset(ScaleW(15));
            
            make.height.equalTo(@(ScaleH(15)));
            
            make.right.equalTo(@(ScaleH(0)));
            
        }];
    }
    return _codeLabel;
}

- (UILabel *)typetitle
{
    if (!_typetitle) {
        
        _typetitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"数量" textColor:kMainBlackColor font:systemFont(ScaleW(13))];
        
        _typetitle.adjustsFontSizeToFitWidth = YES;
        
        [self.showView addSubview:_typetitle];
        
        [_typetitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.nametitle.mas_bottom).offset(ScaleH(17));
            
            make.left.equalTo(@(ScaleW(40)));
            
            make.height.equalTo(@(ScaleH(15)));
            
            make.width.equalTo(@(ScaleW(30)));
        }];
    }
    return _typetitle;
}

- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        
        _typeLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kMainGrayColor font:systemFont(ScaleW(13))];
        
        _typeLabel.adjustsFontSizeToFitWidth = YES;
        
        [self.showView addSubview:_typeLabel];
        
        [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.nametitle.mas_bottom).offset(ScaleH(17));

            make.left.equalTo(self.nametitle.mas_right).offset(ScaleW(15));
            
            make.height.equalTo(@(ScaleH(15)));
            
        }];
    }
    return _typeLabel;
}

- (UILabel *)statustitle
{
    if (!_statustitle) {
        
        _statustitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"方向" textColor:kMainBlackColor font:systemFont(ScaleW(13))];
        
        _statustitle.adjustsFontSizeToFitWidth = YES;
        
        [self.showView addSubview:_statustitle];
        
        [_statustitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.nametitle.mas_bottom).offset(ScaleH(17));

            make.left.equalTo(@(ScreenWidth / 2 + ScaleW(10)));
            
            make.height.equalTo(@(ScaleH(15)));
            
            make.width.equalTo(@(ScaleW(30)));
        }];
    }
    return _statustitle;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        
        _statusLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kMainGrayColor font:systemFont(ScaleW(13))];
        
        _statusLabel.adjustsFontSizeToFitWidth = YES;
        
        [self.showView addSubview:_statusLabel];
        
        [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.nametitle.mas_bottom).offset(ScaleH(17));

            make.left.equalTo(self.codetitle.mas_right).offset(ScaleW(15));
            
            make.height.equalTo(@(ScaleH(15)));
            
            make.right.equalTo(@(ScaleH(0)));
        }];
    }
    return _statusLabel;
}

- (UILabel *)pricetitle
{
    if (!_pricetitle) {
        
        _pricetitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"价格" textColor:kMainBlackColor font:systemFont(ScaleW(13))];
        
        _pricetitle.adjustsFontSizeToFitWidth = YES;
        
        [self.showView addSubview:_pricetitle];
        
        [_pricetitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.typetitle.mas_bottom).offset(ScaleH(17));

            make.left.equalTo(@(ScaleW(40)));
            
            make.height.equalTo(@(ScaleH(15)));
            
            make.width.equalTo(@(ScaleW(30)));
        }];
    }
    return _pricetitle;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        
        _priceLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kMainGrayColor font:systemFont(ScaleW(13))];
        
        _priceLabel.adjustsFontSizeToFitWidth = YES;
        
        [self.showView addSubview:_priceLabel];
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.typetitle.mas_bottom).offset(ScaleH(17));

            make.left.equalTo(self.pricetitle.mas_right).offset(ScaleW(15));
            
            make.height.equalTo(@(ScaleH(15)));
            
        }];
    }
    return _priceLabel;
}

- (UILabel *)stopWintitle
{
    if (!_stopWintitle) {

        _stopWintitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"止盈" textColor:kMainBlackColor font:systemFont(ScaleW(13))];

        _stopWintitle.adjustsFontSizeToFitWidth = YES;
        
        _stopWintitle.hidden = YES;
        
        [self.showView addSubview:_stopWintitle];

        [_stopWintitle mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.equalTo(self.pricetitle.mas_bottom).offset(ScaleH(17));

            make.left.equalTo(@(ScaleW(40)));

            make.height.equalTo(@(ScaleH(15)));

            make.width.equalTo(@(ScaleW(30)));
        }];
    }
    return _stopWintitle;
}

- (UILabel *)stopWinLabel
{
    if (!_stopWinLabel) {

        _stopWinLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kMainGrayColor font:systemFont(ScaleW(13))];

        _stopWinLabel.adjustsFontSizeToFitWidth = YES;
        
        _stopWinLabel.hidden = YES;
        
        [self.showView addSubview:_stopWinLabel];

        [_stopWinLabel mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.equalTo(self.pricetitle.mas_bottom).offset(ScaleH(17));

            make.left.equalTo(self.stopWintitle.mas_right).offset(ScaleW(15));

            make.height.equalTo(@(ScaleH(15)));

        }];
    }
    return _stopWinLabel;
}

- (UILabel *)numbertitle
{
    if (!_numbertitle) {

        _numbertitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"数量" textColor:kMainBlackColor font:systemFont(ScaleW(13))];

        _numbertitle.adjustsFontSizeToFitWidth = YES;
        
        _numbertitle.hidden = YES;
        
        [self.showView addSubview:_numbertitle];

        [_numbertitle mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.equalTo(self.typetitle.mas_bottom).offset(ScaleH(17));

            make.left.equalTo(@(ScreenWidth / 2 + ScaleW(10)));

            make.height.equalTo(@(ScaleH(15)));

            make.width.equalTo(@(ScaleW(30)));
        }];
    }
    return _numbertitle;
}

- (UILabel *)numberLabel
{
    if (!_numberLabel) {

        _numberLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kMainGrayColor font:systemFont(ScaleW(13))];

        _numberLabel.adjustsFontSizeToFitWidth = YES;
        
        _numberLabel.hidden = YES;
        
        [self.showView addSubview:_numberLabel];

        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.equalTo(self.typetitle.mas_bottom).offset(ScaleH(17));

            make.left.equalTo(self.numbertitle.mas_right).offset(ScaleW(15));

            make.height.equalTo(@(ScaleH(15)));
            
            make.right.equalTo(@(ScaleH(0)));

        }];
    }
    return _numberLabel;
}

- (UILabel *)stopLowtitle
{
    if (!_stopLowtitle) {
        
        _stopLowtitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"止损" textColor:kMainBlackColor font:systemFont(ScaleW(13))];
       
        _stopLowtitle.adjustsFontSizeToFitWidth = YES;
        
        _stopLowtitle.hidden = YES;
        
        [self.showView addSubview:_stopLowtitle];
        
        [_stopLowtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.pricetitle.mas_bottom).offset(ScaleH(17));

            make.left.equalTo(@(ScreenWidth / 2 + ScaleW(10)));
            
            make.height.equalTo(@(ScaleH(0)));
            
            make.width.equalTo(@(ScaleW(30)));
        }];
    }
    return _stopLowtitle;
}

- (UILabel *)stopLowLabel
{
    if (!_stopLowLabel) {
        
        _stopLowLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kMainGrayColor font:systemFont(ScaleW(13))];
        
        _stopLowLabel.adjustsFontSizeToFitWidth = YES;
        
        _stopLowLabel.hidden = YES;
        
        [self.showView addSubview:_stopLowLabel];
        
        [_stopLowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.pricetitle.mas_bottom).offset(ScaleH(17));

            make.left.equalTo(self.stopLowtitle.mas_right).offset(ScaleW(15));
            
            make.height.equalTo(@(ScaleH(0)));
            
            make.right.equalTo(@(ScaleH(0)));
        }];
    }
    return _stopLowLabel;
}

-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.stopWinLabel.bottom + 40, self.showView.width / 2, ScaleH(50))];
        [_cancleButton setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kMainBlackColor forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self.showView addSubview:_cancleButton];
        [_cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.stopLowtitle.mas_bottom).offset(ScaleH(20));
            
            make.left.equalTo(@0);
            
            make.height.equalTo(@(ScaleH(40)));
            
            make.width.equalTo(@((ScreenWidth - ScaleW(60)) / 2));
            
        }];
    }
    return _cancleButton;
}


-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.cancleButton.right, self.cancleButton.y, self.cancleButton.width, self.cancleButton.height)];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainColor forState:UIControlStateNormal];
        [_confirmButton setTitle:SSKJLocalized(@"确定", nil) forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        [self.showView addSubview:_confirmButton];
        [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.stopLowtitle.mas_bottom).offset(ScaleH(20));
            
            make.left.equalTo(self.cancleButton.mas_right);
            
            make.height.equalTo(@(ScaleH(40)));
            
            make.width.equalTo(@((ScreenWidth - ScaleW(60)) / 2));
            
        }];
    }
    return _confirmButton;
}

-(void)showWithData:(NSDictionary *)data
{
    _dic = data;
    self.nameLabel.text = data[@"code"];
    self.codeLabel.text = data[@"shopname"];
    self.statusLabel.text = [data[@"otype"] integerValue] == 1 ? SSKJLocalized(@"做多", nil):SSKJLocalized(@"做空", nil);
    self.statusLabel.textColor = [data[@"otype"] integerValue] == 1 ? RED_HEX_COLOR:GREEN_HEX_COLOR;
    
    self.priceLabel.text = [WLTools noroundingStringWith:[data[@"price"] doubleValue] afterPointNumber:6];
    self.typeLabel.text = [NSString stringWithFormat:@"%@",data[@"buynum"]];
    self.stopWinLabel.text = data[@"stopProfitPrice"];
    self.stopLowLabel.text = data[@"stopLossPrice"];
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

-(void)confirm
{
    if (self.ConfirmBlock) {
        self.ConfirmBlock(self.dic);
    }
    
    [self hide];
}

-(void)hide
{
    [self removeFromSuperview];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
