//
//  Market_Chart_Detail_Intro_List_Cell.m
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Chart_Detail_Intro_List_Cell.h"

@implementation Market_Chart_Detail_Intro_List_Cell
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
    
    [self valueLabel];
    
    [self lineView];
}

#pragma mark - 标题
-(UILabel *)titleLabel
{
    if (_titleLabel==nil)
    {
        _titleLabel=[[UILabel alloc] init];
        
        _titleLabel.font=WLFontSize(14.0);
        
        _titleLabel.textColor=UIColorFromRGB(0xbbbbbb);
        
        [self.contentView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@15);
            
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    
    return _titleLabel;
}

#pragma mark - 值 标签
-(UILabel *)valueLabel
{
    if (_valueLabel==nil)
    {
        _valueLabel=[[UILabel alloc] init];
        
        _valueLabel.font=WLFontSize(14.0);
        
        _valueLabel.textColor=UIColorFromRGB(0xffffff);
        
        _valueLabel.text=@"--";
        
        [self.contentView addSubview:_valueLabel];
        
        [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.titleLabel.mas_right).offset(15);
            
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    
    return _valueLabel;
}

#pragma mark - 分割线
-(UIView *)lineView
{
    if (_lineView==nil)
    {
        _lineView=[[UIView alloc] init];
        
        _lineView.backgroundColor=[WLTools stringToColor:@"#071827"];
        
        [self.contentView addSubview:_lineView];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.titleLabel.mas_left);
            
            make.bottom.equalTo(self.contentView.mas_bottom);
            
            make.height.equalTo(@1.0);
            
            make.right.equalTo(self.contentView.mas_right);
        }];
    }

    return _lineView;
}

-(void)initWithCellModel:(Market_Main_List_Model *)model andTitle:(NSString *)title andIndexPath:(NSIndexPath *)indexPath
{

    self.titleLabel.font=WLFontSize(14.0);
    
    self.titleLabel.textColor=UIColorFromRGB(0xbbbbbb);
    
    if (indexPath.row==0)
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
    
        
        self.titleLabel.textColor=[UIColor whiteColor];
        
        self.titleLabel.font=[UIFont boldSystemFontOfSize:33.0];
        
        self.valueLabel.text=@"";
        
    }
    else if(indexPath.row==1) //发行时间
    {
        self.titleLabel.text=title;
        
        self.valueLabel.text=model.publishTime;
    }
    else if(indexPath.row==2) //发行总量
    {
        self.titleLabel.text=title;
        
        self.valueLabel.text=model.publishNum;
    }
//    else if(indexPath.row==3) //流通总量
//    {
//        self.titleLabel.text=title;
//
//        self.valueLabel.text=model.publishNum;
//    }
//    else if(indexPath.row==4) //众筹价格
//    {
//        self.titleLabel.text=title;
//
//        self.valueLabel.text=model.publishPrice;
//    }
    else if(indexPath.row==3) //白皮书
    {
        self.titleLabel.text=SSKJLocalized(@"白皮书", nil);
        
        self.valueLabel.text=model.whitePaper;
    }
    else if(indexPath.row==4) //官网
    {
        self.titleLabel.text=SSKJLocalized(@"官网", nil);
        
        
        self.valueLabel.text=model.publishWeb;
        
        
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
