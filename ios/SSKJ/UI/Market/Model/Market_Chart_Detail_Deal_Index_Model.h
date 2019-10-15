//
//  Market_Chart_Detail_Deal_Index_Model.h
//  ZYW_MIT
//
//  Created by James on 2018/8/2.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Market_Chart_Detail_Deal_Model.h"

@interface Market_Chart_Detail_Deal_Index_Model : NSObject

@property(nonatomic,assign)NSInteger total;

@property(nonatomic,strong)NSMutableArray<Market_Chart_Detail_Deal_Model *> *list;



@end
