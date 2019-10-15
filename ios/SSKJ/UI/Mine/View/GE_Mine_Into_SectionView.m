//
//  GE_Mine_Into_SectionView.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_Into_SectionView.h"

@interface GE_Mine_Into_SectionView()

@property (nonatomic,strong) UILabel * priceLabel;

@property (nonatomic,strong) UILabel * statusLabel;

@property (nonatomic,strong) UILabel * timeLabel;


@end

@implementation GE_Mine_Into_SectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self priceLabel];
        
        [self statusLabel];
        
        [self timeLabel];
        
    }
    return self;
}

- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        
        _priceLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"金额/币种" textColor:kMainGrayColor font:systemFont(ScaleW(15))];
        
        [self addSubview:_priceLabel];
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(@0);
            
            make.left.equalTo(@(ScaleW(15)));
            
        }];
    }
    return _priceLabel;
}

- (UILabel *)statusLabel
{
    if (_statusLabel == nil) {
        
        _statusLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"审核状态" textColor:kMainGrayColor font:systemFont(ScaleW(15))];
        
        [self addSubview:_statusLabel];
        
        [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(@0);
            
            make.centerX.equalTo(self.mas_centerX);
            
        }];
    }
    return _statusLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        
        _timeLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"操作时间" textColor:kMainGrayColor font:systemFont(ScaleW(15))];
        
        [self addSubview:_timeLabel];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(@0);
            
            make.right.equalTo(@(ScaleW(-15)));
            
        }];
    }
    return _timeLabel;
}


@end
