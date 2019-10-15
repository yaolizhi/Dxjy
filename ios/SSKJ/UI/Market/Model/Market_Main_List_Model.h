//
//  Market_Main_List_Model.h
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Market_Main_List_T_Model.h"

#import "Market_Main_List_SocketProduct_Model.h"

@interface Market_Main_List_Model : NSObject

//股票类型 1:A股 2:港股 3:美股 4:商品 5:期货 注：区块链项目用商品4
@property(nonatomic,copy)NSString *type;

//名称
@property(nonatomic,copy)NSString *name;

//代码
@property(nonatomic,copy)NSString *code;

//最小浮动价格
@property(nonatomic,copy)NSString *slidingScalePrice;

//点位波动差值 默认1美元
@property(nonatomic,copy)NSString *floatMoney;

//币种类型(1-以太坊;2-比特币)
@property(nonatomic,copy)NSString *coinType;

//1:默认 2:自选
@property(nonatomic,copy)NSString *coinOutType;


//做多状态：0:允许 false 1:禁止 true
@property(nonatomic,copy)NSString *goingLongStatus;

//做空状态：0:允许false 1:禁止true
@property(nonatomic,copy)NSString *shortSellingStatus;

//上架下架状态 0:正常上架 1:下架
@property(nonatomic,copy)NSString *upDownStatus;


//发行日期stockProductVO
@property(nonatomic,copy)NSString *publishTime;

//发行数量
@property(nonatomic,copy)NSString *publishNum;

//发行单价
@property(nonatomic,copy)NSString *publishPrice;

//发行网站
@property(nonatomic,copy)NSString *publishWeb;

//白皮书
@property(nonatomic,copy)NSString *whitePaper;

//简介
@property(nonatomic,copy)NSString *remark;

@property(nonatomic,strong)Market_Main_List_SocketProduct_Model *stockProductVO;

@property(nonatomic,copy)NSString *buy;

@property(nonatomic,strong)NSMutableArray<Market_Main_List_T_Model *> *buyT5;

@property(nonatomic,copy)NSString *buyTotalSize;

@property(nonatomic,copy)NSString *change;

@property(nonatomic,copy)NSString *changeRate;//涨跌幅

@property(nonatomic,copy)NSString *changePercentage;

@property(nonatomic,copy)NSString *closePrice;



@property(nonatomic,copy)NSString *date;

@property(nonatomic,copy)NSString *high;

@property(nonatomic,copy)NSString *low;



@property(nonatomic,copy)NSString *openPrice;

@property(nonatomic,copy)NSString *price;

@property(nonatomic,copy)NSString *sell;

@property(nonatomic,strong)NSMutableArray<Market_Main_List_T_Model *> *sellT5;

@property(nonatomic,copy)NSString *sellTotalSize;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *volume;

@property(nonatomic,copy)NSString *buyMin; //币币最小购买数

//止损点位
@property(nonatomic,copy)NSString *stopProfit;

@property(nonatomic,copy)NSString *stopLoss;

@property (nonatomic, copy)NSString  *minStopProfit;

@property (nonatomic, copy) NSString *minStopLoss;

@property(nonatomic,copy)NSString *lever; //杠杆

@property(nonatomic,copy)NSString *dealFee; //手续费

@property(nonatomic,copy)NSString *spread; //点差

@property(nonatomic,copy)NSString *contractMin; //合约最小购买数

@property (nonatomic, copy) NSString *coinImg;

@property (nonatomic, strong) NSString *index;
@end
