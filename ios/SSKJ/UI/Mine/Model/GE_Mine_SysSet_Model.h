//
//  GE_Mine_SysSet_Model.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GE_Mine_SysSet_Model : NSObject

@property (nonatomic,copy) NSString * maxOutCharge;//最大出金

@property (nonatomic,copy) NSString * minInCharge;//最小入金

@property (nonatomic,copy) NSString * inRate;//入金汇率（美元转人民币）

@property (nonatomic,copy) NSString * outRate;//出金汇率（美元转人民币

@property (nonatomic,copy) NSString * usdFee;//总手续费

@property (nonatomic,copy) NSString * closeOutRate;//强平比例




@end

NS_ASSUME_NONNULL_END
