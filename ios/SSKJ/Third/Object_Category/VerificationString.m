//
//  VerificationString.m
//  SSKJ_MarketingProject
//
//  Created by 陈宇浩 on 2017/6/24.
//  Copyright © 2017年 SSKJ. All rights reserved.
//

#import "VerificationString.h"

@implementation VerificationString

+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    NSRegularExpression* regex =[ NSRegularExpression regularExpressionWithPattern:@"^[0-9]*$" options:NSRegularExpressionAnchorsMatchLines error:nil];
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:mobileNum options:NSMatchingAnchored range:NSMakeRange(0, [mobileNum length])];
    if (numberOfMatches != 0)
    {
        if ([mobileNum hasPrefix:@"1"]&&mobileNum.length == 11) {
            return YES;
        } else {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

+(BOOL)isContainEnglishOrChineseOrNumberInString:(NSString*)string range:(NSRange)range {
    NSString *regex = [NSString stringWithFormat:@"^[a-zA-Z0-9\u4e00-\u9fa5]{%d,%d}$",range.location,range.length];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:string]) {
        return YES;
    }
    return NO;
}
+(BOOL)isContainEnglishOrNumberInString:(NSString*)string range:(NSRange)range{
    NSString *regex = [NSString stringWithFormat:@"^[A-Za-z0-9]{%d,%d}$",range.location,range.length];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:string]) {
        return YES;
    }
    return NO;
}

+(BOOL)isChinessString:(NSString *)string
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:string];
}

+(BOOL)isAllNumberString:(NSString *)string
{
    if (string.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:string];
}


    
@end
