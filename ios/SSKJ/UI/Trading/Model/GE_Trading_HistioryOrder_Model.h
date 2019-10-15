//
//  GE_Trading_HistioryOrder_Model.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GE_Trading_HistioryOrder_Model : NSObject

@property (nonatomic,copy) NSString * otype;//0 买入  1  卖出

@property (nonatomic,copy) NSString * pname;//股票名字

@property (nonatomic,copy) NSString * stockCode;//股票代码

@property (nonatomic,copy) NSString * nowPrice;//现价

@property (nonatomic,copy) NSString * billType;//0:市价 1：限价

@property (nonatomic,copy) NSString * buyBillType;//做空单:-1 ,做多单:1

@property (nonatomic,copy) NSString * buyprice;//成交价（委托价）

@property (nonatomic,copy) NSString * selltime;//平仓时间

@property (nonatomic,copy) NSString * addtime;//建仓时间

@property (nonatomic,copy) NSString * pc_type;//平仓类型 1手动平仓 2止盈平仓 3止损平仓 4系统强平

@property (nonatomic,copy) NSString * entrustCount;//委手

@property (nonatomic,copy) NSString * entrustSuccessCount;//委手

@property (nonatomic,copy) NSString * buynum;//手数

@property (nonatomic,copy) NSString * sellprice;//平仓价格

@property (nonatomic,copy) NSString * everyHandNum;//每手股数

@property (nonatomic,copy) NSString * profit;//卖出后的盈亏金额

@property (nonatomic,copy) NSString * sxfee;//手续费

@property (nonatomic,copy) NSString * totalprice;//买入本金，及保证金

@property (nonatomic,copy) NSString * dayfee;//过夜费添加

@property (nonatomic,copy) NSString * stopLossPrice;//止损价

@property (nonatomic,copy) NSString * stopProfitPrice;//止盈价


@end

NS_ASSUME_NONNULL_END
