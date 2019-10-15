//
//  TipView.h
//  BTC-Kline
//
//  Created by 刘小雨 on 2018/7/19.
//  Copyright © 2018年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Y_KLineModel.h"
#import "Y_StockChartConstant.h"
@interface TipView : UIView
/**
 *  K线类型
 */
@property (nonatomic, assign) Y_StockChartCenterViewType MainViewType;

-(void)setViewWithModel:(Y_KLineModel *)mdoel lineType:(Y_StockChartCenterViewType)lineType;
@end
