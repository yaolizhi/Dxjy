//
//  Market_Chart_Detail_Deal_Model.m
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Chart_Detail_Deal_Model.h"

@implementation Market_Chart_Detail_Deal_Model
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(BOOL)isUSDT:(NSString *)code
{
    if ([code containsString:@"/"]) {
        NSArray *array = [code componentsSeparatedByString:@"/"];
        NSString *unit =  array[1];
        BOOL isUsdt = [unit isEqualToString:@"USDT"];
        return isUsdt;
    }
    return NO;
}

-(NSString *)open{
    return [self fomatterNum:_open];
}

-(NSString *)fomatterNum:(NSString *)num
{
    BOOL isUsdt = [self isUSDT:_code];
    int count =isUsdt?4:8;
    return [WLTools notRounding:num.doubleValue afterPoint:count];
}
@end
