//
//  VerificationPhoneNumber.h
//  BG-Clound
//
//  Created by apple on 14-10-24.
//  Copyright (c) 2014年 zd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerificationPhoneNumber : NSObject
//验证手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
@end
