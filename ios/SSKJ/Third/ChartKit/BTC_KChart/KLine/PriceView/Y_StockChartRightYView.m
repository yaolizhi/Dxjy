//
//  Y_StockChartRightYView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/3.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_StockChartRightYView.h"
#import "UIColor+Y_StockChart.h"
#import "Masonry.h"
#import "UIColor+Hex.h"
#import "NSString+Conversion.h"

@interface Y_StockChartRightYView ()
{
    NSInteger _count;
}

@property(nonatomic,strong) UILabel *maxValueLabel;

@property(nonatomic,strong) UILabel *middleValueLabel;

@property(nonatomic,strong) UILabel *minValueLabel;

@property(nonatomic,strong) UILabel *crossValueLabel;       // 十字线price

@property(nonatomic,strong) UILabel *currentValueLabel;       // 当前price


@end


@implementation Y_StockChartRightYView

-(void)setMaxValue:(CGFloat)maxValue
{
    _maxValue = maxValue;
    NSString *value = [NSString stringWithFormat:@"%.4f",maxValue];
    self.maxValueLabel.text = [NSString numConversionWithStr:value];
}

-(void)setMiddleValue:(CGFloat)middleValue
{
    _middleValue = middleValue;
    NSString *value = [NSString stringWithFormat:@"%.4f",middleValue];

    self.middleValueLabel.text = [NSString numConversionWithStr:value];
}

-(void)setMinValue:(CGFloat)minValue
{
    _minValue = minValue;
    NSString *value = [NSString stringWithFormat:@"%.4f",minValue];
    self.minValueLabel.text = [NSString numConversionWithStr:value];
}

-(void)setMinLabelText:(NSString *)minLabelText
{
    _minLabelText = minLabelText;
    self.minValueLabel.text = minLabelText;
}

#pragma mark - get方法
#pragma mark maxPriceLabel的get方法
-(UILabel *)maxValueLabel
{
    if (!_maxValueLabel) {
        _maxValueLabel = [self private_createLabel];
        [self addSubview:_maxValueLabel];
        [_maxValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.width.equalTo(self);
            make.height.equalTo(@10);
        }];
    }
    return _maxValueLabel;
}

#pragma mark middlePriceLabel的get方法
-(UILabel *)middleValueLabel
{
    if (!_middleValueLabel) {
        _middleValueLabel = [self private_createLabel];
        [self addSubview:_middleValueLabel];
        [_middleValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.right.equalTo(self);
            make.height.width.equalTo(self.maxValueLabel);
        }];
    }
    return _middleValueLabel;
}

#pragma mark minPriceLabel的get方法
-(UILabel *)minValueLabel
{
    if (!_minValueLabel) {
        _minValueLabel = [self private_createLabel];
        [self addSubview:_minValueLabel];
        [_minValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(self);
            make.height.width.equalTo(self.maxValueLabel);
        }];
    }
    return _minValueLabel;
}


#pragma mark 十字线PriceLabel的get方法
-(UILabel *)crossValueLabel
{
    if (!_crossValueLabel) {
        _crossValueLabel = [self private_createLabel];
        [self addSubview:_crossValueLabel];
        _crossValueLabel.hidden = YES;
        [_crossValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.height.width.equalTo(self.maxValueLabel);
            make.top.equalTo(self);
        }];
    }
    return _crossValueLabel;
}

#pragma mark 当前价PriceLabel的get方法
-(UILabel *)currentValueLabel
{
    if (!_currentValueLabel) {
        _currentValueLabel =  [UILabel new];
        _currentValueLabel.font = [UIFont systemFontOfSize:10];
        _currentValueLabel.textAlignment = NSTextAlignmentLeft;
        _currentValueLabel.adjustsFontSizeToFitWidth = YES;
        _currentValueLabel.textColor = [UIColor whiteColor];
        _currentValueLabel.backgroundColor = UIColorFromRGB(0x131f30);
        [self addSubview:_currentValueLabel];
        _currentValueLabel.hidden = YES;
        [_currentValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.width.equalTo(self.maxValueLabel);
            make.top.equalTo(self);
            make.height.equalTo(@(10));
        }];
    }
    return _currentValueLabel;
}

-(void)setCrossPrice:(NSString *)price positionY:(CGFloat)positionY
{
    self.crossValueLabel.hidden = NO;
    self.crossValueLabel.text = [NSString stringWithFormat:@"%.4f",price.doubleValue];
    [self.crossValueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.height.width.equalTo(self.maxValueLabel);
        make.top.equalTo(@(positionY - self.y));
    }];
    
}
-(void)hiddenCrossPrice
{
    self.crossValueLabel.hidden = YES;
}

-(void)setCurrentPrice:(NSString *)price positionY:(CGFloat)positionY
{
    self.currentValueLabel.hidden = NO;
    self.currentValueLabel.text = [NSString stringWithFormat:@"%.4f",price.doubleValue];
    if (_count == 0) {
        [self.currentValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.height.width.equalTo(self.maxValueLabel);
            make.top.equalTo(@(0));
        }];
    }else{
        
        [self.currentValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.height.width.equalTo(self.maxValueLabel);
            make.top.equalTo(@(positionY - self.y - 11));
        }];
        
        [self.superview layoutIfNeeded];
    }
    
    _count ++;
//    [self.currentValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self);
//        make.height.width.equalTo(self.maxValueLabel);
//        make.top.equalTo(@(positionY - self.y - 5));
//    }];

}

-(void)hiddenCurrentPrice
{
    self.currentValueLabel.hidden = YES;
}

#pragma mark - 私有方法
#pragma mark 创建Label
- (UILabel *)private_createLabel
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = [UIColor assistTextColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.adjustsFontSizeToFitWidth = YES;
    [self addSubview:label];
    return label;
}
@end
