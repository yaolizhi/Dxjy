//
//  GE_Trading_ChiCang_Model.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Trading_ChiCang_Model.h"

@implementation GE_Trading_ChiCang_Model
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID": @"id",
             @"nowPrice":@"newPrice"
             };
}
@end
