//
//  Market_Chart_Detail_Order_List_Cell.m
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Chart_Detail_Order_List_Cell.h"

@interface Market_Chart_Detail_Order_List_Cell()

@property(nonatomic,assign)CGFloat spaceWidth;

@end


@implementation Market_Chart_Detail_Order_List_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor=[WLTools stringToColor:@"#151824"];
        
        self.spaceWidth=ScreenWidth/3;
        
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
        
        _timeLabel.textColor=[WLTools stringToColor:@"#dae0f3"];
        
        _timeLabel.textAlignment=NSTextAlignmentCenter;
        
        [self.contentView addSubview:_timeLabel];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@0);
            
            make.centerY.equalTo(self.contentView.mas_centerY);
            
            make.width.equalTo(@(self.spaceWidth));
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
        
        _arrowLabel.textColor=RED_HEX_COLOR;
        
        _arrowLabel.textAlignment=NSTextAlignmentCenter;
        
        [self.contentView addSubview:_arrowLabel];
        
        [_arrowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.timeLabel.mas_right);
            
            make.centerY.equalTo(self.contentView.mas_centerY);
            
            make.width.equalTo(@(self.spaceWidth));
        }];
    }
    _arrowLabel.hidden = YES;
    return _arrowLabel;
}


#pragma mark - 价格
-(UILabel *)priceLabel
{
    if (_priceLabel==nil)
    {
        _priceLabel=[[UILabel alloc] init];
        
        _priceLabel.font=WLFontSize(14.0);
        
        _priceLabel.textColor=[WLTools stringToColor:@"#dae0f3"];
        
        _priceLabel.textAlignment=NSTextAlignmentCenter;
        
        [self.contentView addSubview:_priceLabel];
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.timeLabel.mas_right);
            
            make.centerY.equalTo(self.contentView.mas_centerY);
            
            make.width.equalTo(@(self.spaceWidth));
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
        
        _numberLabel.textColor=[WLTools stringToColor:@"#dae0f3"];
        
        _numberLabel.textAlignment=NSTextAlignmentCenter;
        
        [self.contentView addSubview:_numberLabel];
        
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.priceLabel.mas_right);
            
            make.centerY.equalTo(self.contentView.mas_centerY);
            
            make.width.equalTo(@(self.spaceWidth));
        }];
    }
    
    return _numberLabel;
}

-(void)initWithCellModel:(Market_Chart_Detail_Deal_Model *)model
{
    //时间
    NSArray *array = [model.datetime componentsSeparatedByString:@" "];
    
    self.timeLabel.text=[WLTools convertTimestamp:model.dt.doubleValue andFormat:@"HH:mm:ss"];;

      self.arrowLabel.hidden = YES;
    
    //方向
    if (model.tradeType.integerValue == 1)
    {
        self.arrowLabel.text=SSKJLocalized(@"买入", nil);
        
        self.arrowLabel.textColor=GREEN_HEX_COLOR;
        
        //价格
        self.priceLabel.text=model.open;
    }
    else
    {
        self.arrowLabel.text=SSKJLocalized(@"卖出", nil);
        
        self.arrowLabel.textColor=RED_HEX_COLOR;
      
        //价格
        //self.priceLabel.text=[WLTools notRounding:[model.sellPrice floatValue] afterPoint:4];
        self.priceLabel.text=model.open;
    }
    
    self.priceLabel.text = model.price;

    //数量
    self.numberLabel.text=model.amount;
}

- (NSString *)dateTimeFormat:(NSString *)dateString
{
    NSRange range = [dateString rangeOfString:@" "];
    dateString = [dateString substringFromIndex:range.location];
    return dateString;
    
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateString.longLongValue];
//    NSDateFormatter *f = [[NSDateFormatter alloc]init];
//    [f setDateFormat:@"HH:mm:ss"];
//    return [f stringFromDate:date];
    
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
