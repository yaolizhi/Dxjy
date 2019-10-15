//
//  KLine_TimeView.m
//  BTC-Kline
//
//  Created by 刘小雨 on 2018/7/19.
//  Copyright © 2018年 yate1996. All rights reserved.
//

#import "KLine_TimeView.h"
#import "Masonry.h"
#import "Y_KLineModel.h"
@interface KLine_TimeView()
@property (nonatomic, strong) UILabel *startTimeLabel;      // 起始时间
@property (nonatomic, strong) UILabel *endTimeLabel;        // 终止时间
@property (nonatomic, strong) UILabel *crossTimeLabel;      // 十字线时间

@end

@implementation KLine_TimeView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.startTimeLabel];
        [self addSubview:self.endTimeLabel];
        [self addSubview:self.crossTimeLabel];
    }
    return self;
}

-(UILabel *)startTimeLabel
{
    if (nil == _startTimeLabel) {
        _startTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 10)];
        _startTimeLabel.textAlignment = NSTextAlignmentLeft;
        _startTimeLabel.font = [UIFont systemFontOfSize:10];
        _startTimeLabel.textColor = [UIColor whiteColor];
        _startTimeLabel.text = @"00:00";
        [self addSubview:_startTimeLabel];
        [_startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.width.equalTo(@100);
            make.height.equalTo(@10);
        }];
    }
    return _startTimeLabel;
}

-(UILabel *)endTimeLabel
{
    if (nil == _endTimeLabel) {
        _endTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width - 100, 0, 100, 10)];
        _endTimeLabel.textAlignment = NSTextAlignmentRight;
        _endTimeLabel.font = [UIFont systemFontOfSize:10];
        _endTimeLabel.textColor = [UIColor whiteColor];
        _endTimeLabel.text = @"00:00";

        [self addSubview:_endTimeLabel];
        [_endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(self);
            make.width.equalTo(@100);
            make.height.equalTo(@10);
        }];
    }
    return _endTimeLabel;
}
-(UILabel *)crossTimeLabel
{
    if (nil == _crossTimeLabel) {
        _crossTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width - 100, 0, 100, 10)];
        _crossTimeLabel.textAlignment = NSTextAlignmentCenter;
        _crossTimeLabel.font = [UIFont systemFontOfSize:10];
        _crossTimeLabel.textColor = [UIColor whiteColor];
        _crossTimeLabel.hidden = YES;
        _crossTimeLabel.text = @"00:00";

        [self addSubview:_crossTimeLabel];
        [_crossTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.width.equalTo(@100);
            make.height.equalTo(@10);
        }];
    }
    return _crossTimeLabel;
}

-(void)setViewWithArray:(NSArray *)kLineModels
{
    if (kLineModels.count > 0) {
        Y_KLineModel *model = kLineModels.firstObject;
        self.startTimeLabel.text = [NSString stringWithFormat:@"%@",model.Date];
        model = kLineModels.lastObject;
        self.endTimeLabel.text = [NSString stringWithFormat:@"%@",model.Date];
    }
}
-(void)setCrossTimeWithPositionX:(CGFloat)positionX model:(Y_KLineModel *)model
{
    self.crossTimeLabel.hidden = NO;
    CGPoint center = self.crossTimeLabel.center;
    center.x = positionX;
    self.crossTimeLabel.center = center;
    self.crossTimeLabel.text = [NSString stringWithFormat:@"%@",model.Date];
}

-(void)hiddenCrossLabel
{
    self.crossTimeLabel.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
