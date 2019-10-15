//
//  KlineView.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2018/7/9.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockDataModel.h"
#import "Y_StockChartView.h"

#import "Market_Chart_Detail_KLine_Model.h"
@interface KlineView : UIView

@property (nonatomic, strong)StockDataModel *stock;
@property (nonatomic, strong) Y_StockChartView *stockChartView;


//分时
-(void)setTimeLineViewWithData:(NSMutableArray<Market_Chart_Detail_KLine_Model *> *)data currentPrice:(NSString *)currentPrice;

//k先
-(void)setKlineViewWithData:(NSMutableArray<Market_Chart_Detail_KLine_Model *> *)array currentPrice:(NSString *)currentPrice  isDayData:(BOOL)isDayData;

//更新
-(void)updateGoodsInfoWithSocketDic:(Market_Chart_Detail_KLine_Model *)dic;

@end
