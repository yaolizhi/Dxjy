//
//  KlineView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2018/7/9.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "KlineView.h"
#import "WLTools.h"
//#import <SDAutoLayout.h>
#import "Masonry.h"
#import "UIColor+Hex.h"
//#import "ManagerGlobeUntil.h"
#import "Y_StockChartView.h"
#import "Y_KLineGroupModel.h"
#import "Y_KCurrentPriceView.h"
@interface KlineView()
{
    NSMutableArray<Market_Chart_Detail_KLine_Model *> *_savedDic;
    NSString *_currentPrice;
    BOOL _isDay;
}

@property (nonatomic, strong) Y_KLineGroupModel *groupModel;
@property (nonatomic, strong) NSMutableDictionary *modelsDict;

@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation KlineView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = UIColorFromRGB(0x131f30);
        [self addSubview:self.stockChartView];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(movetolast) name:@"movetolast" object:nil];
    }
    return self;
}

#pragma mark - UI

- (Y_StockChartView *)stockChartView
{
    if(!_stockChartView) {
        _stockChartView = [Y_StockChartView new];
        _stockChartView.itemModels = @[
                                       [Y_StockChartViewItemModel itemModelWithTitle:SSKJLocalized(@"指标", nil) type:Y_StockChartcenterViewTypeOther],
                                       [Y_StockChartViewItemModel itemModelWithTitle:SSKJLocalized(@"分时", nil) type:Y_StockChartcenterViewTypeTimeLine],
                                       [Y_StockChartViewItemModel itemModelWithTitle:SSKJLocalized(@"1分", nil) type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:SSKJLocalized(@"5分", nil) type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:SSKJLocalized(@"30分", nil) type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:SSKJLocalized(@"60分", nil) type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:SSKJLocalized(@"日线", nil) type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:SSKJLocalized(@"周线", nil) type:Y_StockChartcenterViewTypeKline],
                                       
                                       ];
//        _stockChartView.backgroundColor = [UIColor orangeColor];
        _stockChartView.dataSource = self;
        [self addSubview:_stockChartView];
        [_stockChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (iPhoneX) {
                //                make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 30, 0, 0));
                make.left.equalTo(@0);
                make.top.equalTo(@0);
                make.right.equalTo(@0);
                make.bottom.equalTo(self);
            } else {
                make.left.equalTo(@0);
                make.top.equalTo(@0);
                make.right.equalTo(self.mas_right);
                make.height.equalTo(self);
            }
            
            
        }];
    }
    return _stockChartView;
}

- (NSMutableDictionary<NSString *,Y_KLineGroupModel *> *)modelsDict
{
    if (!_modelsDict) {
        _modelsDict = @{}.mutableCopy;
    }
    return _modelsDict;
}


//分时
-(void)setTimeLineViewWithData:(NSMutableArray<Market_Chart_Detail_KLine_Model *> *)data currentPrice:(NSString *)currentPrice
{
    
    
    if (!self.stockChartView.kLineView.isShowLast)
    {
        _savedDic = data;
        _currentPrice = currentPrice;
        _isDay = NO;
        return;
    }
    
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:10];
    
    for (int i = 0; i < (data.count > 500 ? 500 : data.count); i++)
    {
        if (i == 0) //更新第一条数据
        {
            Market_Chart_Detail_KLine_Model *firstModel=data[i];
            
            firstModel.closePrice=currentPrice;
        }
        
        [newArray addObject:data[i]];
    }
    
    
//    NSMutableArray *newArray = [NSMutableArray arrayWithArray:data];
//
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:data.firstObject];
    
    Market_Chart_Detail_KLine_Model *firstModel=data[0];
    
    
    firstModel.closePrice=currentPrice;
    
    
    
//    [dic setObject:currentPrice forKey:@"closingPrice"];
//
//    [newArray replaceObjectAtIndex:0 withObject:dic];
//
    
    
    
    WS(weakSelf);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        weakSelf.stockChartView.type = 1;
        NSMutableArray *array = [self handleWithData:newArray isDayData:NO];
        Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:array];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.dataSource = groupModel.models;
            weakSelf.groupModel = groupModel;
            [weakSelf.modelsDict setObject:groupModel forKey:@"30min"];
           
            [weakSelf.stockChartView reloadData];
        });
    });
    _savedDic = nil;


}

-(NSString *)dateFromTimeInterval:(NSString *)timerInterval
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timerInterval doubleValue]];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

-(NSString *)dateFromTimeInterval1:(NSString *)timerInterval
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timerInterval doubleValue]];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

//数据格式转换
-(NSMutableArray *)handleWithData:(NSMutableArray<Market_Chart_Detail_KLine_Model *> *)data isDayData:(BOOL)isDayData
{
    NSMutableArray *array = [@[] mutableCopy];
    for (Market_Chart_Detail_KLine_Model *dic in data)
    {
        NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:10];
        //日线
        if (isDayData)
        {
            
            NSString *date = [WLTools convertTimestamp:[dic.date doubleValue] andFormat:@"MM-dd"];
            
            [newArray addObject:date];
        }
        else
        {
            
            NSString *time =[WLTools convertTimestamp:[dic.date doubleValue] andFormat:@"yyyy-MM-dd HH:mm"];

            if (self.stockChartView.type == 4) //k线
            {
                time = [WLTools convertTimestamp:[dic.date doubleValue] andFormat:@"HH:mm"]; //显示 时分
            }
            else
            {
//                if (![time isEqual:[NSNull null]] && time.length > 5)
//                {
//                    time = [time substringToIndex:5];
//                }
            }
            
            [newArray addObject:time];
        }
        
        NSString *open =dic.openPrice;
        if ([open isEqual:[NSNull null]] || open.length == 0)
        {
            open = @"0";
        }
        [newArray addObject:open];
        
        NSString *high = dic.high;
        if ([high isEqual:[NSNull null]] || high.length == 0)
        {
            high = @"0";
        }
        [newArray addObject:high];
        
        NSString *low = dic.low;
        if ([low isEqual:[NSNull null]] || low.length == 0)
        {
            low = @"0";
        }
        [newArray addObject:low];
        
        NSString *close = dic.closePrice;
        if ([close isEqual:[NSNull null]] || close.length == 0)
        {
            close = @"0";
        }
        [newArray addObject:close];
        
        NSString *volume = dic.volume;
        if ([volume isEqual:[NSNull null]] || volume.length == 0)
        {
            volume = @"0";
        }
        [newArray addObject:volume];
        [array insertObject:newArray atIndex:0];
    }
    return array;
    
}
-(id)stockDatasWithIndex:(NSInteger)index
{
    return self.dataSource;
}

//k线
-(void)setKlineViewWithData:(NSMutableArray<Market_Chart_Detail_KLine_Model *> *)data currentPrice:(NSString *)currentPrice isDayData:(BOOL)isDayData
{
    // 记录数据，下次滑动到最右边时用记录下来的数据重新绘图
    if (!self.stockChartView.kLineView.isShowLast)
    {
        _savedDic = data;
        _currentPrice = currentPrice;
        _isDay = isDayData;
        return;
    }
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:10];
    
    for (int i = 0; i < (data.count > 500 ? 500 : data.count); i++)
    {
        if (i == 0) //更新第一条数据
        {
            Market_Chart_Detail_KLine_Model *firstModel=data[i];
            
            firstModel.closePrice=currentPrice;
        }
 
        [newArray addObject:data[i]];
    }
    
    
    
    WS(weakSelf);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        weakSelf.stockChartView.type = 4;
        NSMutableArray *array = [weakSelf handleWithData:newArray isDayData:isDayData];
        Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:array];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.dataSource = groupModel.models;
            weakSelf.groupModel = groupModel;
            [weakSelf.modelsDict setObject:groupModel forKey:@"30min"];
            //SsLog(@"%@",groupModel);
            [weakSelf.stockChartView reloadData];
        });
    });
    
    
    _savedDic = nil;

}


-(void)updateGoodsInfoWithSocketDic:(NSDictionary *)dic
{
    Y_KLineModel *model = self.dataSource.lastObject;

    
    float close = [dic[@"price"] floatValue];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.roundingMode = NSNumberFormatterRoundFloor;
    formatter.maximumFractionDigits = 4;
    
    NSString *price = dic[@"price"];
    if ([price isEqual:[NSNull null]] || price.length == 0)
    {
        price = @"0";
    }
    _currentPrice = price;
    NSNumber *closeNumber = [formatter numberFromString:price];
    

    if (close < [model.Low floatValue])
    {
        model.Low = closeNumber;
    }
    if (close > [model.High floatValue])
    {
        model.High = closeNumber;
    }
    model.Close = closeNumber;
    if (self.stockChartView.kLineView.isShowLast)
    {
        [self.stockChartView reloadData];
    }
}

-(void)movetolast
{
    if (_savedDic.count>0)
    {
        if (self.stockChartView.type == 4) //k线
        {
            [self setKlineViewWithData:_savedDic currentPrice:_currentPrice isDayData:_isDay];
        }
        else
        {
            [self setTimeLineViewWithData:_savedDic currentPrice:_currentPrice];
        }
        
        _savedDic = nil;
        
        self.stockChartView.kLineView.isShowLast = YES;
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"movetolast" object:nil];
}


@end
