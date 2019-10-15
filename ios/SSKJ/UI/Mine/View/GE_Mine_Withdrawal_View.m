//
//  GE_Mine_Withdrawal_View.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_Withdrawal_View.h"

@interface GE_Mine_Withdrawal_View()<UITextFieldDelegate>

@property (nonatomic,strong) UIView * bgView;


@end

@implementation GE_Mine_Withdrawal_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self bgView];
        
        [self titleLabel];
        
        [self detailtextField];
    }
    return self;
}

- (UIView *)bgView
{
    if (_bgView == nil) {
        
        _bgView = [FactoryUI createViewWithFrame:CGRectZero Color:UIColorFromRGB(0xffffff)];
        
        [self addSubview:_bgView];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@(0));
            
            make.height.equalTo(@(ScaleH(50)));
            
            make.left.right.equalTo(@(0));
        }];
    }
    return _bgView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        
        _titleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kMainBlackColor font:systemFont(ScaleW(15))];
        
        [self.bgView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.bgView.mas_centerY);
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.width.equalTo(@(ScaleW(90)));
            
            make.height.equalTo(@(ScaleH(15)));
        }];
    }
    return _titleLabel;
}

- (UITextField *)detailtextField
{
    if (_detailtextField == nil) {
        
        _detailtextField = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:@""];
        
        _detailtextField.textAlignment = NSTextAlignmentRight;
        
        _detailtextField.font = [UIFont systemFontOfSize:ScaleW(15)];
        
        _detailtextField.delegate = self;
        
        _detailtextField.textColor = UIColorFromRGB(0x999999);
        
        [self.bgView addSubview:_detailtextField];
        
        [_detailtextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(@0);
            
            make.right.equalTo(@(-15));
            
            make.left.equalTo(self.titleLabel.mas_right).offset(ScaleW(15));
        }];
    }
    return _detailtextField;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    NSString *new_text_str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField == self.detailtextField) {
        
        NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
        [futureString  insertString:string atIndex:range.location];
        NSInteger flag=0;
        const NSInteger limited = 2;//小数点后需要限制的个数
        for (int i = futureString.length-1; i>=0; i--) {
            
            if ([futureString characterAtIndex:i] == '.') {
                if (flag > limited) {
                    return NO;
                }
                break;
            }
            flag++;
        }
    }
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
