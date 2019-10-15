//
//  GE_Trading_OneStock_Model.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GE_Trading_OneStock_Model : NSObject

@property (nonatomic,copy) NSString * volume;

@property (nonatomic,copy) NSString * closePrice;

@property (nonatomic,copy) NSString * changeRate;

@property (nonatomic,copy) NSString * high;

@property (nonatomic,copy) NSString * timestamp;

@property (nonatomic,copy) NSString * openPrice;

@property (nonatomic,copy) NSString * change;

@property (nonatomic,copy) NSString * code;

//最新价
@property (nonatomic,copy) NSString * price;

@property (nonatomic,copy) NSString * low;

@property (nonatomic,copy) NSString * date;

@property (nonatomic,copy) NSString * createTime;

@property (nonatomic,copy) NSString * prevClose;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * status;

//手续费
@property (nonatomic,copy) NSString * dealFee;

@property (nonatomic,copy) NSString * floatMoney;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * contractMin;

@property (nonatomic,copy) NSString * engName;

@property (nonatomic,copy) NSString * shortSellingStatus;

@property (nonatomic,copy) NSString * topChoice;

@property (nonatomic,copy) NSString * spotSpread;

@property (nonatomic,copy) NSString * goingLongStatus;

@property (nonatomic,copy) NSString * contractMax;

//最小变动价
@property (nonatomic,copy) NSString * jggd;

@property (nonatomic,copy) NSString * sell;

@property (nonatomic,copy) NSString * nowCount;

@property (nonatomic,copy) NSString * stopProfit;

@property (nonatomic,copy) NSString * stopLoss;

@property (nonatomic,copy) NSString * mggs;

@property (nonatomic,copy) NSString * overNightFeeRate;

@property (nonatomic,copy) NSString * buy;

//保证金
@property (nonatomic,copy) NSString * cashDeposit;

@property (nonatomic,copy) NSString * leverage_rj;//融券杠杆

@property (nonatomic,copy) NSString * leverage_rz;//融资杠杆

@property (nonatomic,copy) NSString * shares;//每手多少股

@property (nonatomic,copy) NSString * num_min;//最小手数限制

@property (nonatomic,copy) NSString * trans_fee;//建仓平仓手续费  百分比 注意除以一百


@property (nonatomic,assign) NSInteger ID;
@end

NS_ASSUME_NONNULL_END
