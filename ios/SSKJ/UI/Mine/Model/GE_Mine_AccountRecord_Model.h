//
//  GE_Mine_AccountRecord_Model.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GE_Mine_AccountRecord_Model : NSObject

@property (nonatomic,copy) NSString * usableFund;//账户余额（信用资金）

@property (nonatomic,copy) NSString * allFund;//总资产

@property (nonatomic,copy) NSString * floatFee;//浮动盈亏数据

@property (nonatomic,copy) NSString * markValue;//总市值

@property (nonatomic,copy) NSString * usdFee;//总手续费

@property (nonatomic,copy) NSString * outFee;//总出金

@property (nonatomic,copy) NSString * proportion;//风险度

@property (nonatomic,copy) NSString * frostDeposit;//冻结保证金

@property (nonatomic,copy) NSString * isCanUseFund;//账户可用资金

@property (nonatomic,copy) NSString * hasUsedFund;//账户已用资金

@property (nonatomic,copy) NSString * cardNo;//银行卡号

@property (nonatomic,copy) NSString * cardType;//银行卡类型

@end

NS_ASSUME_NONNULL_END
