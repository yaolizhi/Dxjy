//
//  Market_Chart_Detail_Order_ListTop_Cell.m
//  ZYW_MIT
//
//  Created by James on 2018/7/28.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Chart_Detail_Order_ListTop_Cell.h"

@implementation Market_Chart_Detail_Order_ListTop_Cell
#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor=[WLTools stringToColor:@"#151824"];
        
        [self createUI];
    }
    
    return self;
}

#pragma mark - 创建UI
-(void)createUI
{
    //时间
    [self timeLabel];
    
    //方向
    [self arrowLabel];
    
    //价格
    [self priceLabel];
    
    //数量
    [self numberLabel];
}

#pragma mark - 时间
-(UILabel *)timeLabel
{
    if (_timeLabel==nil)
    {
        _timeLabel=[[UILabel alloc] init];
        
        _timeLabel.font=WLFontSize(14.0);
        
        _timeLabel.textColor=[WLTools stringToColor:@"#79899e"];
        
        _timeLabel.text=SSKJLocalized(@"时间", nil);
        
        _timeLabel.textAlignment=NSTextAlignmentCenter;
        
        [self.contentView addSubview:_timeLabel];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@(ScreenWidth/3));
            
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    
    return _timeLabel;
}


#pragma mark - 方向
-(UILabel *)arrowLabel
{
    if (_arrowLabel==nil)
    {
        _arrowLabel=[[UILabel alloc] init];
        
        _arrowLabel.font=WLFontSize(14.0);
        
        _arrowLabel.textColor=[WLTools stringToColor:@"#79899e"];
        
        _arrowLabel.text=SSKJLocalized(@"方向", nil);
        
        _arrowLabel.textAlignment=NSTextAlignmentCenter;
        
        [self.contentView addSubview:_arrowLabel];
        
        [_arrowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.timeLabel.mas_right);
            
            make.width.equalTo(@(ScreenWidth/4));
            
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        _arrowLabel.hidden = YES;
    }
    
    return _arrowLabel;
}

#pragma mark - 价格
-(UILabel *)priceLabel
{
    if (_priceLabel==nil)
    {
        _priceLabel=[[UILabel alloc] init];
        
        _priceLabel.font=WLFontSize(14.0);
        
        _priceLabel.textColor=[WLTools stringToColor:@"#79899e"];
        
        _priceLabel.text=SSKJLocalized(@"价格", nil);
        
        _priceLabel.textAlignment=NSTextAlignmentCenter;
        
        [self.contentView addSubview:_priceLabel];
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.timeLabel.mas_right);
            
            make.width.equalTo(@(ScreenWidth/3));
            
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    
    return _priceLabel;
}

#pragma mark - 数量
-(UILabel *)numberLabel
{
    if (_numberLabel==nil)
    {
        _numberLabel=[[UILabel alloc] init];
        
        _numberLabel.font=WLFontSize(14.0);
        
        _numberLabel.textColor=[WLTools stringToColor:@"#79899e"];
        
        _numberLabel.text=SSKJLocalized(@"数量", nil);
        
        _numberLabel.textAlignment=NSTextAlignmentCenter;
        
        [self.contentView addSubview:_numberLabel];
        
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.priceLabel.mas_right);
            
            make.width.equalTo(@(ScreenWidth/4));
            
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    
    return _numberLabel;
}

-(void)initWithSection:(NSString *)code
{
    if ([WLTools judgeString:code])
    {
        NSArray *array=[code componentsSeparatedByString:@"_"];
        
        if (array.count>1)
        {
            self.priceLabel.text=[NSString stringWithFormat:SSKJLocalized(@"价格(%@)", nil),array[1]];
            
            self.numberLabel.text=[NSString stringWithFormat:SSKJLocalized(@"数量(%@)", nil),array[0]];
        }
        
    }
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
