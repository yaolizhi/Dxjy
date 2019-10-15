//
//  Register_BG_View.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/5/17.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Register_BG_View.h"

@implementation Register_BG_View

- (instancetype)initWithFrame:(CGRect)frame titleStr:(NSString *)titleStr textStr:(NSString *)textStr placeholderStr:(NSString *)placeholderStr
{
    self = [super initWithFrame:frame];
    if (self) {
        [self titleLabel];
        
        [self codeBtn];
        
        [self textField];
        
        [self showBtn];
        
        [self lineview];
        
        self.titleLabel.text = titleStr;
        
        self.textField.placeholder = placeholderStr;
    }
    return self;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kMainBlackColor font:systemFont(ScaleW(14))];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(20)));
            make.top.equalTo(@(ScaleW(15)));
            make.height.equalTo(@(ScaleW(15)));
        }];
    }
    return _titleLabel;
}

-(VerifyCodeButton *)codeBtn{
    if (_codeBtn == nil) {
        _codeBtn = [[VerifyCodeButton alloc]init];
        [self addSubview:_codeBtn];
        [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(ScaleW(-20)));
            make.top.equalTo(self.titleLabel.mas_bottom).offset(ScaleW(10));
            make.height.equalTo(@(ScaleW(30)));
            make.width.equalTo(@(ScaleW(80)));
        }];
    }
    return _codeBtn;
}

- (UITextField *)textField{
    if (_textField == nil) {
        _textField = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:@""];
        _textField.font = systemFont(ScaleW(15));
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(20)));
            make.top.equalTo(self.titleLabel.mas_bottom).offset(ScaleW(10));
            make.height.equalTo(@(ScaleW(30)));
            make.right.equalTo(self.codeBtn.mas_left);
        }];
    }
    return _textField;
}

- (UIButton *)showBtn{
    if (_showBtn == nil) {
        _showBtn = [FactoryUI createButtonWithFrame:CGRectZero title:nil titleColor:nil imageName:@"Login_yincang" backgroundImageName:nil target:self selector:@selector(showBtnAcion) font:nil];
        [self addSubview:_showBtn];
        [_showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(ScaleW(-20)));
            make.centerY.equalTo(self.textField.mas_centerY);
            make.height.equalTo(@(ScaleW(40)));
            make.width.equalTo(@(ScaleW(40)));
        }];
    }
    return _showBtn;
}

- (UIView *)lineview{
    if (_lineview == nil) {
        _lineview = [FactoryUI createViewWithFrame:CGRectZero Color:LineGrayColor];
        [self addSubview:_lineview];
        [_lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(20)));
            make.right.equalTo(@(ScaleW(-20)));
            make.bottom.equalTo(@(ScaleW(0)));
            make.height.equalTo(@(ScaleW(1)));
        }];
    }
    return _lineview;
}

- (void)showBtnAcion
{
    self.showBtn.selected = !self.showBtn.selected;
    
    if (self.showBtn.selected) {
        
        self.textField.secureTextEntry = NO;
        
        [self.showBtn setImage:[UIImage imageNamed:@"Login_zhanshi"] forState:UIControlStateNormal];
        
    }
    else
    {
        self.textField.secureTextEntry = YES;
        
        [self.showBtn setImage:[UIImage imageNamed:@"Login_yincang"] forState:UIControlStateNormal];
    }
}

@end
