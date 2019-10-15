//
//  GE_Trading_goodsModel.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GE_Trading_goodsModel : NSObject

@property (nonatomic,assign) NSInteger ID;

@property (nonatomic,copy) NSString * volume;

@property (nonatomic,copy) NSString * closePrice;

@property (nonatomic,copy) NSString * changeRate;

@property (nonatomic,copy) NSString * high;

@property (nonatomic,copy) NSString * timestamp;

@property (nonatomic,copy) NSString * time;

@property (nonatomic,copy) NSString * openPrice;

@property (nonatomic,copy) NSString * change;

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * price;

@property (nonatomic,copy) NSString * low;

@property (nonatomic,copy) NSString * date;

@property (nonatomic,copy) NSString * createTime;

@property (nonatomic,copy) NSString * prevClose;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * status;

@end

NS_ASSUME_NONNULL_END
