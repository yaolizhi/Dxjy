//
//  VerificationString.h
//  SSKJ_MarketingProject
//
//  Created by 陈宇浩 on 2017/6/24.
//  Copyright © 2017年 SSKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerificationString : NSObject
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+(BOOL)isContainEnglishOrChineseOrNumberInString:(NSString*)string range:(NSRange)range;
+(BOOL)isContainEnglishOrNumberInString:(NSString*)string range:(NSRange)range;
+(BOOL)isChinessString:(NSString *)string;          // 是否是全汉字
+(BOOL)isAllNumberString:(NSString *)string;        // 是否是全数字
@end
