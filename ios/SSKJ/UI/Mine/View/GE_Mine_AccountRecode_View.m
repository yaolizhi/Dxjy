//
//  GE_Mine_AccountRecode_View.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_AccountRecode_View.h"

@interface GE_Mine_AccountRecode_View()

@property (nonatomic,strong) UIView * bgView;


@end

@implementation GE_Mine_AccountRecode_View


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self bgView];
        
        [self titleLabel];
        
        [self detailLabel];
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
            
            make.width.equalTo(@(ScaleW(100)));
            
            make.height.equalTo(@(ScaleH(15)));
        }];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (_detailLabel == nil) {
        
        _detailLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"0.00" textColor:kMainDarkBlackColor font:systemFont(ScaleW(13))];
        
        [self.bgView addSubview:_detailLabel];
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.right.equalTo(@0);
            
            make.left.equalTo(self.titleLabel.mas_right).offset(ScaleW(15));
        }];
    }
    return _detailLabel;
}

@end
