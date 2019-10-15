//
//  Transaction_HistoryTransactionInquiry_HeaderView.m
//  ZYW_MIT
//
//  Created by Wang on 2017/11/21.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "Transaction_HistoryTransactionInquiry_HeaderView.h"
//Utils
//#import "Global.h"
#import "UIColor+Hex.h"
#define kleftSpace ScaleH(10)
#define klogoImageWidth ScaleH(28)
#define khspace ScaleH(20)
#define ktopSpace ScaleH(8)
@interface Transaction_HistoryTransactionInquiry_HeaderView()
@end
@implementation Transaction_HistoryTransactionInquiry_HeaderView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

#pragma mark -- action event
- (void)selectStartDateEvent {
    if (_delegate && [_delegate respondsToSelector:@selector(selectedStartDate)]) {
        [_delegate selectedStartDate];
    }
}

- (void)selectEndDateEvent {
    if (_delegate && [_delegate respondsToSelector:@selector(selectedEndDate)]) {
        [_delegate selectedEndDate];
    }
}
#pragma mark -- 初始化视图
- (void)setupSubViews {
    CGFloat itemWidth = (ScreenWidth - 2*kleftSpace - 2*khspace - klogoImageWidth)/2;
    UIControl *selectStartDateControl = [[UIControl alloc]init];
    selectStartDateControl.frame = CGRectMake(kleftSpace
                                              , ktopSpace
                                              , itemWidth
                                              , ScaleH(60));
    selectStartDateControl.backgroundColor = [UIColor clearColor];
    [selectStartDateControl addTarget:self action:@selector(selectStartDateEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:selectStartDateControl];
    
    UILabel *startDateTitleLabel = [[UILabel alloc]init];
    startDateTitleLabel.frame = CGRectMake(0
                                           , 0
                                           , CGRectGetWidth(selectStartDateControl.bounds)
                                           , ScaleH(30));
    startDateTitleLabel.text = @"起始日期";
    startDateTitleLabel.font = [UIFont systemFontOfSize:ScaleW(15)];
    startDateTitleLabel.textColor = kMainGrayColor;
    startDateTitleLabel.textAlignment = NSTextAlignmentCenter;
    [selectStartDateControl addSubview:startDateTitleLabel];
    
    _startDateLabel = [[UILabel alloc]init];
    _startDateLabel.frame = CGRectMake(CGRectGetMinX(startDateTitleLabel.frame)
                                           , CGRectGetMaxY(startDateTitleLabel.frame)
                                           , CGRectGetWidth(startDateTitleLabel.bounds)
                                           , CGRectGetHeight(startDateTitleLabel.bounds));
    _startDateLabel.font = [UIFont systemFontOfSize:ScaleW(14)];
    _startDateLabel.textColor = kMainBlackColor;
    _startDateLabel.textAlignment = NSTextAlignmentCenter;
    [selectStartDateControl addSubview:_startDateLabel];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(CGRectGetMaxX(selectStartDateControl.frame) + khspace
                                 , CGRectGetMidY(selectStartDateControl.frame) - klogoImageWidth/2
                                 , klogoImageWidth
                                 , klogoImageWidth);
    imageView.image = [UIImage imageNamed:@"GE_Trading_fangxiang"];
    [self addSubview:imageView];
    
    UIControl *selectEndDateControl = [[UIControl alloc]init];
    selectEndDateControl.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + khspace
                                              , CGRectGetMinY(selectStartDateControl.frame)
                                              , CGRectGetWidth(selectStartDateControl.bounds)
                                              , CGRectGetHeight(selectStartDateControl.bounds));
    selectEndDateControl.backgroundColor = [UIColor clearColor];
    [selectEndDateControl addTarget:self action:@selector(selectEndDateEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:selectEndDateControl];
    
    UILabel *endDateTitleLabel = [[UILabel alloc]init];
    endDateTitleLabel.frame = CGRectMake(0
                                           , 0
                                           , CGRectGetWidth(selectStartDateControl.bounds)
                                           , ScaleH(30));
    endDateTitleLabel.text =  @"截止日期";
    endDateTitleLabel.font = [UIFont systemFontOfSize:ScaleW(15)];
    endDateTitleLabel.textColor = kMainGrayColor;
    endDateTitleLabel.textAlignment = NSTextAlignmentCenter;
    [selectEndDateControl addSubview:endDateTitleLabel];
    
    _endDateLabel = [[UILabel alloc]init];
    _endDateLabel.frame = CGRectMake(CGRectGetMinX(endDateTitleLabel.frame)
                                       , CGRectGetMaxY(endDateTitleLabel.frame)
                                       , CGRectGetWidth(endDateTitleLabel.bounds)
                                       , CGRectGetHeight(endDateTitleLabel.bounds));
    _endDateLabel.font = [UIFont systemFontOfSize:ScaleW(14)];
    _endDateLabel.textColor = kMainBlackColor;
    _endDateLabel.textAlignment = NSTextAlignmentCenter;
    [selectEndDateControl addSubview:_endDateLabel];
}
@end
