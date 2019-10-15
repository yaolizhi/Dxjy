//
//  Y_KCurrentPriceView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2018/7/25.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Y_KCurrentPriceView.h"

@interface Y_KCurrentPriceView()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *pointView;

@property (nonatomic, strong) CAAnimationGroup *groups;
@end

@implementation Y_KCurrentPriceView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.lineView];
        [self addSubview:self.pointView];
      
    }
    return self;
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        _lineView.backgroundColor = [WLTools stringToColor:@"#6a83aa"];
        _lineView.centerY = self.height / 2;
    }
    return _lineView;
}

-(UIView *)pointView
{
    UIView *arroundView  = nil;
    if (nil == _pointView) {
        _pointView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
        _pointView.layer.masksToBounds = NO;
        _pointView.layer.cornerRadius = 2.5;
        //_pointView.layer.borderColor = [WLTools stringToColor:@"#cccccc"].CGColor;
        //_pointView.layer.borderWidth = 1;
        _pointView.backgroundColor = [UIColor redColor];
        _pointView.centerY = self.height / 2;
        _pointView.centerX = self.width;
      
    }
    for (UIView *v  in _pointView.subviews) {
        
        [v removeFromSuperview];
    }
     arroundView = [[UIView alloc]initWithFrame:_pointView.bounds];
     arroundView.backgroundColor = _pointView.backgroundColor;
     arroundView.layer.cornerRadius = 2.5;
     [_pointView addSubview:arroundView];
     [arroundView.layer removeAllAnimations];
     [arroundView.layer addAnimation:self.groups forKey:@"group"];
 
    return _pointView;
}


- (CAAnimationGroup *)groups {
    if (!_groups) {
        // 缩放动画
        CABasicAnimation * scaleAnim = [CABasicAnimation animation];
        scaleAnim.keyPath = @"transform.scale";
        scaleAnim.fromValue = @1;
        scaleAnim.toValue = @3;
        scaleAnim.duration = 2;
        // 透明度动画
        CABasicAnimation *opacityAnim=[CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnim.fromValue= @0.8;
        opacityAnim.toValue= @0.4;
        opacityAnim.duration= 2;
        // 创建动画组
        _groups =[CAAnimationGroup animation];
        _groups.animations = @[scaleAnim,opacityAnim];
        _groups.removedOnCompletion = NO;
        _groups.fillMode = kCAFillModeForwards;
        _groups.duration = 2;
        _groups.repeatCount = FLT_MAX;
    }
    return _groups;
}

-(void)setViewWithIsShowLast:(BOOL)isShowLast
{
    if (isShowLast) {
        self.pointView.hidden = NO;
    }else{
        self.pointView.hidden = YES;
    }
}

-(void)resetWith
{
    _pointView.centerX = self.width - 2.5;
    _lineView.width = self.width - 2.5;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
