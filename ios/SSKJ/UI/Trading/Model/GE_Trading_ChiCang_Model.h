//
//  GE_Trading_ChiCang_Model.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GE_Trading_ChiCang_Model : NSObject


@property (nonatomic,copy) NSString * otype;//1 融资  2  融券(持仓使用)

@property (nonatomic,copy) NSString * pname;//股票名字

@property (nonatomic,copy) NSString * code;//股票代码

@property (nonatomic,copy) NSString * newprice;//现价

@property (nonatomic,copy) NSString * fdyk;//浮动盈亏数据

@property (nonatomic,copy) NSString * deposit;//浮动盈亏比例

@property (nonatomic,copy) NSString * occupyDeposit;//占用 保证金

@property (nonatomic,copy) NSString * dayfee;//持仓过夜费

@property (nonatomic,copy) NSString * countFee;//持仓手续费

@property (nonatomic,copy) NSString * addtime;//创建时间

@property (nonatomic,copy) NSString * buynum;//购买数量（手数）

@property (nonatomic,copy) NSString * haveHandNum;//持仓手数

@property (nonatomic,copy) NSString * stopLossPrice;//止损价

@property (nonatomic,copy) NSString * stopProfitPrice;//止盈价

@property (nonatomic,copy) NSString * hold_no;//持仓单号

@property (nonatomic,copy) NSString * countCost;//买入价（持仓价）

@property (nonatomic,copy) NSString * countUsable;//可用

@property (nonatomic,copy) NSString * sxfee;//手续费

@property (nonatomic,copy) NSString * totalprice;//保证金

@property (nonatomic,copy) NSString * buyprice;//成交价

@property (nonatomic,copy) NSString * entrustCount;//委手

@property (nonatomic,copy) NSString * leverage;//杠杆

@property (nonatomic,copy) NSString * pid;//

@property (nonatomic,copy) NSString * hold_id;

@property (nonatomic,copy) NSString *buyBillType;//做空单，做多单状态 做空单:-1 ,做多单:1(挂单使用)

@end

NS_ASSUME_NONNULL_END
