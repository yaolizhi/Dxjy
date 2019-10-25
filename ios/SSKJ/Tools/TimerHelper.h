//
//  TimerHelper.h
//  Tiger
//
//  Created by 姚立志 on 2019/8/12.
//  Copyright © 2019 Tiger. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




typedef void (^backBolck) (BOOL sign);


@interface TimerHelper : NSObject

@property (nonatomic, strong) dispatch_source_t timer;


+ (TimerHelper *)sharedInstance;



#pragma mark 定时每秒回调一次
-(void)timerCountDownWithTimeInterval:(NSTimeInterval)timeInterval block:(backBolck)block;


#pragma mark 定时每秒回调一次
+(void)timerCountDownWithTimeInterval:(backBolck)block;




#pragma mark - 获取某个时间“NSDate”时间n月之前或者之后的时间戳

/**
 
 获取某个时间“NSDate”时间n月之前或者之后的时间戳

 @param date 某时间
 @param month n月之前或者之后
 @return 时间戳
 */
+(NSString *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;



#pragma mark - 返回时间戳
/**
 
 获取某个时间“NSDate”的时间戳
 
 @param date 某时间
 @return 时间戳
 */
+(NSString*)timeIntervalWithDate:(NSDate*)date;



-(void)dispatch_suspend;





@end

NS_ASSUME_NONNULL_END
