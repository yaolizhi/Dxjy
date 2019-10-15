//
//  GE_Trading_headerView.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Trading_headerView.h"

@interface GE_Trading_headerView()

@property (nonatomic,strong) UILabel * dtqyTitle;

@property (nonatomic,strong) UILabel * dtqyLabel;

@property (nonatomic,strong) UILabel * qjTitle;

@property (nonatomic,strong) UILabel * qjLabel;

@property (nonatomic,strong) UILabel * baocangTitle;

@property (nonatomic,strong) UILabel * baocangLabel;

@property (nonatomic,strong) UIImageView * baocangImg;

@property (nonatomic,strong) GE_Mine_AccountRecord_Model *model;


@end

@implementation GE_Trading_headerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = kMainWihteColor;
        
        [self dtqyLabel];
        
        [self dtqyTitle];
        
        [self qjLabel];
        
        [self qjTitle];
        
        [self baocangLabel];
        
        [self baocangImg];
        
        [self baocangTitle];
        
    }
    return self;
}

- (UILabel *)dtqyLabel
{
    if (_dtqyLabel == nil)
    {
        _dtqyLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"--", nil) textColor:kMainBlackColor font:systemFont(12)];
        
        _dtqyLabel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:_dtqyLabel];
        
        [_dtqyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@15);
            
            make.top.equalTo(@20);
            
            make.height.equalTo(@15);
            
            make.width.equalTo(@((ScreenWidth - 30) / 3));
            
        }];
        
    }
    return _dtqyLabel;
}

- (UILabel *)dtqyTitle
{
    if (_dtqyTitle == nil)
    {
        _dtqyTitle = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"可用资金", nil) textColor:kMainDarkBlackColor font:systemFont(12)];
        
        _dtqyTitle.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:_dtqyTitle];
        
        [_dtqyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@15);
            
            make.bottom.equalTo(@(-20));
            
            make.height.equalTo(@15);
            
            make.width.equalTo(@((ScreenWidth - 30) / 3));
            
        }];
        
    }
    return _dtqyTitle;
}

- (UILabel *)qjLabel
{
    if (_qjLabel == nil)
    {
        _qjLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"---", nil) textColor:kMainBlackColor font:systemFont(12)];
        
        _qjLabel.adjustsFontSizeToFitWidth = YES;
        
        _qjLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_qjLabel];
        
        [_qjLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.mas_centerX);
            
            make.top.equalTo(@20);
            
            make.height.equalTo(@15);
            
            make.width.equalTo(@((ScreenWidth - 30) / 3));
            
        }];
        
    }
    return _qjLabel;
}

- (UILabel *)qjTitle
{
    if (_qjTitle == nil)
    {
        _qjTitle = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"冻结保证金", nil) textColor:kMainDarkBlackColor font:systemFont(12)];
        
        _qjTitle.adjustsFontSizeToFitWidth = YES;
        
        _qjTitle.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_qjTitle];
        
        [_qjTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.mas_centerX);
            
            make.bottom.equalTo(@(-20));
            
            make.height.equalTo(@15);
            
            make.width.equalTo(@((ScreenWidth - 30) / 3));
            
        }];
        
    }
    return _qjTitle;
}

- (UILabel *)baocangLabel
{
    if (_baocangLabel == nil)
    {
        _baocangLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"---", nil) textColor:kMainBlackColor font:systemFont(12)];
        
        _baocangLabel.textAlignment = NSTextAlignmentRight;
        
        _baocangLabel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:_baocangLabel];
        
        [_baocangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(@(-15));
            
            make.top.equalTo(@20);
            
            make.height.equalTo(@15);
            
            make.width.equalTo(@((ScreenWidth - 30) / 3));
            
        }];
        
    }
    return _baocangLabel;
}

-(UIImageView *)baocangImg
{
    if (_baocangImg == nil)
    {
        _baocangImg = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@"heyue_wenhao"];
        
        _baocangImg.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bcTapAction:)];
        
        [_baocangImg addGestureRecognizer:tap];
        
        [self addSubview:_baocangImg];
        
        [_baocangImg mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(@(-15));
            
            make.bottom.equalTo(@(-20));
            
            make.height.width.equalTo(@(15));
        }];
    }
    return _baocangImg;
}

- (UILabel *)baocangTitle
{
    if (_baocangTitle == nil)
    {
        _baocangTitle = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"爆仓率", nil) textColor:kMainDarkBlackColor font:systemFont(12)];
        
        _baocangTitle.textAlignment = NSTextAlignmentRight;
        
        _baocangTitle.adjustsFontSizeToFitWidth = YES;
        
        _baocangTitle.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bcTapAction:)];
        
        [_baocangTitle addGestureRecognizer:tap];
        
        [self addSubview:_baocangTitle];
        
        [_baocangTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.baocangImg.mas_left).offset(-5);
            
            make.bottom.equalTo(@(-20));
            
            make.height.equalTo(@15);
            
            make.width.equalTo(@((ScreenWidth - 30) / 3));
            
        }];
        
    }
    return _baocangTitle;
}

#pragma mark --- 爆仓率弹框
- (void)bcTapAction:(UITapGestureRecognizer *)tap
{
    if (self.bcTapBlock)
    {
        self.bcTapBlock(self.model.proportion);
    }
}

- (void)setDataWithDic:(GE_Mine_AccountRecord_Model *)model
{
    if ([kLogined integerValue] == 1)
    {
        self.model = model;
        
        self.dtqyLabel.text = model.isCanUseFund;

        self.qjLabel.text = model.frostDeposit;

        self.baocangLabel.text = model.proportion;
    }
    else
    {
        self.dtqyLabel.text = @"---";

        self.qjLabel.text = @"---";

        self.baocangLabel.text = @"---";
    }
    
}

@end
