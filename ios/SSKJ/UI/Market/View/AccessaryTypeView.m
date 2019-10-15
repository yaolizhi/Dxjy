//
//  AccessaryTypeView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/1/7.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "AccessaryTypeView.h"

@interface AccessaryTypeView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *mainAccessaryTitleLabel;
@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UIButton *maBtn;
@property (nonatomic, strong) UIButton *bollBtn;
@property (nonatomic, strong) UIButton *mainCloseBtn;

@property (nonatomic, strong) UILabel *accessaryTitleLabel;
@property (nonatomic, strong) UIView *lineView2;
@property (nonatomic, strong) UIButton *macdBtn;
@property (nonatomic, strong) UIButton *kdjBtn;
@property (nonatomic, strong) UIButton *rsiBtn;
@property (nonatomic, strong) UIButton *wrBtn;
@property (nonatomic, strong) UIButton *accessaryCloseBtn;

@property (nonatomic, assign) CGFloat btnWidth;

@property (nonatomic, strong) NSMutableArray *mainButtonArray;
@property (nonatomic, strong) NSMutableArray *accessaryButtonArray;

@end

@implementation AccessaryTypeView

-(NSMutableArray *)mainButtonArray
{
    if (nil == _mainButtonArray) {
        _mainButtonArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _mainButtonArray;
}

-(NSMutableArray *)accessaryButtonArray
{
    if (nil == _accessaryButtonArray) {
        _accessaryButtonArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _accessaryButtonArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _btnWidth = (ScreenWidth - ScaleW(30)) / 6;
        [self addSubview:self.backView];
        [self.backView addSubview:self.mainAccessaryTitleLabel];
        [self.backView addSubview:self.lineView1];
        [self.backView addSubview:self.maBtn];
        [self.backView addSubview:self.bollBtn];
        [self.backView addSubview:self.mainCloseBtn];
        [self.mainButtonArray addObjectsFromArray:@[self.maBtn,self.bollBtn,self.mainCloseBtn]];
        
        [self.backView addSubview:self.accessaryTitleLabel];
        [self.backView addSubview:self.lineView2];
        [self.backView addSubview:self.macdBtn];
        [self.backView addSubview:self.kdjBtn];
        [self.backView addSubview:self.rsiBtn];
        [self.backView addSubview:self.wrBtn];
        [self.backView addSubview:self.accessaryCloseBtn];
        [self.accessaryButtonArray addObjectsFromArray:@[self.macdBtn,self.kdjBtn,self.rsiBtn,self.wrBtn,self.accessaryCloseBtn]];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remove)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)remove
{
    [self removeFromSuperview];
}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(100))];
        _backView.backgroundColor = UIColorFromRGB(0xF5F5F5);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

-(UILabel *)mainAccessaryTitleLabel
{
    if (nil == _mainAccessaryTitleLabel) {
        _mainAccessaryTitleLabel = [WLTools allocLabel:SSKJLocalized(@"主图", nil) font:systemFont(ScaleW(10)) textColor:CharBlueColor frame:CGRectMake(ScaleW(15), ScaleW(10), _btnWidth, ScaleW(30)) textAlignment:NSTextAlignmentCenter];
    }
    return _mainAccessaryTitleLabel;
}

-(UIView *)lineView1
{
    if (nil == _lineView1) {
        _lineView1 = [[UIView alloc]initWithFrame:CGRectMake(self.mainAccessaryTitleLabel.right, ScaleW(5), 0.5, ScaleW(20))];
        _lineView1.centerY = self.mainAccessaryTitleLabel.centerY;
        _lineView1.backgroundColor = CharBlueColor;
    }
    return _lineView1;
}

-(UIButton *)maBtn
{
    if (nil == _maBtn) {
        _maBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.lineView1.right, ScaleW(5), _btnWidth, ScaleW(30))];
        _maBtn.centerY = self.lineView1.centerY;
        _maBtn.selected = YES;
        [_maBtn setTitle:@"MA" forState:UIControlStateNormal];
        [_maBtn setTitleColor:CharBlueColor forState:UIControlStateNormal];
        [_maBtn setTitleColor:kMainColor forState:UIControlStateSelected];
        _maBtn.titleLabel.font = systemFont(ScaleW(10));
        _maBtn.tag = 101;
        [_maBtn addTarget:self action:@selector(changeAccessaryType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _maBtn;
}

-(UIButton *)bollBtn
{
    if (nil == _bollBtn) {
        _bollBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.maBtn.right, self.maBtn.y, _btnWidth, ScaleW(30))];
        [_bollBtn setTitle:@"BOLL" forState:UIControlStateNormal];
        [_bollBtn setTitleColor:CharBlueColor forState:UIControlStateNormal];
        [_bollBtn setTitleColor:kMainColor forState:UIControlStateSelected];
        _bollBtn.titleLabel.font = systemFont(ScaleW(10));
        _bollBtn.tag = 102;
        [_bollBtn addTarget:self action:@selector(changeAccessaryType:) forControlEvents:UIControlEventTouchUpInside];


    }
    return _bollBtn;
}

-(UIButton *)mainCloseBtn
{
    if (nil == _mainCloseBtn) {
        _mainCloseBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - _btnWidth, self.maBtn.y, _btnWidth, ScaleW(30))];
        [_mainCloseBtn setTitle:SSKJLocalized(@"关闭", nil) forState:UIControlStateNormal];
        [_mainCloseBtn setTitleColor:CharBlueColor forState:UIControlStateNormal];
        [_mainCloseBtn setTitleColor:kMainColor forState:UIControlStateSelected];
        _mainCloseBtn.titleLabel.font = systemFont(ScaleW(10));
        _mainCloseBtn.tag = 201;
        [_mainCloseBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mainCloseBtn;
}

-(UILabel *)accessaryTitleLabel
{
    if (nil == _accessaryTitleLabel) {
        _accessaryTitleLabel = [WLTools allocLabel:SSKJLocalized(@"副图", nil) font:systemFont(ScaleW(10)) textColor:CharBlueColor frame:CGRectMake(ScaleW(15), self.mainAccessaryTitleLabel.bottom + ScaleW(10), _btnWidth, ScaleW(30)) textAlignment:NSTextAlignmentCenter];
    }
    return _accessaryTitleLabel;
}

-(UIView *)lineView2
{
    if (nil == _lineView2) {
        _lineView2 = [[UIView alloc]initWithFrame:CGRectMake(self.mainAccessaryTitleLabel.right, ScaleW(5), 0.5, ScaleW(20))];
        _lineView2.centerY = self.accessaryTitleLabel.centerY;
        _lineView2.backgroundColor = CharBlueColor;
    }
    return _lineView2;
}

-(UIButton *)macdBtn
{
    if (nil == _macdBtn) {
        _macdBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.lineView2.right, self.accessaryTitleLabel.y, _btnWidth, ScaleW(30))];
        [_macdBtn setTitle:@"MACD" forState:UIControlStateNormal];
        [_macdBtn setTitleColor:CharBlueColor forState:UIControlStateNormal];
        [_macdBtn setTitleColor:kMainColor forState:UIControlStateSelected];
        _macdBtn.titleLabel.font = systemFont(ScaleW(10));
        _macdBtn.tag = 103;
        [_macdBtn addTarget:self action:@selector(changeAccessaryType:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _macdBtn;
}

-(UIButton *)kdjBtn
{
    if (nil == _kdjBtn) {
        _kdjBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.macdBtn.right, self.macdBtn.y, _btnWidth, ScaleW(30))];
        [_kdjBtn setTitle:@"KDJ" forState:UIControlStateNormal];
        [_kdjBtn setTitleColor:CharBlueColor forState:UIControlStateNormal];
        [_kdjBtn setTitleColor:kMainColor forState:UIControlStateSelected];
        _kdjBtn.titleLabel.font = systemFont(ScaleW(10));
        _kdjBtn.tag = 104;
        [_kdjBtn addTarget:self action:@selector(changeAccessaryType:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _kdjBtn;
}

-(UIButton *)rsiBtn
{
    if (nil == _rsiBtn) {
        _rsiBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.kdjBtn.right, self.macdBtn.y, _btnWidth, ScaleW(30))];
        [_rsiBtn setTitle:@"RSI" forState:UIControlStateNormal];
        [_rsiBtn setTitleColor:CharBlueColor forState:UIControlStateNormal];
        [_rsiBtn setTitleColor:kMainColor forState:UIControlStateSelected];
        _rsiBtn.titleLabel.font = systemFont(ScaleW(10));
        _rsiBtn.tag = 105;
        [_rsiBtn addTarget:self action:@selector(changeAccessaryType:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _rsiBtn;
}


-(UIButton *)wrBtn
{
    if (nil == _wrBtn) {
        _wrBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.rsiBtn.right, self.macdBtn.y, _btnWidth, ScaleW(30))];
        [_wrBtn setTitle:@"WR" forState:UIControlStateNormal];
        [_wrBtn setTitleColor:CharBlueColor forState:UIControlStateNormal];
        [_wrBtn setTitleColor:kMainColor forState:UIControlStateSelected];
        _wrBtn.titleLabel.font = systemFont(ScaleW(10));
        _wrBtn.tag = 106;
        [_wrBtn addTarget:self action:@selector(changeAccessaryType:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _wrBtn;
}

-(UIButton *)accessaryCloseBtn
{
    if (nil == _accessaryCloseBtn) {
        _accessaryCloseBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - _btnWidth, self.macdBtn.y, _btnWidth, ScaleW(30))];
        [_accessaryCloseBtn setTitle:SSKJLocalized(@"关闭", nil) forState:UIControlStateNormal];
        [_accessaryCloseBtn setTitleColor:CharBlueColor forState:UIControlStateNormal];
        [_accessaryCloseBtn setTitleColor:kMainColor forState:UIControlStateSelected];
        _accessaryCloseBtn.titleLabel.font = systemFont(ScaleW(10));
        _accessaryCloseBtn.tag = 202;
        _accessaryCloseBtn.selected = YES;
        [_accessaryCloseBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _accessaryCloseBtn;
}

-(void)changeAccessaryType:(UIButton *)sender
{
    if (sender.selected) {
        return;
    }
    if (sender.tag - 100 < 3) {
        for (UIButton *btn in self.mainButtonArray) {
            if (btn == sender) {
                btn.selected = YES;
            }else{
                btn.selected = NO;
            }
        }
        
        if (self.mainAccessaryTypeBlock) {
            self.mainAccessaryTypeBlock((LXY_KMAINACCESSORYTYPE)(sender.tag - 100));
        }
    }
    
    if (sender.tag - 100 > 2) {
        for (UIButton *btn in self.accessaryButtonArray) {
            if (btn == sender) {
                btn.selected = YES;
            }else{
                btn.selected = NO;
            }
        }
        if (self.accessaryTypeBlock) {
            self.accessaryTypeBlock((LXY_ACCESSORYTYPE)(sender.tag - 102));
        }
    }
}

-(void)close:(UIButton *)sender
{
    if (sender.tag == 201) {
        for (UIButton *btn in self.mainButtonArray) {
            if (btn == sender) {
                btn.selected = YES;
            }else{
                btn.selected = NO;
            }
        }
        if (self.mainAccessaryTypeBlock) {
            self.mainAccessaryTypeBlock(LXY_KMAINACCESSORYTYPENONE);
        }
    }else{
        for (UIButton *btn in self.accessaryButtonArray) {
            if (btn == sender) {
                btn.selected = YES;
            }else{
                btn.selected = NO;
            }
        }
        if (self.accessaryTypeBlock) {
            self.accessaryTypeBlock(LXY_ACCESSORYTYPENONE);
        }
    }
}

@end
