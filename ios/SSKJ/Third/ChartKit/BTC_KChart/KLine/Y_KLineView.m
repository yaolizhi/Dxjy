//
//  Y_KLineView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineView.h"
#import "Y_KLineMainView.h"
#import "Y_KLineMAView.h"
#import "Y_VolumeMAView.h"
#import "Y_KCurrentPriceView.h"
#import "TipView.h"
#import "KLine_TimeView.h"
#import "Y_AccessoryMAView.h"
#import "Masonry.h"
#import "UIColor+Y_StockChart.h"
//#import "UIView+Frame.h"
#import "UIView+Extension.h"

#import "Y_StockChartGlobalVariable.h"
#import "Y_KLineVolumeView.h"
#import "Y_StockChartRightYView.h"
#import "Y_KLineAccessoryView.h"
//#import "Global.h"
#import "UIColor+Hex.h"
@interface Y_KLineView() <UIScrollViewDelegate, Y_KLineMainViewDelegate, Y_KLineVolumeViewDelegate, Y_KLineAccessoryViewDelegate>
{
    CGFloat _scrollGap;
}

@property (nonatomic, strong) UIScrollView *scrollView;
/**
 *  主K线图
 */
@property (nonatomic, strong) Y_KLineMainView *kLineMainView;

/**
 *  成交量图
 */
@property (nonatomic, strong) Y_KLineVolumeView *kLineVolumeView;

/**
 *  副图
 */
//@property (nonatomic, strong) Y_KLineAccessoryView *kLineAccessoryView;

/**
 *  左侧价格图
 */
@property (nonatomic, strong) Y_StockChartRightYView *priceView;

/**
 *  左侧成交量图
 */
@property (nonatomic, strong) Y_StockChartRightYView *volumeView;

/**
 *  左侧成交量图
 */
@property (nonatomic, strong) KLine_TimeView *timeView;

/**
 *  右侧Accessory图
 */
//@property (nonatomic, strong) Y_StockChartRightYView *accessoryView;

/**
 *  旧的scrollview准确位移
 */
@property (nonatomic, assign) CGFloat oldExactOffset;

/**
 *  kLine-MAView
 */
@property (nonatomic, strong) Y_KLineMAView *kLineMAView;

@property (nonatomic, strong) UILabel *maxPriceLabel;

@property (nonatomic, strong) UILabel *minPriceLabel;
//
///**
// *  Volume-MAView
// */
//@property (nonatomic, strong) Y_VolumeMAView *volumeMAView;
//
///**
// *  Accessory-MAView
// */
//@property (nonatomic, strong) Y_AccessoryMAView *accessoryMAView;

/**
 *  长按后显示的View
 */
@property (nonatomic, strong) UIView *verticalView;
@property (nonatomic, strong) UIView *horizontalView;
@property (nonatomic, strong) TipView *tipView;

// 当前价线
@property (nonatomic, strong) Y_KCurrentPriceView *currentPriceView;

@property (nonatomic, strong) MASConstraint *kLineMainViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *kLineVolumeViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *priceViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *volumeViewHeightConstraint;

@end

@implementation Y_KLineView

//initWithFrame设置视图比例
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.mainViewRatio = [Y_StockChartGlobalVariable kLineMainViewRadio];
        self.volumeViewRatio = [Y_StockChartGlobalVariable kLineVolumeViewRadio];
//        self.backgroundColor = [UIColor whiteColor];
        self.isShowLast = YES;
        [self addBorder];
    }
    return self;
}

- (UIScrollView *)scrollView
{
    if(!_scrollView)
    {
        _scrollView = [UIScrollView new];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.minimumZoomScale = 1.0f;
        _scrollView.maximumZoomScale = 1.0f;
//        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        
        //缩放手势
//        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(event_pichMethod:)];
//        [_scrollView addGestureRecognizer:pinchGesture];
        
        //长按手势
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressMethod:)];
        [_scrollView addGestureRecognizer:longPressGesture];
        
        [self addSubview:_scrollView];
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.kLineMAView.mas_bottom);
            make.right.equalTo(self).offset(0);
            make.left.equalTo(@0);
            make.bottom.equalTo(self.timeView.mas_top);
        }];
        
        [self layoutIfNeeded];
    }
    return _scrollView;
}

- (Y_KLineMAView *)kLineMAView
{
    if (!_kLineMAView) {
        _kLineMAView = [Y_KLineMAView view];
        [self addSubview:_kLineMAView];
        [_kLineMAView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(@40);
            make.top.equalTo(self).offset(5);
            make.height.equalTo(@10);
        }];
    }
    
    if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
        _kLineMAView.hidden = NO;
    }else{
        _kLineMAView.hidden = YES;
    }
    return _kLineMAView;
}
//
//- (Y_VolumeMAView *)volumeMAView
//{
//    if (!_volumeMAView) {
//        _volumeMAView = [Y_VolumeMAView view];
//        [self addSubview:_volumeMAView];
//        [_volumeMAView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self);
//            make.left.equalTo(self);
//            make.top.equalTo(self.kLineVolumeView.mas_top);
//            make.height.equalTo(@10);
//        }];
//    }
//    return _volumeMAView;
//}
//
//- (Y_AccessoryMAView *)accessoryMAView
//{
//    if(!_accessoryMAView) {
//        _accessoryMAView = [Y_AccessoryMAView new];
//        [self addSubview:_accessoryMAView];
//        [_accessoryMAView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self);
//            make.left.equalTo(self);
//            make.top.equalTo(self.kLineAccessoryView.mas_top);
//            make.height.equalTo(@10);
//        }];
//    }
//    return _accessoryMAView;
//}

- (Y_KLineMainView *)kLineMainView
{
    if (!_kLineMainView && self) {
        _kLineMainView = [Y_KLineMainView new];
        _kLineMainView.backgroundColor = UIColorFromRGB(0x131f30);
        _kLineMainView.delegate = self;
        [self.scrollView addSubview:_kLineMainView];
        [_kLineMainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView).offset(5);
            make.left.equalTo(self.scrollView);
            self.kLineMainViewHeightConstraint = make.height.equalTo(self.scrollView).multipliedBy(self.mainViewRatio);
            make.right.equalTo(@0);
        }];
        
    }
    //加载rightYYView
    self.priceView.backgroundColor = [UIColor clearColor];
    self.volumeView.backgroundColor = [UIColor clearColor];
//    self.accessoryView.backgroundColor = [UIColor clearColor];
    return _kLineMainView;
}

- (Y_KLineVolumeView *)kLineVolumeView
{
    if(!_kLineVolumeView && self)
    {
        _kLineVolumeView = [Y_KLineVolumeView new];
        _kLineVolumeView.delegate = self;
        _kLineVolumeView.backgroundColor = UIColorFromRGB(0x131f30);
        [self.scrollView addSubview:_kLineVolumeView];
        [_kLineVolumeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.kLineMainView);
            make.top.equalTo(self.kLineMainView.mas_bottom).offset(10);
            make.width.equalTo(self.kLineMainView.mas_width);
//            self.kLineVolumeViewHeightConstraint = make.height.equalTo(self.scrollView.mas_height).multipliedBy(self.volumeViewRatio);
            make.bottom.equalTo(self.volumeView.mas_bottom);
        }];
        [self layoutIfNeeded];
    }
    return _kLineVolumeView;
}

//- (Y_KLineAccessoryView *)kLineAccessoryView
//{
//    if(!_kLineAccessoryView && self)
//    {
//        _kLineAccessoryView = [Y_KLineAccessoryView new];
//        _kLineAccessoryView.delegate = self;
//        [self.scrollView addSubview:_kLineAccessoryView];
//        [_kLineAccessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.kLineVolumeView);
//            make.top.equalTo(self.kLineVolumeView.mas_bottom).offset(10);
//            make.width.equalTo(self.kLineVolumeView.mas_width);
//            make.height.equalTo(self.scrollView.mas_height).multipliedBy(0.2);
//        }];
//        [self layoutIfNeeded];
//    }
//    return _kLineAccessoryView;
//}

- (Y_StockChartRightYView *)priceView
{
    if(!_priceView)
    {
        _priceView = [Y_StockChartRightYView new];
        _priceView.layer.masksToBounds = YES;
        [self insertSubview:_priceView aboveSubview:self.scrollView];
        [_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self).offset(15);
//            make.right.equalTo(self.mas_right);
            make.width.equalTo(@50);
            make.bottom.equalTo(self.kLineMainView.mas_bottom);
        }];
    }
    return _priceView;
}

- (Y_StockChartRightYView *)volumeView
{
    if(!_volumeView)
    {
        _volumeView = [Y_StockChartRightYView new];
        [self insertSubview:_volumeView aboveSubview:self.scrollView];
        [_volumeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.kLineVolumeView.mas_top).offset(5);
            make.right.width.equalTo(self.priceView);
//            make.height.equalTo(self).multipliedBy(self.volumeViewRatio);
            make.bottom.equalTo(self.scrollView);
        }];
    }
    return _volumeView;
}

-(KLine_TimeView *)timeView
{
    if (nil == _timeView) {
        _timeView = [[KLine_TimeView alloc]init];
        [self addSubview:_timeView];
        [_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(@0);
            make.left.equalTo(self.scrollView.mas_left);
            make.height.equalTo(@20);
        }];
    }
    return _timeView;
}

//- (Y_StockChartRightYView *)accessoryView
//{
//    if(!_accessoryView)
//    {
//        _accessoryView = [Y_StockChartRightYView new];
//        [self insertSubview:_accessoryView aboveSubview:self.scrollView];
//        [_accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.kLineAccessoryView.mas_top).offset(10);
//            make.right.width.equalTo(self.volumeView);
//            make.height.equalTo(self.kLineAccessoryView.mas_height);
//        }];
//    }
//    return _accessoryView;
//}
#pragma mark - set方法

#pragma mark kLineModels设置方法
- (void)setKLineModels:(NSArray *)kLineModels
{
    if(!kLineModels) {
        return;
    }
    _kLineModels = kLineModels;
    [self private_drawKLineMainView];
    //设置contentOffset
    CGFloat kLineViewWidth = self.kLineModels.count * [Y_StockChartGlobalVariable kLineWidth] + (self.kLineModels.count + 1) * [Y_StockChartGlobalVariable kLineGap] + 10;
    CGFloat offset = kLineViewWidth - self.scrollView.frame.size.width;
    if (offset > 0)
    {
        self.scrollView.contentOffset = CGPointMake(offset, 0);
    } else {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    
    Y_KLineModel *model = [kLineModels lastObject];
    [self.kLineMAView maProfileWithModel:model];
//    [self.tipView setViewWithModel:model lineType:1];
//    [self.volumeMAView maProfileWithModel:model];
//    self.accessoryMAView.targetLineStatus = self.targetLineStatus;
//    [self.accessoryMAView maProfileWithModel:model];
    self.timeView;
}
- (void)setTargetLineStatus:(Y_StockChartTargetLineStatus)targetLineStatus
{
    _targetLineStatus = targetLineStatus;
    if(targetLineStatus < 103)
    {
        if(targetLineStatus == Y_StockChartTargetLineStatusAccessoryClose){
            
            [Y_StockChartGlobalVariable setkLineMainViewRadio:0.65];
            [Y_StockChartGlobalVariable setkLineVolumeViewRadio:0.28];

        } else {
            [Y_StockChartGlobalVariable setkLineMainViewRadio:0.5];
            [Y_StockChartGlobalVariable setkLineVolumeViewRadio:0.2];

        }
        
        [self.kLineMainViewHeightConstraint uninstall];
        [_kLineMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            self.kLineMainViewHeightConstraint = make.height.equalTo(self.scrollView).multipliedBy([Y_StockChartGlobalVariable kLineMainViewRadio]);
        }];
        [self.kLineVolumeViewHeightConstraint uninstall];
        [self.kLineVolumeView mas_updateConstraints:^(MASConstraintMaker *make) {
            self.kLineVolumeViewHeightConstraint = make.height.equalTo(self.scrollView.mas_height).multipliedBy([Y_StockChartGlobalVariable kLineVolumeViewRadio]);
        }];
        [self reDraw];
    }

}
#pragma mark - event事件处理方法
#pragma mark 缩放执行方法
- (void)event_pichMethod:(UIPinchGestureRecognizer *)pinch
{
    static CGFloat oldScale = 1.0f;
    CGFloat difValue = pinch.scale - oldScale;
    if(ABS(difValue) > Y_StockChartScaleBound) {
        CGFloat oldKLineWidth = [Y_StockChartGlobalVariable kLineWidth];
        
        NSInteger oldNeedDrawStartIndex = self.kLineMainView.needDrawStartIndex;
//        //NSLog(Localized(@"原来的index%ld", nil),self.kLineMainView.needDrawStartIndex);
        [Y_StockChartGlobalVariable setkLineWith:oldKLineWidth * (difValue > 0 ? (1 + Y_StockChartScaleFactor) : (1 - Y_StockChartScaleFactor))];
        oldScale = pinch.scale;
        //更新MainView的宽度
        [self.kLineMainView updateMainViewWidth];
        
        if( pinch.numberOfTouches == 2 ) {
            CGPoint p1 = [pinch locationOfTouch:0 inView:self.scrollView];
            CGPoint p2 = [pinch locationOfTouch:1 inView:self.scrollView];
            CGPoint centerPoint = CGPointMake((p1.x+p2.x)/2, (p1.y+p2.y)/2);
            NSUInteger oldLeftArrCount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + oldKLineWidth);
            NSUInteger newLeftArrCount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]);
            
//            NSInteger oldCenter = oldNeedDrawStartIndex + self.scrollView.width / ([Y_StockChartGlobalVariable kLineGap] + oldKLineWidth) / 2;
//            NSInteger newCount = self.scrollView.width / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]);
            
            
            
            self.kLineMainView.pinchStartIndex = -1;
//            self.scrollView.contentOffset = CGPointMake((oldNeedDrawStartIndex) * ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]), 0);
            //            self.kLineMainView.pinchPoint = centerPoint;
            //NSLog(@"======= %f=====",self.scrollView.contentOffset.x);
        }
        [self.kLineMainView drawMainView];
    }
}
#pragma mark 长按手势执行方法
- (void)event_longPressMethod:(UILongPressGestureRecognizer *)longPress
{
    static CGFloat oldPositionX = 0;
    if(UIGestureRecognizerStateChanged == longPress.state || UIGestureRecognizerStateBegan == longPress.state)
    {
        CGPoint location = [longPress locationInView:self.scrollView];
        if(ABS(oldPositionX - location.x) < ([Y_StockChartGlobalVariable kLineWidth] + [Y_StockChartGlobalVariable kLineGap])/2)
        {
            return;
        }
        
        //暂停滑动
        self.scrollView.scrollEnabled = NO;
        oldPositionX = location.x;
        
        //初始化竖线
        if(!self.verticalView)
        {
            self.verticalView = [UIView new];
            self.verticalView.clipsToBounds = YES;
            [self.scrollView addSubview:self.verticalView];
            self.verticalView.backgroundColor = [UIColor longPressLineColor];
            [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(15);
                make.width.equalTo(@(Y_StockChartLongPressVerticalViewWidth));
                make.height.equalTo(self.scrollView.mas_height);
                make.left.equalTo(@(-10));
            }];
        }
        
        //初始化竖线
        if(!self.horizontalView)
        {
            self.horizontalView = [UIView new];
            self.horizontalView.clipsToBounds = YES;
            [self.scrollView addSubview:self.horizontalView];
            self.horizontalView.backgroundColor = [UIColor longPressLineColor];
            [self.horizontalView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(10);
                make.width.equalTo(self.kLineMainView.mas_width);
                make.height.equalTo(@(Y_StockChartLongPressVerticalViewWidth));
                make.left.equalTo(@(0));
            }];
        }
        
        if(!self.tipView)
        {
            self.tipView = [[TipView alloc]initWithFrame:CGRectMake(0, 15, 100, 75)];
            self.tipView.clipsToBounds = YES;
            [self addSubview:self.tipView];
        }
        
        //更新竖线位置
        CGFloat rightXPosition = [self.kLineMainView getExactXPositionWithOriginXPosition:location.x];
        [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(rightXPosition));
        }];
        [self.verticalView layoutIfNeeded];
        self.verticalView.hidden = NO;
        
        //更新横线位置
        CGFloat topYPosition = [self.kLineMainView getExactYPositionWithOriginXPosition:location.x];
        [self.horizontalView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(topYPosition);
        }];
        [self.horizontalView layoutIfNeeded];
        self.horizontalView.hidden = NO;
        // 更新悬浮框的位置
        if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
            self.tipView.hidden = NO;
            CGFloat startX = rightXPosition - self.scrollView.contentOffset.x;
            if (startX < self.scrollView.frame.size.width / 2) {
                //            self.tipView.
                CGRect frame = self.tipView.frame;
                frame.origin.x = self.frame.size.width - self.tipView.frame.size.width;
                self.tipView.frame = frame;
            }else{
                CGRect frame = self.tipView.frame;
                frame.origin.x = self.scrollView.frame.origin.x;
                self.tipView.frame = frame;
            }
            
        }else{
            self.tipView.hidden = YES;
        }
        
        
        // 更新十字线时间的位置
//        self.timeView setCrossTimeWithPositionX:startX model:<#(Y_KLineModel *)#>
        
    }
    
    if(longPress.state == UIGestureRecognizerStateEnded)
    {
        //取消竖线
        if(self.verticalView)
        {
            self.verticalView.hidden = YES;
        }
        //取消横线
        if(self.horizontalView)
        {
            self.horizontalView.hidden = YES;
        }
        
        // 取消悬浮框
        if(self.tipView)
        {
            self.tipView.hidden = YES;
        }
        
        [self.timeView hiddenCrossLabel];
        [self.priceView hiddenCrossPrice];
        oldPositionX = 0;
        //恢复scrollView的滑动
        self.scrollView.scrollEnabled = YES;
        
        Y_KLineModel *lastModel = self.kLineModels.lastObject;
        [self.kLineMAView maProfileWithModel:lastModel];
//        [self.volumeMAView maProfileWithModel:lastModel];
//        [self.accessoryMAView maProfileWithModel:lastModel];
    }
}

#pragma mark 重绘
- (void)reDraw
{
    self.kLineMainView.MainViewType = self.MainViewType;
    
    if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
        [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
        }];
    }else{
        [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
        }];
    }
    
    if(self.targetLineStatus >= 103)
    {
        self.kLineMainView.targetLineStatus = self.targetLineStatus;
    }
    [self.kLineMainView drawMainView];
}


#pragma mark - 私有方法
#pragma mark 画KLineMainView
- (void)private_drawKLineMainView
{
    self.kLineMainView.kLineModels = self.kLineModels;
    [self.kLineMainView drawMainView];
}
- (void)private_drawKLineVolumeView
{
   // NSAssert(self.kLineVolumeView, Localized(@"kLineVolume不存在", nil));
    //更新约束
    [self.kLineVolumeView layoutIfNeeded];
    [self.kLineVolumeView draw];
}
- (void)private_drawKLineAccessoryView
{
    //更新约束
//    self.accessoryMAView.targetLineStatus = self.targetLineStatus;
//    [self.accessoryMAView maProfileWithModel:_kLineModels.lastObject];
//    [self.kLineAccessoryView layoutIfNeeded];
//    [self.kLineAccessoryView draw];
}
#pragma mark VolumeView代理
- (void)kLineVolumeViewCurrentMaxVolume:(CGFloat)maxVolume minVolume:(CGFloat)minVolume
{
    self.volumeView.maxValue = maxVolume;
    self.volumeView.minValue = minVolume;
    self.volumeView.middleValue = (maxVolume - minVolume)/2 + minVolume;
}
- (void)kLineMainViewCurrentMaxPrice:(CGFloat)maxPrice minPrice:(CGFloat)minPrice
{
    self.priceView.maxValue = maxPrice;
    self.priceView.minValue = minPrice;
    self.priceView.middleValue = (maxPrice - minPrice)/2 + minPrice;
}
//- (void)kLineAccessoryViewCurrentMaxValue:(CGFloat)maxValue minValue:(CGFloat)minValue
//{
//    self.accessoryView.maxValue = maxValue;
//    self.accessoryView.minValue = minValue;
//    self.accessoryView.middleValue = (maxValue - minValue)/2 + minValue;
//}
#pragma mark MainView更新时通知下方的view进行相应内容更新
- (void)kLineMainViewCurrentNeedDrawKLineModels:(NSArray *)needDrawKLineModels
{
    self.kLineVolumeView.needDrawKLineModels = needDrawKLineModels;
    [self.timeView setViewWithArray:needDrawKLineModels];
    [self.kLineMAView maProfileWithModel:needDrawKLineModels.lastObject];

//    self.kLineAccessoryView.needDrawKLineModels = needDrawKLineModels;
}
- (void)kLineMainViewCurrentNeedDrawKLinePositionModels:(NSArray *)needDrawKLinePositionModels
{
    self.kLineVolumeView.needDrawKLinePositionModels = needDrawKLinePositionModels;
    
    if (needDrawKLinePositionModels.count + self.kLineMainView.needDrawStartIndex == self.kLineMainView.kLineModels.count) {
        _isShowLast = YES;
        
        Y_KLinePositionModel *firstPositionModel = needDrawKLinePositionModels.firstObject;
        CGFloat gap = firstPositionModel.OpenPoint.x - self.scrollView.contentOffset.x;
        _scrollGap = gap;
        [self.currentPriceView setViewWithIsShowLast:YES];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"movetolast" object:nil];
    }
    else{
        _isShowLast = NO;
        [self.currentPriceView setViewWithIsShowLast:NO];
        
    }
    if (_currentPriceView) {
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:0.2 animations:^{
            [weakSelf addCurrentPriceWith:needDrawKLinePositionModels.lastObject kLineModel:weakSelf.kLineVolumeView.needDrawKLineModels.lastObject];
        }];
        
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self addCurrentPriceWith:needDrawKLinePositionModels.lastObject kLineModel:self.kLineVolumeView.needDrawKLineModels.lastObject];
        });
    }
    
    
    
    
    
    if (self.MainViewType != Y_StockChartcenterViewTypeKline) {
        return;
    }
    [self addMaxAndMinPriceLabelWithDrawLinePositionModels:needDrawKLinePositionModels drawLineModels:self.kLineVolumeView.needDrawKLineModels];
   
//    self.kLineAccessoryView.needDrawKLinePositionModels = needDrawKLinePositionModels;
}
- (void)kLineMainViewCurrentNeedDrawKLineColors:(NSArray *)kLineColors
{
    self.kLineVolumeView.kLineColors = kLineColors;
    if(self.targetLineStatus >= 103)
    {
           self.kLineVolumeView.targetLineStatus = self.targetLineStatus;
    }
    [self private_drawKLineVolumeView];
//    self.kLineAccessoryView.kLineColors = kLineColors;
    if(self.targetLineStatus < 103)
    {
//        self.kLineAccessoryView.targetLineStatus = self.targetLineStatus;
    }
    [self private_drawKLineAccessoryView];
}
- (void)kLineMainViewLongPressKLinePositionModel:(Y_KLinePositionModel *)kLinePositionModel kLineModel:(Y_KLineModel *)kLineModel
{
    //更新ma信息
    [self.kLineMAView maProfileWithModel:kLineModel];
    if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
        [self.tipView setViewWithModel:kLineModel lineType:self.MainViewType];
    }
    [self.timeView setCrossTimeWithPositionX:kLinePositionModel.OpenPoint.x - self.scrollView.contentOffset.x model:kLineModel];
    [self.priceView setCrossPrice:[kLineModel.Close stringValue] positionY:kLinePositionModel.ClosePoint.y];
//    [self.volumeMAView maProfileWithModel:kLineModel];
//    [self.accessoryMAView maProfileWithModel:kLineModel];
}
#pragma mark - UIScrollView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    static BOOL isNeedPostNotification = YES;
//    if(scrollView.contentOffset.x < scrollView.frame.size.width * 2)
//    {
//        if(isNeedPostNotification)
//        {
//            self.oldExactOffset = scrollView.contentSize.width - scrollView.contentOffset.x;
//            isNeedPostNotification = NO;
//        }
//    } else {
//        isNeedPostNotification = YES;
//    }
//    [self.kLineMainView parentDidScrollScrollView:scrollView];
//    //NSLog(Localized(@"这是  %f-----%f=====%f", nil),scrollView.contentSize.width,scrollView.contentOffset.x,self.kLineMainView.frame.size.width);
}

#pragma mark - 添加最大值最小值label
-(void)addMaxAndMinPriceLabelWithDrawLinePositionModels:(NSArray *)positionModels drawLineModels:(NSArray *)lineModels
{
    NSNumber *maxPrice = [lineModels.firstObject High];;
    NSNumber *minPirce = [lineModels.firstObject Low];
    
    NSInteger maxIndex = 0;
    NSInteger minIndex = 0;
    for (int i = 0; i < positionModels.count; i++) {
        Y_KLinePositionModel *positionModel = positionModels[i];
        Y_KLineModel *klineModel = lineModels[i];
        if ([klineModel.High doubleValue] > [maxPrice doubleValue]) {
            maxPrice = klineModel.High;
            maxIndex = i;
        }
        if ([klineModel.Low  doubleValue] < [minPirce doubleValue]) {
            minPirce = klineModel.Low;
            minIndex = i;
        }
    }
    
    
    Y_KLinePositionModel *maxPositionModel = positionModels[maxIndex];
    Y_KLinePositionModel *minPositionModel = positionModels[minIndex];
    
    [self addMaxAndMinPriceLabelWithMaxPrice:maxPrice maxPosition:maxPositionModel minPrice:minPirce minPosition:minPositionModel];
    
}

-(void)addMaxAndMinPriceLabelWithMaxPrice:(NSNumber *)maxPrice maxPosition:(Y_KLinePositionModel *)maxPositionModel minPrice:(NSNumber *)minPrice minPosition:(Y_KLinePositionModel *)minPositionModel
{
    if (nil == _maxPriceLabel) {
        _maxPriceLabel = [self createLabel];
        [self.scrollView addSubview:_maxPriceLabel];
    }
    
    if (nil == _minPriceLabel) {
        _minPriceLabel = [self createLabel];
        [self.scrollView addSubview:_minPriceLabel];
    }
    
    _maxPriceLabel.text = [NSString stringWithFormat:@"%.4f",[maxPrice doubleValue]];
    _minPriceLabel.text = [NSString stringWithFormat:@"%.4f",[minPrice doubleValue]];
    _maxPriceLabel.x = maxPositionModel.HighPoint.x;
    _maxPriceLabel.y = maxPositionModel.HighPoint.y;
    
    _minPriceLabel.x = minPositionModel.LowPoint.x;
    _minPriceLabel.y = minPositionModel.LowPoint.y;
    
    NSString *text;
    if (_maxPriceLabel.x - self.scrollView.contentOffset.x > (self.width - self.scrollView.x) / 2) {
        // 显示在左边
        text = [_maxPriceLabel.text stringByAppendingString:@"→"];
        CGSize size = [text boundingRectWithSize:CGSizeMake(1000, 10) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_maxPriceLabel.font} context:nil].size;
        _maxPriceLabel.width = size.width;
        _maxPriceLabel.x = _maxPriceLabel.x - _maxPriceLabel.width;
    }else{
        NSString *string = _maxPriceLabel.text;
        if (string.length == 0) {
            string = @"";
        }
        text = [@"←" stringByAppendingString:string];
        CGSize size = [text boundingRectWithSize:CGSizeMake(1000, 10) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_maxPriceLabel.font} context:nil].size;
        _maxPriceLabel.width = size.width;
    }
    
    _maxPriceLabel.text = text;
    
    
    if (_minPriceLabel.x - self.scrollView.contentOffset.x > (self.width - self.scrollView.x) / 2) {
        // 显示在左边
        text = [_minPriceLabel.text stringByAppendingString:@"→"];
        CGSize size = [text boundingRectWithSize:CGSizeMake(1000, 10) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_minPriceLabel.font} context:nil].size;
        _minPriceLabel.width = size.width;
        _minPriceLabel.x = _minPriceLabel.x - _minPriceLabel.width;
    }else{
        NSString *string = _minPriceLabel.text;
        if (string.length == 0) {
            string = @"";
        }
        text = [@"←" stringByAppendingString:string];        
        CGSize size = [text boundingRectWithSize:CGSizeMake(1000, 10) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_minPriceLabel.font} context:nil].size;
        _minPriceLabel.width = size.width;
    }
    
    _minPriceLabel.text = text;
    
}



-(UILabel *)createLabel
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 10)];
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


#pragma mark - 显示当前价线和label

-(void)addCurrentPriceWith:(Y_KLinePositionModel *)positionModel kLineModel:(Y_KLineModel *)klineModel
{
    if (nil == _currentPriceView) {
        _currentPriceView = [[Y_KCurrentPriceView alloc]initWithFrame:CGRectMake(_scrollView.x, 0, _scrollView.contentSize.width, 10)];
        _currentPriceView.clipsToBounds = NO;
        [self.scrollView addSubview:_currentPriceView];
        
    }
    _currentPriceView.hidden = NO;
    _currentPriceView.y = positionModel.ClosePoint.y + 2.5;
    _currentPriceView.width = positionModel.ClosePoint.x + 2.5;
    [_currentPriceView resetWith];
    [self.priceView setCurrentPrice:[klineModel.Close stringValue] positionY:positionModel.ClosePoint.y + 20];
    
    
}


#pragma mark - 加边框
-(void)addBorder
{
    UIColor *borderColor = [UIColor colorWithHexString:@"#2A323D"];
    
    self.scrollView.layer.borderColor = borderColor.CGColor;
    self.scrollView.layer.borderWidth = 0.5;
    
    UIView *view = [UIView new];
    view.backgroundColor = borderColor;
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scrollView);
        make.top.equalTo(self.kLineMainView.mas_bottom).offset(0.5);
        make.height.equalTo(@0.5);
    }];
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = borderColor;
    [self addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scrollView);
        make.top.equalTo(self.volumeView.mas_top);
        make.height.equalTo(@0.5);
    }];

}


- (void)dealloc
{
    [_kLineMainView removeAllObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
