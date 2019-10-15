//
//  Home_Search_View.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/5/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Home_Search_View.h"

@implementation Home_Search_View


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        
        self.layer.cornerRadius = ScaleW(15);
        
        self.layer.masksToBounds = YES;
        
        [self searchBtn];
        [self textfield];
    }
    return self;
}

- (UIButton *)searchBtn{
    if (_searchBtn == nil) {
        _searchBtn = [FactoryUI createButtonWithFrame:CGRectZero title:@"" titleColor:nil imageName:@"Trading_Seach" backgroundImageName:nil target:self selector:@selector(searchBtnAction) font:nil];
        [self addSubview:_searchBtn];
        [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(@0);
            make.width.equalTo(@(ScaleW(40)));
        }];
    }
    return _searchBtn;
}

- (UITextField *)textfield{
    if (_textfield == nil) {
        _textfield = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:SSKJLocalized(@"请输入股票名称或代码搜索", nil)];
        [WLTools textField:_textfield setPlaceHolder:SSKJLocalized(@"请输入股票名称或代码搜索", nil) color:kMainGrayColor];
        _textfield.font = systemFont(12);
        _textfield.textColor = kMainBlackColor;
        [self addSubview:_textfield];
        [_textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(15)));
            make.right.equalTo(self.searchBtn.mas_left);
            make.top.bottom.equalTo(@0);
        }];
    }
    return _textfield;
}

- (void)searchBtnAction{
    
    if (self.textfield.text.length == 0) {
        [MBProgressHUD showError:@"请输入股票名称或代码"];
        
        return;
    }
    
    if (self.SearchBtnBlock) {
        self.SearchBtnBlock(self.textfield.text);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
