//
//  NSString+Helper.m
//  02.用户登录&注册
//
//  Created by 刘凡 on 13-11-28.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "NSString+Helper.h"
@implementation NSString (Helper)
/**
 *将对象转成json
 */
+(NSString *)JsonStringForObject:(id)object{
    if (!object) {
        return nil;
    }
    NSData *dataStr = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    NSString *st = [[NSString alloc]initWithData:dataStr encoding:NSUTF8StringEncoding];
    return st;
}
+(NSString*)TimeformatFromSeconds:(NSInteger)seconds
{
    if (seconds<=0) {
        return @"00:00:00";
    }
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",(long)(seconds/3600)];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(long)((seconds%3600)/60)];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",(long)(seconds%60)];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    if ([str_hour integerValue]>24) {
        
        format_time = [NSString stringWithFormat:@"%@天%02ld:%@:%@", [NSNumber numberWithInteger:[str_hour integerValue] /24],(long)([str_hour integerValue]%24),str_minute,str_second];
    }
    
    return format_time;
}
-(NSString *)EmptyStringByWhitespace{
    NSString *str=@"";
    if (self && self.length>0) {
        str=[self stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
        str=[str stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    }
    return str;
}
#pragma mark - Get请求转换
-(NSString *)getRequestString{
    if ([self isEmptyString]){
        return [@"" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    }
    
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    //[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}
#pragma mark 清空字符串中的空白字符
- (NSString *)trimString
{
    NSString *trim=[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [trim stringByReplacingOccurrencesOfString:@" " withString:@""];
}
- (NSString *)trimParagraphString
{
    NSString *trim=[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trim ;
}
#pragma mark 段前空两格
-(NSString *)emptyBeforeParagraph
{
    NSString *content=[NSString stringWithFormat:@"\t%@",self];
    content=[content stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    return [content stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
}
#pragma mark 是否空字符串
- (BOOL)isEmptyString
{
    return ( self == nil || self.length<1 || [self trimString].length<1 || [self EmptyStringByWhitespace].length <1);
}

#pragma mark 返回沙盒中的文件路径
- (NSString *)documentsPath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingString:self];
}

#pragma mark 写入系统偏好
- (void)saveToNSDefaultsWithKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:self forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark 读出系统偏好
+ (NSString *)readToNSDefaultsWithKey:(NSString *)key
{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
#pragma mark 邮箱验证 MODIFIED BY HELENSONG
-(BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
#pragma mark  银行账号判断
-(BOOL)isValidateBank
{
    NSString *bankNo=@"^\\d{16}|\\d{19}+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNo];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:self];
}
#pragma mark 手机号码验证 MODIFIED BY HELENSONG
-(BOOL) isValidateMobile
{
    if ([self isEmptyString]) {
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}
#pragma mark- 判断是否是手机号或固话
-(BOOL) isValidateMobileAndTel{
    if ([self isEmptyString]) {
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((\\d{7,8})|(0\\d{2,3}\\d{7,8})|(1\\d{10}))$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}
#pragma mark-  判断是否是手机号或固话或400
-(BOOL) isValidateMobileAndTelAnd400{
    if ([self isEmptyString]) {
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((\\d{7,8})|(0\\d{2,3}\\d{7,8})|(1\\d{10})|(400\\d{7}))$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}
#pragma mark 身份证号
-(BOOL) isValidateIdentityCard
{
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL length= [identityCardPredicate evaluateWithObject:self];
    if (!length) {
        return length;
    }
    NSArray *pArr = @[
                      
                      @"11",//北京市|110000，
                      
                      @"12",//天津市|120000，
                      
                      @"13",//河北省|130000，
                      
                      @"14",//山西省|140000，
                      
                      @"15",//内蒙古自治区|150000，
                      
                      @"21",//辽宁省|210000，
                      
                      @"22",//吉林省|220000，
                      
                      @"23",//黑龙江省|230000，
                      
                      @"31",//上海市|310000，
                      
                      @"32",//江苏省|320000，
                      
                      @"33",//浙江省|330000，
                      
                      @"34",//安徽省|340000，
                      
                      @"35",//福建省|350000，
                      
                      @"36",//江西省|360000，
                      
                      @"37",//山东省|370000，
                      
                      @"41",//河南省|410000，
                      
                      @"42",//湖北省|420000，
                      
                      @"43",//湖南省|430000，
                      
                      @"44",//广东省|440000，
                      
                      @"45",//广西壮族自治区|450000，
                      
                      @"46",//海南省|460000，
                      
                      @"50",//重庆市|500000，
                      
                      @"51",//四川省|510000，
                      
                      @"52",//贵州省|520000，
                      
                      @"53",//云南省|530000，
                      
                      @"54",//西藏自治区|540000，
                      
                      @"61",//陕西省|610000，
                      
                      @"62",//甘肃省|620000，
                      
                      @"63",//青海省|630000，
                      
                      @"64",//宁夏回族自治区|640000，
                      
                      @"65",//新疆维吾尔自治区|650000，
                      
                      @"71",//台湾省（886)|710000,
                      
                      @"81",//香港特别行政区（852)|810000，
                      
                      @"82",//澳门特别行政区（853)|820000
                      
                      ];
    
    NSString *idcard=[self uppercaseString];
    NSInteger lSumQT = 0;
    //加权因子
    int R[] = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};
    
    //校验码
    unsigned char sChecker[11] = {'1','0','X','9','8','7','6','5','4','3','2'};
    
    NSMutableString *mString = [NSMutableString stringWithString:self];
    
    if (self.length == 15) {
        [mString insertString:@"19" atIndex:6];
        long p =0;
        
        //        const char *pid = [mString UTF8String];
        
        for (int i =0; i<17; i++)
            
        {
            
            NSString * s = [mString substringWithRange:NSMakeRange(i, 1)];
            
            p += [s intValue] * R[i];
            
        }
        
        int o = p%11;
        
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        
        [mString insertString:string_content atIndex:[mString length]];
        
        idcard = mString;
    }
    
    if (![pArr containsObject:[idcard substringToIndex:2]]) {
        return NO;
    }
    //判断年月日是否有效
    
    //年份
    int strYear = [[NSString getStringWithRange:idcard Value1:6 Value2:4] intValue];
    
    //月份
    int strMonth = [[NSString getStringWithRange:idcard Value1:10 Value2:2] intValue];
    
    //日
    int strDay = [[NSString getStringWithRange:idcard Value1:12 Value2:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateFormatter setTimeZone:localZone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%02d-%02d 12:01:01",strYear,strMonth,strDay]];
    
    if (date == nil) {
        
        return NO;
        
    }
    
    NSString * lst = [idcard substringFromIndex:idcard.length-1];
    
    if (![lst isNumber] && ![lst isEqualToString:@"X"]) {
        return NO;
    }
    
    if ([[idcard substringFromIndex:idcard.length-1] integerValue]<10) {
        
    }
    
    for (int i = 0; i<17; i++){
        
        NSString * s = [idcard substringWithRange:NSMakeRange(i, 1)];
        
        lSumQT += [s intValue]*R[i];
        
    }
    const char *PaperId = [idcard UTF8String];
    if (sChecker[lSumQT%11] != PaperId[17]){
        return NO;
        
    }
    
    return YES;
    
}

+(NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger)v1 Value2:(NSInteger)v2{
    
    NSString * sub = [str substringWithRange:NSMakeRange(v1, v2)];
    
    return sub;
    
}

#pragma mark 车牌号验证 MODIFIED BY HELENSONG
-(BOOL) isValidateCarNo
{
    NSString *num=[self uppercaseString];
    NSString *carRegex = @"^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:num];
}

#pragma mark 车型号
- (BOOL) isValidateCarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:self];
}
#pragma mark 用户名
- (BOOL) isValidateUserName
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{3,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:self];
}
#pragma mark 密码
-(BOOL) isValidatePassword
{
    NSString *passWordRegex = @"^[a-zA-Z0-9~!@#$%^&*.]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}
#pragma mark - 支付密码
-(BOOL)isPayPassword{
    NSString *passWordRegex = @"^[0-9]{6}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}
#pragma mark 昵称
- (BOOL) isValidateNickname
{
    NSString *nicknameRegex = @"^[_a-zA-Z0-9\u4e00-\u9fa5]{4,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}
#pragma mark - 判断汉子
-(BOOL)isChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}
/**
 *正整数
 */
-(BOOL)isNSInteger{
    NSString *match=@"^[1-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}
/**
 *正整数
 */
-(BOOL)isNumber{
    NSString *match=@"^[0-9]{1,20}+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}
/**
 *正小数
 */
-(BOOL)isDouble{
    NSString *match=@"^[1-9]/d*/./d*|0/./d*[1-9]/d+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}
#pragma mark - 字符串转日期
- (NSDate *)dateFromString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    //[dateFormatter setDateFormat: @"MM/dd/yyyy HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:self];
    if (!destDate) {
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
        destDate= [dateFormatter dateFromString:self];
        if (!destDate) {
            [dateFormatter setDateFormat: @"yyyy-MM-dd"];
            destDate= [dateFormatter dateFromString:self];
        }
    }
    return destDate;
}
#pragma mark - 日期转字符串
+ (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}


+ (NSString *)getMonthBeginAndEndWith:(NSDate *)date{
    
   // NSDateFormatter *format=[[NSDateFormatter alloc] init];
    //[format setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate=date;//[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
  //  NSString *endString = [myDateFormatter stringFromDate:endDate];
  //  NSString *s = [NSString stringWithFormat:@"%@-%@",beginString,endString];
    return beginString;
}
+(NSString *)getLashMonthFromNow:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:-1];
    [adcomps setDay:1];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    return [NSString stringFromDate:newdate];
}
+(NSString *)getNextMonthFromNow:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:1];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    return [NSString stringFromDate:newdate];
}
-(NSString *)getNextYearFromNow{
    NSDate *destDate=  [self dateFromString];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:destDate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:1];
    [adcomps setMonth:0];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:destDate options:0];
    return [NSString stringFromDate:newdate];
}
-(NSString *)getNextWeekFromNow{
  
    NSDate *destDate=  [self dateFromString];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:destDate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:0];
    [adcomps setDay:7];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:destDate options:0];
    return [NSString stringFromDate:newdate];
}
/**
 *  根据日期判断星期
 *
 */
+(NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    /* NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
     
     [calendar setTimeZone: timeZone];*/
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}
#pragma mark - 手机号加密
/**
 *手机号加密
 */
-(NSString *)EncodeTel{
    NSString *Tel=self;
    if (Tel.length>7) {
        Tel=[Tel stringByReplacingCharactersInRange:NSMakeRange(3,Tel.length-7) withString:@"****"];
    }
    
    return Tel;
}
#pragma mark - 银行卡号加密
/**
 *银行卡号加密
 *
 */
-(NSString *)EncodeBank{
    NSString *Bank=self;
    if (Bank.length>4) {
        Bank=[Bank stringByReplacingCharactersInRange:NSMakeRange(0,Bank.length-4) withString:@"**** **** **** "];
    }
    return Bank;
}
#pragma mark - code 转 msg
/**
 *code 转 msg
 */
+(NSString *)GetMsgByCode:(NSString *)code{
    return [code isEqualToString:@"0"]?@"修改成功":@"修改失败";
}
/**
 *  处理json格式的字符串中的换行符、回车符
 */
- (NSString *)deleteSpecialCode{
    if (!self) {
        return nil;
    }
    NSString *string = [self stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    return string;
}
/**
 *  拼接请求的网络地址
 */
-(NSString *)urlDictToStringWithDict:(NSDictionary *)parameters{
    NSString *urlString=self;
    if (!urlString) {
        return @"";
    }else  if (!parameters) {
        return urlString;
    }
    NSMutableArray *parts = [NSMutableArray array];
    //enumerateKeysAndObjectsUsingBlock会遍历dictionary并把里面所有的key和value一组一组的展示给你，每组都会执行这个block 这其实就是传递一个block到另一个方法，在这个例子里它会带着特定参数被反复调用，直到找到一个ENOUGH的key，然后就会通过重新赋值那个BOOL *stop来停止运行，停止遍历同时停止调用block
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //字符串处理
        key=[NSString stringWithFormat:@"%@",key];
        obj=[NSString stringWithFormat:@"%@",obj];
        
        //接收key
        NSString *finalKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        //接收值
        NSString *finalValue = [obj stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *part =[NSString stringWithFormat:@"%@=%@",finalKey,finalValue];
        [parts addObject:part];
    }];
    NSString *queryString = [parts componentsJoinedByString:@"&"];
    queryString = queryString.length!=0 ? [NSString stringWithFormat:@"?%@",queryString] : @"";
    NSString *pathStr = [NSString stringWithFormat:@"%@%@",urlString,queryString];
    return pathStr;
}
-(NSString *)toString{
    if (self == nil) {
        return @"";
    }
    
  return  [[NSString stringWithFormat:@"%@",self] EmptyStringByWhitespace];
}
/**
 *格式化时间 从秒获得分秒
 */
+(NSString *)FormartScondTime:(NSNumber *)scond{
    NSInteger s = [scond integerValue];
    NSInteger min = s/60;
    NSInteger scon = s%60;
    if (min<1) {
          return [NSString stringWithFormat:@"%@″",@(scon)];
    }
    return [NSString stringWithFormat:@"%@′%@″",@(min),@(scon)];
}
/**
 *通过原文件图片路径获得缩略图文件路径
 */
-(NSString *)getThumbImagePathFromImagePath{
    if (!self || [self isEmptyString]) {
        return self;
    }
    NSString *imagename = [self lastPathComponent];

    NSString *path = [self stringByDeletingLastPathComponent];
    return [NSString stringWithFormat:@"%@/%@",path,[imagename stringByReplacingOccurrencesOfString:@"." withString:@"_thumb."]];
}
/**
 *通过原文件缩略图路径获得原图文件路径
 */
-(NSString *)getImagePathFromThumbPath{
    if (!self || [self isEmptyString]) {
        return self;
    }
    NSString *imagename = [self lastPathComponent];
    NSString *path = [self stringByDeletingLastPathComponent];
    return [NSString stringWithFormat:@"%@/%@",path,[imagename stringByReplacingOccurrencesOfString:@"_thumb." withString:@"."]];
}
/**
 *URL判断URL链接是否包含http:
 */
-(NSString *)urlAutoAddHttp
{
    NSString *logo =self;
    if(logo == nil)
    {
        return nil;
    }
//    if (![logo hasPrefix:@"http://"] &&  ![logo hasPrefix:@"https://"] )
//    {
//        logo=[NSString stringWithFormat:@"%@%@",ProductBaseURL,logo];
//    }
    return logo;
}
/**
 *小数数据的整数部分部分
 */
-(NSString *)getPointFont{
    NSString *str=@"";
    if (self && [self componentsSeparatedByString:@"."].count>0) {
        str =[[self componentsSeparatedByString:@"."] firstObject];
    }
    if ([str isEmptyString]) {
        str=@"0";
    }
    return str;
}
/**
 *小数数据的整数部分部分
 */
-(NSString *)getPointBack{
    NSString *str=@".00";
    if (self && [self componentsSeparatedByString:@"."].count>1) {
        str =[NSString stringWithFormat:@".%@",[[self componentsSeparatedByString:@"."] lastObject]];
    }
    return str;
}
/**
 *计算字符串长度
 */
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize
                              options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                           attributes:attrs
                              context:nil].size;
}
@end
