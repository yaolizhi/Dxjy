//
//  KLine_TimeView.h
//  BTC-Kline
//
//  Created by 刘小雨 on 2018/7/19.
//  Copyright © 2018年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Y_KLineModel.h"
@interface KLine_TimeView : UIView
-(void)setViewWithArray:(NSArray *)kLineModels;

-(void)setCrossTimeWithPositionX:(CGFloat)positionX model:(Y_KLineModel *)model;

-(void)hiddenCrossLabel;

@end
