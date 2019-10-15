//
//  Market_Chart_Detail_KLine_Cell.h
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LXY_KLineView.h"

#import "Market_Chart_Detail_KLine_Model.h"

@interface Market_Chart_Detail_KLine_Cell : UITableViewCell

@property(nonatomic,strong)LXY_KLineView *klineView;

@property(nonatomic,copy)void (^itemBlock)(NSInteger type);

-(void)initWithCellArray:(NSMutableArray<Market_Chart_Detail_KLine_Model *> *)kLineArray andCurrentPrice:(NSString *)currentPrice andKtype:(NSString *)ktype andIsTime:(LXY_KLINETYPE)isTime;



@end
