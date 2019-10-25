//
//  TimerHelper.m
//  Tiger
//
//  Created by 姚立志 on 2019/8/12.
//  Copyright © 2019 Tiger. All rights reserved.
//

#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#import "TimerHelper.h"

@implementation TimerHelper

static TimerHelper *timerHelper = nil;

+ (TimerHelper *)sharedInstance
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timerHelper = [[TimerHelper alloc] init];
    });
    return timerHelper;
}



#pragma mark 定时每秒回调一次
-(void)timerCountDownWithTimeInterval:(NSTimeInterval)timeInterval block:(backBolck)block
{
    /** 创建定时器对象
     * para1: DISPATCH_SOURCE_TYPE_TIMER 为定时器类型
     * para2-3: 中间两个参数对定时器无用
     * para4: 最后为在什么调度队列中使用
     */
    /** 设置定时器
     * para2: 任务开始时间
     * para3: 任务的间隔
     * para4: 可接受的误差时间，设置0即不允许出现误差
     * Tips: 单位均为纳秒
     */
    dispatch_source_set_timer(timerHelper.timer, DISPATCH_TIME_NOW, timeInterval * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    /** 设置定时器任务
     * 可以通过block方式
     * 也可以通过C函数方式
     */
    dispatch_source_set_event_handler(timerHelper.timer, ^{
        
        MAIN(^{
            
            
            BOOL stop = NO;
            
            NSLog(@"当前线程%@", [NSThread currentThread]);
            
            if(stop)
            {
                // 终止定时器 (必须写停止定制器，否则定时器就不执行)
                dispatch_suspend(timerHelper.timer);
            }
            
            block(YES);
            
            
            
        });
        
    });
    // 启动任务，GCD计时器创建后需要手动启动
    dispatch_resume(timerHelper.timer);
}



#pragma mark 定时每秒回调一次
+(void)timerCountDownWithTimeInterval:(backBolck)block
{
    /** 创建定时器对象
     * para1: DISPATCH_SOURCE_TYPE_TIMER 为定时器类型
     * para2-3: 中间两个参数对定时器无用
     * para4: 最后为在什么调度队列中使用
     */
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    /** 设置定时器
     * para2: 任务开始时间
     * para3: 任务的间隔
     * para4: 可接受的误差时间，设置0即不允许出现误差
     * Tips: 单位均为纳秒
     */
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    /** 设置定时器任务
     * 可以通过block方式
     * 也可以通过C函数方式
     */
    WS(weakSelf);
    dispatch_source_set_event_handler(timer, ^{
    
        
        MAIN(^{
           
            
            BOOL stop = NO;
            
            NSLog(@"当前线程%@", [NSThread currentThread]);
            
            if(stop)
            {
                // 终止定时器 (必须写停止定制器，否则定时器就不执行)
                dispatch_suspend(timer);
            }
            
            block(YES);
            
            
        });
        
      
        
    });
    // 启动任务，GCD计时器创建后需要手动启动
    dispatch_resume(timer);
}


+(NSString *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month
{
    
  NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:2011];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:NSCalendarWrapComponents];
    NSDate *mDate = [calender dateFromComponents:comps];
    
    NSString *timeInterval = [TimerHelper timeIntervalWithDate:mDate];
    return timeInterval;
}

+(NSString*)timeIntervalWithDate:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([date timeIntervalSince1970])];
    return timeSp;
}

#pragma mark - 暂停定时器
-(void)dispatch_suspend
{
    dispatch_suspend(timerHelper.timer);
}


-(dispatch_source_t)timer
{
    if (!_timer)
    {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    }
    return _timer;
    
}






@end
