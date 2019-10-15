//
//  Market_Chart_Detail_Deal_Model.h
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Market_Chart_Detail_Deal_Model : NSObject

//成交时间
@property(nonatomic,copy)NSString *entrustSuccessTime;

//交易类型 1:买，2:卖
@property(nonatomic,copy)NSString *tradeType;

//卖出 成交价
@property(nonatomic,copy)NSString *sellPrice;

//买入价格
@property(nonatomic,copy)NSString *buyPrice;

//委手手数
@property(nonatomic,copy)NSString *entrustLot;


@property (nonatomic, strong) NSString *code;

@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSString *datetime;

@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *open;

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSString *timestamp;

@property (nonatomic, strong) NSString *volume;

@property (nonatomic, strong) NSString *xtype;

@property (nonatomic, assign) BOOL isNodata;

@property (nonatomic, strong) NSString *dt;

@property (nonatomic, strong) NSString *dc;

@property (nonatomic, strong) NSString *amount;

@property (nonatomic, strong) NSString *price;

@end
