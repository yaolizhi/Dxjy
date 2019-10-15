//
//  GE_Market_Notice_Model.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/26.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GE_Market_Notice_Model : NSObject

@property(nonatomic,copy)NSString *ID;

@property(nonatomic,copy)NSString *userId;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *isDeleted;

@property(nonatomic,copy)NSString *startDate;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *endDate;

@property(nonatomic,copy)NSString *create_time;

@property(nonatomic,copy)NSString *time;

@end

NS_ASSUME_NONNULL_END
