//
//  GE_Mine_IntoPrice_Cell.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_IntoPrice_Cell.h"

@interface GE_Mine_IntoPrice_Cell()

@property (nonatomic,strong) UILabel * priceLabel;

@property (nonatomic,strong) UILabel * statusLabel;

@property (nonatomic,strong) UILabel * timeLabel;

@end

@implementation GE_Mine_IntoPrice_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = kMainWihteColor;
        
        [self priceLabel];
        
        [self statusLabel];
        
        [self timeLabel];
        
    }
    return self;
}

- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        
        _priceLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"1000/人民币" textColor:kMainBlackColor font:systemFont(ScaleW(14))];
        
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
        
        _statusLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"已通过" textColor:kMainBlackColor font:systemFont(ScaleW(14))];
        
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
        
        _timeLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"02-02 12:00:00" textColor:kMainBlackColor font:systemFont(ScaleW(14))];
        
        [self addSubview:_timeLabel];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(@0);
            
            make.right.equalTo(@(ScaleW(-15)));
            
            make.width.equalTo(@(ScaleW(100)));
            
        }];
        _timeLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _timeLabel;
}

- (void)initModel:(NSDictionary *)model type:(NSInteger)type
{
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f/人民币",[model[@"price"] doubleValue]];
    
    if (type == 1) {
        //入金
        switch ([model[@"state"] intValue]) {
            case 1:
            {
                self.statusLabel.text = @"未支付";
            }
                break;
            case 2:
            {
                self.statusLabel.text = @"已支付";
            }
                break;
                
            default:
                break;
        }
    }
    else if (type == 2)
    {
        //出金
        switch ([model[@"state"] intValue]) {
            case 1:
            {
                self.statusLabel.text = @"待审核";
            }
                break;
            case 2:
            {
                self.statusLabel.text = @"到账中";
            }
                break;
            case 3:
            {
                self.statusLabel.text = @"已拒绝";
            }
                break;
            case 4:
            {
                self.statusLabel.text = @"已到账";
            }
                break;
                
            default:
                break;
        }
    }
    
    self.timeLabel.text = [WLTools convertTimestamp:[model[@"addtime"] doubleValue] andFormat:@"YYYY-MM-dd HH:mm:ss"];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
