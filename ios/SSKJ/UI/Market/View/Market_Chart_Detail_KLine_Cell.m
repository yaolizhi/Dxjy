//
//  Market_Chart_Detail_KLine_Cell.m
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Chart_Detail_KLine_Cell.h"

#import "Market_Chart_Detail_KLine_Top_View.h"

#import "MenuScrollView.h"

#import "AccessaryTypeView.h"

@interface Market_Chart_Detail_KLine_Cell()

@property(nonatomic,strong)Market_Chart_Detail_KLine_Top_View *topView;

@property(nonatomic,strong)NSMutableArray<Market_Chart_Detail_KLine_Model *> *kLineArray;

//分时、k线操作
@property(nonatomic, strong)MenuScrollView *headerMenuView;

@property (nonatomic, strong) AccessaryTypeView *accessaryTypeView;

@property (nonatomic, assign) LXY_KMAINACCESSORYTYPE mainAccessoryType;

@property (nonatomic, assign) LXY_ACCESSORYTYPE accessoryType;

@end

@implementation Market_Chart_Detail_KLine_Cell

#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle=UITableViewCellAccessoryNone;
        
        self.contentView.backgroundColor=[WLTools stringToColor:@"#ffffff"];
        
        self.mainAccessoryType = LXY_KMAINACCESSORYTYPEMA;
        
        self.accessoryType = LXY_ACCESSORYTYPENONE;
        
        [self createUI];
    }
    
    return self;
}

#pragma mark - 创建UI
-(void)createUI
{
    [self.contentView addSubview:[self headerMenuView]];
    
    [self.contentView addSubview:[self klineView]];
//    [self klineView];
}

- (MenuScrollView*)headerMenuView
{
    if (!_headerMenuView)
    {
        CGRect frame = CGRectMake(0
                                  , 0
                                  , ScreenWidth
                                  , ScaleH(30));
        NSArray *titles = @[SSKJLocalized(@"分时", nil),@"5M",@"30M",@"1H",SSKJLocalized(@"日线", nil),SSKJLocalized(@"指标", nil)];
        NSDictionary *attributes = @{@"title":titles};
        _headerMenuView = [[MenuScrollView alloc]initWithFrame:frame attributes:attributes dataScrollView:nil];
        _headerMenuView.backgroundColor = kMainWihteColor;
        _headerMenuView.selectIndex = 0;
        _headerMenuView.tag = 100;
        _headerMenuView.showBottomLine = YES;
        [_headerMenuView setBottomLineColor:kMainColor];
        _headerMenuView.menuScrollDelegate = (id<MenuScrollViewDelegate>)self;
        _headerMenuView.showVerticalLine = NO;
        _headerMenuView.tabSelectedTitleColor  = kMainColor;
        _headerMenuView.tabTitleColor = UIColorFromRGB(0xbbbbbb);
        WS(weakSelf);
        _headerMenuView.klineAccessoryBlock = ^{
            if (weakSelf.accessaryTypeView.superview == nil) {
                [weakSelf.contentView addSubview:weakSelf.accessaryTypeView];
            }else{
                [weakSelf.accessaryTypeView removeFromSuperview];
            }
        };
    }
    return _headerMenuView;
}

-(AccessaryTypeView *)accessaryTypeView
{
    if (nil == _accessaryTypeView) {
        _accessaryTypeView = [[AccessaryTypeView alloc]initWithFrame:CGRectMake(0, self.headerMenuView.bottom, ScreenWidth, self.contentView.height - self.headerMenuView.bottom)];
        WS(weakSelf);
        _accessaryTypeView.mainAccessaryTypeBlock = ^(LXY_KMAINACCESSORYTYPE type) {
            weakSelf.klineView.mainAccessoryType = type;
            [weakSelf.accessaryTypeView removeFromSuperview];
        };
        
        _accessaryTypeView.accessaryTypeBlock = ^(LXY_ACCESSORYTYPE type) {
            weakSelf.klineView.accessoryType = type;
            [weakSelf.accessaryTypeView removeFromSuperview];
            
        };
    }
    return _accessaryTypeView;
}



#pragma mark --MenuScrollViewDelegate
- (void)menuScrollView:(MenuScrollView*)menuScrollView didSelectedMenuItemAtIndex:(NSInteger)index
{
    [self item_Button_Event:index];
}


#pragma mark - 点击
-(void)item_Button_Event:(NSInteger)type
{
    if (self.itemBlock)
    {
        self.itemBlock(type);
    }
}

-(LXY_KLineView *)klineView
{
    if (nil == _klineView) {
        _klineView = [[LXY_KLineView alloc]initWithFrame:CGRectMake(0
                                                                    ,ScaleH(30)
                                                                    , ScreenWidth
                                                                    , ScaleH(400) - ScaleH(30)) accessoryType:self.accessoryType mainAccessoryType:self.mainAccessoryType];
        
    }
    return _klineView;
}


-(void)initWithCellArray:(NSMutableArray<Market_Chart_Detail_KLine_Model *> *)kLineArray andCurrentPrice:(NSString *)currentPrice andKtype:(NSString *)ktype andIsTime:(LXY_KLINETYPE)isTime;
{
    self.kLineArray=kLineArray;
    
    NSString *timeFormate = @"HH:mm";
    NSInteger index = 0;
    if ([ktype isEqualToString:@"minute5"]){
        index = 1;
    }else if ([ktype isEqualToString:@"minute15"]){
        index = 2;
    }else if ([ktype isEqualToString:@"minute30"]){
        index = 3;
    }else if ([ktype isEqualToString:@"minute60"]){
        index = 4;
    }else if ([ktype isEqualToString:@"day"]){
        timeFormate = @"MM-dd HH:mm";
        index = 5;
    }
    
    [self.klineView setData:self.kLineArray klineType:isTime timeFormatter:timeFormate];
    
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
