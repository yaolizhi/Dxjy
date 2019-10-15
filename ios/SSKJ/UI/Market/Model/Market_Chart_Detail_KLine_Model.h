//
//  Market_Chart_Detail_KLine_Model.h
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Market_Chart_Detail_KLine_Model : NSObject

@property(nonatomic,copy)NSString *ID;

@property(nonatomic,copy)NSString *code;

@property(nonatomic,copy)NSString *period;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *pid;

//成交量
@property(nonatomic,copy)NSString *volume;

@property(nonatomic,copy)NSString *price;

//开盘价
@property(nonatomic,copy)NSString *openPrice;

//闭盘价
@property(nonatomic,copy)NSString *closePrice;

@property(nonatomic,copy)NSString *prevClose;

//高
@property(nonatomic,copy)NSString *high;

//低
@property(nonatomic,copy)NSString *low;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,copy)NSString *dateTime;

@property(nonatomic,copy)NSString *createTime;

@property(nonatomic,copy)NSString *isDeleted;

@property(nonatomic,copy)NSString *timestamp;





@end
