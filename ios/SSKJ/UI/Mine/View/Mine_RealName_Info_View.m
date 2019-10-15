//
//  Mine_RealName_Info_View.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/5/17.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Mine_RealName_Info_View.h"

@implementation Mine_RealName_Info_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self titleLabel];
        
        [self nameBgView];
        
        [self nameTextField];
        
        [self cardNameBgView];
        
        [self cardNameTextField];
        
        [self cardAddressBgView];
        
        [self cardAddressTextField];
        
        [self cardNumBgView];
        
        [self cardNumTextField];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"基本资料", nil) textColor:kMainBlackColor font:systemFont(ScaleW(15))];
        
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.height.equalTo(@(ScaleW(15)));
        }];
    }
    return _titleLabel;
}

- (UIView *)nameBgView{
    if (_nameBgView == nil) {
        _nameBgView = [FactoryUI createViewWithFrame:CGRectZero Color:kMainWihteColor];
        [self addSubview:_nameBgView];
        [_nameBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(ScaleW(15));
            make.height.equalTo(@(ScaleW(50)));
        }];
    }
    return _nameBgView;
}

- (UITextField *)nameTextField{
    if (_nameTextField == nil) {
        _nameTextField = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:SSKJLocalized(@"请输入姓名", nil)];
        _nameTextField.font = systemFont(ScaleW(15));
        [self.nameBgView addSubview:_nameTextField];
        [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(@0);
            make.left.equalTo(@(ScaleW(15)));
        }];
    }
    return _nameTextField;
}

- (UIView *)cardNameBgView{
    if (_cardNameBgView == nil) {
        _cardNameBgView = [FactoryUI createViewWithFrame:CGRectZero Color:kMainWihteColor];
        [self addSubview:_cardNameBgView];
        [_cardNameBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(self.nameBgView.mas_bottom).offset(ScaleW(1));
            make.height.equalTo(@(ScaleW(50)));
        }];
    }
    return _cardNameBgView;
}

- (UITextField *)cardNameTextField{
    if (_cardNameTextField == nil) {
        _cardNameTextField = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:SSKJLocalized(@"请输入银行卡类型，例如中国银行", nil)];
        _cardNameTextField.font = systemFont(ScaleW(15));
        [self.cardNameBgView addSubview:_cardNameTextField];
        [_cardNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(@0);
            make.left.equalTo(@(ScaleW(15)));
        }];
    }
    return _cardNameTextField;
}

- (UIView *)cardAddressBgView{
    if (_cardAddressBgView == nil) {
        _cardAddressBgView = [FactoryUI createViewWithFrame:CGRectZero Color:kMainWihteColor];
        [self addSubview:_cardAddressBgView];
        [_cardAddressBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(self.cardNameBgView.mas_bottom).offset(ScaleW(1));
            make.height.equalTo(@(ScaleW(50)));
        }];
    }
    return _cardAddressBgView;
}

- (UITextField *)cardAddressTextField{
    if (_cardAddressTextField == nil) {
        _cardAddressTextField = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:SSKJLocalized(@"请输入开户行", nil)];
        _cardAddressTextField.font = systemFont(ScaleW(15));
        [self.cardAddressBgView addSubview:_cardAddressTextField];
        [_cardAddressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(@0);
            make.left.equalTo(@(ScaleW(15)));
        }];
    }
    return _cardAddressTextField;
}

- (UIView *)cardNumBgView{
    if (_cardNumBgView == nil) {
        _cardNumBgView = [FactoryUI createViewWithFrame:CGRectZero Color:kMainWihteColor];
        [self addSubview:_cardNumBgView];
        [_cardNumBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(self.cardAddressBgView.mas_bottom).offset(ScaleW(1));
            make.height.equalTo(@(ScaleW(50)));
        }];
    }
    return _cardNumBgView;
}

- (UITextField *)cardNumTextField{
    if (_cardNumTextField == nil) {
        _cardNumTextField = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:SSKJLocalized(@"请输入您要出入金的银行卡号", nil)];
        _cardNumTextField.font = systemFont(ScaleW(15));
        _cardNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self.cardNumBgView addSubview:_cardNumTextField];
        [_cardNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(@0);
            make.left.equalTo(@(ScaleW(15)));
        }];
    }
    return _cardNumTextField;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
