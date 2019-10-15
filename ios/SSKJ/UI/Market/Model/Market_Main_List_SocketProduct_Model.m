//
//  Market_Main_List_SocketProduct_Model.m
//  ZYW_MIT
//
//  Created by James on 2018/8/1.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Main_List_SocketProduct_Model.h"

@implementation Market_Main_List_SocketProduct_Model
//-(NSString *)cnyPrice{
//    _cnyPrice = [NSString stringWithFormat:@"%.2f",floor(_cnyPrice.doubleValue*100)/100];
//    return _cnyPrice;
//}
//-(NSString *)price{
//    return [self fomatterNum:_price];
//}
//-(NSString *)high{
//    return [self fomatterNum:_high];
//}
//-(NSString *)low{
//    return [self fomatterNum:_low];
//}

-(void)setCode:(NSString *)code{
    _code = code;

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



-(NSString *)fomatterNum:(NSString *)num
{
    BOOL isUsdt = [self isUSDT:_code];
    //int count =isUsdt?4:8;
    //return [WLTools notRounding:num.doubleValue afterPoint:count];
    if(isUsdt)
    {
        return [NSString stringWithFormat:@"%.4f",num.doubleValue];
    }else{
        return [NSString stringWithFormat:@"%.8f",num.doubleValue];
    }
}
@end
