//
//  TipView.m
//  BTC-Kline
//
//  Created by 刘小雨 on 2018/7/19.
//  Copyright © 2018年 yate1996. All rights reserved.
//

#import "TipView.h"
#import "Masonry.h"
#import "UIColor+Hex.h"
#import "UIColor+Y_StockChart.h"
#define kMiddle_Gap  2

@interface TipView()
//@property (nonatomic, strong) Y_KLineModel *model;

@property (nonatomic, strong) UILabel *timeTitleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *highTitleLabel;
@property (nonatomic, strong) UILabel *highLabel;

@property (nonatomic, strong) UILabel *lowTitleLabel;
@property (nonatomic, strong) UILabel *lowLabel;

@property (nonatomic, strong) UILabel *openTitleLabel;
@property (nonatomic, strong) UILabel *openLabel;

@property (nonatomic, strong) UILabel *closeTitleLabel;
@property (nonatomic, strong) UILabel *closeLabel;

@property (nonatomic, strong) UILabel *volumeTitleLabel;
@property (nonatomic, strong) UILabel *volumeLabel;



@property (nonatomic, strong) UILabel *priceTitleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *changeTitleLabel;
@property (nonatomic, strong) UILabel *changeLabel;

@property (nonatomic, strong) UILabel *changeRateTitleLabel;
@property (nonatomic, strong) UILabel *changeRateLabel;

@end

@implementation TipView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.timeTitleLabel];
        [self addSubview:self.timeLabel];
        
        [self addSubview:self.openTitleLabel];
        [self addSubview:self.openLabel];
        
        [self addSubview:self.highTitleLabel];
        [self addSubview:self.highLabel];
        
        [self addSubview:self.lowTitleLabel];
        [self addSubview:self.lowLabel];
        
        [self addSubview:self.closeTitleLabel];
        [self addSubview:self.closeLabel];
        
        
        [self addSubview:self.volumeTitleLabel];
        [self addSubview:self.volumeLabel];
        
        
        [self addSubview:self.priceTitleLabel];
        [self addSubview:self.priceLabel];
        
        [self addSubview:self.changeTitleLabel];
        [self addSubview:self.changeLabel];
        
        [self addSubview:self.changeRateTitleLabel];
        [self addSubview:self.changeRateLabel];
        
        self.backgroundColor = UIColorFromRGB(0x131f30);
        self.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
        self.layer.borderWidth = 0.5;

    }
    return self;
}

-(UILabel *)timeTitleLabel
{
    if (nil == _timeTitleLabel) {
        _timeTitleLabel = [self createLabel];
        _timeTitleLabel.text = SSKJLocalized(@"时间：", nil);
        [self addSubview:_timeTitleLabel];
        [_timeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@2);
            make.width.equalTo(@(45));
            make.top.equalTo(@(kMiddle_Gap));
            make.height.equalTo(@10);
        }];
    }
    return _timeTitleLabel;
}

-(UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [self createLabel];
        _timeLabel.text = @"00:00";
        _timeLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeTitleLabel.mas_right);
            make.right.equalTo(@0);
            make.top.equalTo(self.timeTitleLabel);
            make.height.equalTo(@10);
        }];
    }
    return _timeLabel;
}


-(UILabel *)openTitleLabel
{
    if (nil == _openTitleLabel) {
        _openTitleLabel = [self createLabel];
        _openTitleLabel.text = SSKJLocalized(@"开盘：", nil);
        [self addSubview:_openTitleLabel];
        [_openTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeTitleLabel);
            make.width.equalTo(self.timeTitleLabel);
            make.top.equalTo(self.timeTitleLabel.mas_bottom).offset(kMiddle_Gap);
            make.height.equalTo(self.timeTitleLabel);
        }];
    }
    return _openTitleLabel;
}

-(UILabel *)openLabel
{
    if (nil == _openLabel) {
        _openLabel = [self createLabel];
        _openLabel.adjustsFontSizeToFitWidth = YES;

        _openLabel.text = @"00:00";
        [self addSubview:_openLabel];
        [_openLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.openTitleLabel.mas_right);
            make.right.equalTo(self.timeLabel);
            make.top.equalTo(self.openTitleLabel);
            make.height.equalTo(self.timeLabel);
        }];
    }
    return _openLabel;
}

-(UILabel *)highTitleLabel
{
    if (nil == _highTitleLabel) {
        _highTitleLabel = [self createLabel];
        _highTitleLabel.text = SSKJLocalized(@"最高：", nil);
        [self addSubview:_highTitleLabel];
        [_highTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeTitleLabel);
            make.width.equalTo(self.timeTitleLabel);
            make.top.equalTo(self.openTitleLabel.mas_bottom).offset(kMiddle_Gap);
            make.height.equalTo(self.timeTitleLabel);
        }];
    }
    return _highTitleLabel;
}

-(UILabel *)highLabel
{
    if (nil == _highLabel) {
        _highLabel = [self createLabel];
        _highLabel.adjustsFontSizeToFitWidth = YES;

        _highLabel.text = @"00:00";
        [self addSubview:_highLabel];
        [_highLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.highTitleLabel.mas_right);
            make.right.equalTo(self.timeLabel);
            make.top.equalTo(self.highTitleLabel);
            make.height.equalTo(self.timeLabel);
        }];
    }
    return _highLabel;
}

-(UILabel *)lowTitleLabel
{
    if (nil == _lowTitleLabel) {
        _lowTitleLabel = [self createLabel];

        _lowTitleLabel.text = SSKJLocalized(@"最低：", nil);
        [self addSubview:_lowTitleLabel];
        [_lowTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeTitleLabel);
            make.width.equalTo(self.timeTitleLabel);
            make.top.equalTo(self.highTitleLabel.mas_bottom).offset(kMiddle_Gap);
            make.height.equalTo(self.timeTitleLabel);
        }];
    }
    return _lowTitleLabel;
}

-(UILabel *)lowLabel
{
    if (nil == _lowLabel) {
        _lowLabel = [self createLabel];
        _lowLabel.adjustsFontSizeToFitWidth = YES;

        _lowLabel.text = @"00:00";
        [self addSubview:_lowLabel];
        [_lowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.highTitleLabel.mas_right);
            make.right.equalTo(self.timeLabel);
            make.top.equalTo(self.lowTitleLabel);
            make.height.equalTo(self.timeLabel);
        }];
    }
    return _lowLabel;
}

-(UILabel *)closeTitleLabel
{
    if (nil == _closeTitleLabel) {
        _closeTitleLabel = [self createLabel];
        _closeTitleLabel.text = SSKJLocalized(@"收盘：", nil);
        [self addSubview:_closeTitleLabel];
        [_closeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeTitleLabel);
            make.width.equalTo(self.timeTitleLabel);
            make.top.equalTo(self.lowTitleLabel.mas_bottom).offset(kMiddle_Gap);
            make.height.equalTo(self.timeTitleLabel);
        }];
    }
    return _closeTitleLabel;
}

-(UILabel *)closeLabel
{
    if (nil == _closeLabel) {
        _closeLabel = [self createLabel];
        _closeLabel.adjustsFontSizeToFitWidth = YES;

        _closeLabel.text = @"00:00";
        [self addSubview:_closeLabel];
        [_closeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.highTitleLabel.mas_right);
            make.right.equalTo(self.timeLabel);
            make.top.equalTo(self.closeTitleLabel);
            make.height.equalTo(self.timeLabel);
        }];
    }
    return _closeLabel;
}

-(UILabel *)volumeTitleLabel
{
    if (nil == _volumeTitleLabel) {
        _volumeTitleLabel = [self createLabel];
        _volumeTitleLabel.text = SSKJLocalized(@"交易量：", nil);
        
        [self addSubview:_volumeTitleLabel];
        [_volumeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeTitleLabel);
            make.width.equalTo(self.timeTitleLabel);
            make.top.equalTo(self.closeTitleLabel.mas_bottom).offset(kMiddle_Gap);
            make.height.equalTo(self.timeTitleLabel);
        }];
    }
    return _volumeTitleLabel;
}

-(UILabel *)volumeLabel
{
    if (nil == _volumeLabel) {
        _volumeLabel = [self createLabel];
        _volumeLabel.adjustsFontSizeToFitWidth = YES;

        _volumeLabel.textColor = YELLOW_HEX_COLOR;
        _volumeLabel.text = @"00:00";
        [self addSubview:_volumeLabel];
        [_volumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.highTitleLabel.mas_right);
            make.right.equalTo(self.timeLabel);
            make.top.equalTo(self.volumeTitleLabel);
            make.height.equalTo(self.timeLabel);
        }];
    }
    return _volumeLabel;
}
-(UILabel *)priceTitleLabel
{
    if (nil == _priceTitleLabel) {
        _priceTitleLabel = [self createLabel];
        _priceTitleLabel.text = SSKJLocalized(@"价格：", nil);
        [self addSubview:_priceTitleLabel];
        [_priceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeTitleLabel);
            make.width.equalTo(self.timeTitleLabel);
            make.top.equalTo(self.timeTitleLabel.mas_bottom).offset(kMiddle_Gap);
            make.height.equalTo(self.timeTitleLabel);
        }];
    }
    return _priceTitleLabel;
}

-(UILabel *)priceLabel
{
    if (nil == _priceLabel) {
        _priceLabel = [self createLabel];
        _priceLabel.adjustsFontSizeToFitWidth = YES;

        _priceLabel.text = @"00:00";
        [self addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.highTitleLabel.mas_right);
            make.right.equalTo(self.timeLabel);
            make.top.equalTo(self.priceTitleLabel);
            make.height.equalTo(self.timeLabel);
        }];
    }
    return _priceLabel;
}

-(UILabel *)changeTitleLabel
{
    if (nil == _changeTitleLabel) {
        _changeTitleLabel = [self createLabel];
        _changeTitleLabel.text = SSKJLocalized(@"涨跌：", nil);
        [self addSubview:_changeTitleLabel];
        [_changeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeTitleLabel);
            make.width.equalTo(self.timeTitleLabel);
            make.top.equalTo(self.priceTitleLabel.mas_bottom).offset(kMiddle_Gap);
            make.height.equalTo(self.timeTitleLabel);
        }];
    }
    return _changeTitleLabel;
}

-(UILabel *)changeLabel
{
    if (nil == _changeLabel) {
        _changeLabel = [self createLabel];
        _changeLabel.adjustsFontSizeToFitWidth = YES;

        _changeLabel.text = @"00:00";
        [self addSubview:_changeLabel];
        [_changeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.highTitleLabel.mas_right);
            make.right.equalTo(self.timeLabel);
            make.top.equalTo(self.changeTitleLabel);
            make.height.equalTo(self.timeLabel);
        }];
    }
    return _changeLabel;
}
-(UILabel *)changeRateTitleLabel
{
    if (nil == _changeRateTitleLabel) {
        _changeRateTitleLabel = [self createLabel];
        _changeRateTitleLabel.text = SSKJLocalized(@"涨幅：", nil);
        [self addSubview:_changeRateTitleLabel];
        [_changeRateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeTitleLabel);
            make.width.equalTo(self.timeTitleLabel);
            make.top.equalTo(self.changeTitleLabel.mas_bottom).offset(kMiddle_Gap);
            make.height.equalTo(self.timeTitleLabel);
        }];
    }
    return _changeRateTitleLabel;
}

-(UILabel *)changeRateLabel
{
    if (nil == _changeRateLabel) {
        _changeRateLabel = [self createLabel];
        _changeRateLabel.adjustsFontSizeToFitWidth = YES;

        _changeRateLabel.text = @"00:00";
        [self addSubview:_changeRateLabel];
        [_changeRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.highTitleLabel.mas_right);
            make.right.equalTo(self.timeLabel);
            make.top.equalTo(self.changeRateTitleLabel);
            make.height.equalTo(self.timeLabel);
        }];
    }
    return _changeRateLabel;
}


-(UILabel *)createLabel
{
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = [UIColor colorWithHexString:@"#cccccc"];
    return label;
}

#pragma mark - UI

-(void)setViewWithModel:(Y_KLineModel *)model lineType:(Y_StockChartCenterViewType)lineType
{
//    _model = model;
    if (lineType == Y_StockChartcenterViewTypeKline) {      // k线
        self.timeTitleLabel.hidden = NO;;
        self.priceTitleLabel.hidden = YES;
        self.priceLabel.hidden = YES;
        self.changeTitleLabel.hidden = YES;
        self.changeLabel.hidden = YES;
        self.changeRateTitleLabel.hidden = YES;
        self.changeRateLabel.hidden = YES;
        self.timeLabel.text = [NSString stringWithFormat:@"%@",model.Date];
        self.openLabel.text = [NSString stringWithFormat:@"%.4f",[model.Open doubleValue]];
        self.highLabel.text = [NSString stringWithFormat:@"%.4f",[model.High doubleValue]];
        self.highLabel.textColor = [self colorWithPrice:model.High openPrice:model.Open];
        self.lowLabel.text = [NSString stringWithFormat:@"%.4f",[model.Low doubleValue]];
        self.lowLabel.textColor = [self colorWithPrice:model.Low openPrice:model.Open];
        self.closeLabel.text = [NSString stringWithFormat:@"%.4f",[model.Close doubleValue]];
        self.closeLabel.textColor = [self colorWithPrice:model.Close openPrice:model.Open];
        self.volumeLabel.text = [self volumeWithVolume:model.Volume];
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeTitleLabel.mas_right);
        }];
        
    }else{
        self.timeTitleLabel.hidden = YES;
        self.openTitleLabel.hidden = YES;
        self.openTitleLabel.hidden = YES;
        self.closeTitleLabel.hidden = YES;
        self.closeLabel.hidden = YES;
        self.highTitleLabel.hidden = YES;
        self.highLabel.hidden = YES;
        self.lowTitleLabel.hidden = YES;
        self.lowLabel.hidden = YES;
        
        self.timeLabel.text = [NSString stringWithFormat:@"%@",model.Date];
        self.priceLabel.text = [model.Close stringValue];
        
        self.changeLabel.text = [model.High stringValue];
        self.highLabel.textColor = [self colorWithPrice:model.High openPrice:model.Open];
        self.lowLabel.text = [model.Low stringValue];
        self.lowLabel.textColor = [self colorWithPrice:model.Low openPrice:model.Open];
        self.closeLabel.text = [model.Close stringValue];
        self.closeLabel.textColor = [self colorWithPrice:model.Close openPrice:model.Open];
        self.volumeLabel.text = [NSString stringWithFormat:@"%.2f",model.Volume];
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeTitleLabel.mas_right);
        }];
        
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
        }];
        [self.volumeTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.top.equalTo(self.changeRateTitleLabel.mas_bottom).offset(kMiddle_Gap);
        }];
    }
    
    
    NSString *text = self.openLabel.text.length > self.closeLabel.text.length ? self.openLabel.text : self.closeLabel.text;
    CGSize size = [text boundingRectWithSize:CGSizeMake(1000, self.openLabel.height) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.openLabel.font} context:nil].size;
//    self.width = size.width + 52;
    
}

-(UIColor *)colorWithPrice:(NSNumber *)price openPrice:(NSNumber *)openPrice
{
    if ([price doubleValue] > [openPrice doubleValue]) {
        return [UIColor decreaseColor];
    }else if ([price doubleValue] < [openPrice doubleValue]){
        return [UIColor increaseColor];
    }else{
        return [UIColor colorWithHexString:@"#cccccc"];
    }
}


-(NSString *)volumeWithVolume:(double)volume
{
    if (volume < 1000) {
        return [NSString stringWithFormat:@"%.4f",volume];
    }else if (volume < 10000){
        return [NSString stringWithFormat:@"%.0f",volume];
    }else if(volume < 1000000){
        return [NSString stringWithFormat:SSKJLocalized(@"%.2f万", nil),volume / 10000.f];
    }else if(volume < 10000000){
        return [NSString stringWithFormat:SSKJLocalized(@"%.1f万", nil),volume / 10000.f];
    }else if(volume < 100000000){
        return [NSString stringWithFormat:SSKJLocalized(@"%.0f万", nil),volume / 10000.f];
    }else if(volume < 10000000000){
        return [NSString stringWithFormat:SSKJLocalized(@"%.2f亿", nil),volume / 100000000.f];
    }else if(volume < 100000000000){
        return [NSString stringWithFormat:SSKJLocalized(@"%.1f亿", nil),volume / 100000000.f];
    }else if(volume < 1000000000000){
        return [NSString stringWithFormat:SSKJLocalized(@"%.0f亿", nil),volume / 100000000.f];
    }else{
        return [NSString stringWithFormat:SSKJLocalized(@"%.0f亿", nil),volume / 100000000.f];
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
