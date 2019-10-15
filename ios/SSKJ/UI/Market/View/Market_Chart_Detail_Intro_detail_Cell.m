//
//  Market_Chart_Detail_Intro_detail_Cell.m
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Chart_Detail_Intro_detail_Cell.h"

@implementation Market_Chart_Detail_Intro_detail_Cell

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
    [self titleLabel];
    
    [self contentLabel];
}

#pragma mark - 标题
-(UILabel *)titleLabel
{
    if (_titleLabel==nil)
    {
        _titleLabel.hidden = YES;
        _titleLabel=[[UILabel alloc] init];
        
        _titleLabel.font=WLFontSize(16.0);
        
        _titleLabel.textColor=UIColorFromRGB(0xbbbbbb);
        
        [self.contentView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@5);
            
            make.centerX.equalTo(self.contentView.mas_centerX);
            
            make.height.equalTo(@20);
            
        }];
    }
    
    return _titleLabel;
}

#pragma mark - 简介详情
-(UILabel *)contentLabel
{
    if (_contentLabel==nil)
    {
        _contentLabel=[[UILabel alloc] init];
    
        _contentLabel.textColor=UIColorFromRGB(0xffffff);
        
        _contentLabel.font=WLFontSize(14.0);
        
        _contentLabel.numberOfLines=0;
        
        _contentLabel.backgroundColor=[UIColor clearColor];
        
        [self.contentView addSubview:_contentLabel];
        
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left).offset(15);
            
            make.top.equalTo(self.titleLabel.mas_bottom).offset(-10);
            
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];
    }
    
    return _contentLabel;
}

-(void)initWitCellModel:(Market_Main_List_Model *)model
{
    NSArray *array=[model.name componentsSeparatedByString:@"/"];
    
    if (array.count>0)
    {
        self.titleLabel.text=array[0];
    }
    else
    {
        self.titleLabel.text=model.name;
    }
    self.titleLabel.hidden = YES;
    
    self.contentLabel.text=model.remark;
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
