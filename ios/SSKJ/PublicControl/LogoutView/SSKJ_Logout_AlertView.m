//
//  ETF_Logout_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/9.
//  Copyright © 2018年 James. All rights reserved.
//

#import "SSKJ_Logout_AlertView.h"

@interface SSKJ_Logout_AlertView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *showView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation SSKJ_Logout_AlertView

-(instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {

        
        [self addSubview:self.backView];
        [self addSubview:self.showView];
        [self.showView addSubview:self.titleLabel];
        [self.showView addSubview:self.messageLabel];
        [self.showView addSubview:self.cancelButton];
        [self.showView addSubview:self.confirmButton];
    }
    return self;
}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.7;
        
    }
    return _backView;
}

-(UIImageView *)showView
{
    if (nil == _showView) {
        _showView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(32), 0, self.width - ScaleW(64), ScaleW(150))];
//        _showView.image = [UIImage imageNamed:@"etf_alert"];
        _showView.backgroundColor = kMainWihteColor;
        _showView.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
        _showView.userInteractionEnabled = YES;
        _showView.layer.masksToBounds = YES;
        _showView.layer.cornerRadius =5;
    }
    return _showView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:@"提示" font:WLFontBoldSize(ScaleW(16)) textColor:kMainBlackColor frame:CGRectMake(ScaleW(15), ScaleW(20), self.showView.width - ScaleW(40), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UILabel *)messageLabel
{
    if (nil == _messageLabel) {
        _messageLabel = [WLTools allocLabel:@"请先登录" font:systemFont(ScaleW(14)) textColor:kMainBlackColor frame:CGRectMake(ScaleW(15), self.titleLabel.bottom + ScaleW(15), self.showView.width - ScaleW(30), ScaleW(50)) textAlignment:NSTextAlignmentLeft];
    }
    return _messageLabel;
}

-(UIButton *)cancelButton
{
    if (nil == _cancelButton) {
        
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(self.showView.width - ScaleW(120), ScaleW(150) - ScaleW(55), ScaleW(50), ScaleW(35))];
//        _cancelButton.centerX = self.showView.width / 2;
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:kMainColor forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = WLFontBoldSize(ScaleW(15));
        [_cancelButton addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.hidden = YES;
    }
    return _cancelButton;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {

        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.showView.width - ScaleW(60), ScaleW(150) - ScaleW(45), ScaleW(50), ScaleW(35))];
//        _confirmButton.centerX = self.showView.width / 2;
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = WLFontBoldSize(ScaleW(15));
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

-(void)showWithMessage:(NSString *)message
{
    self.isShow = YES;
    self.messageLabel.text = message;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

-(void)hide
{
    self.isShow = NO;
    [self removeFromSuperview];
}

- (void)cancelBtnAction{
    [self hide];
}

-(void)confirmEvent
{
    [self hide];
    if (self.confirmBlock) {
        self.confirmBlock();
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
