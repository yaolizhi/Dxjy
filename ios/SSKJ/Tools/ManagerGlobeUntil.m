//
//  ManagerGlobeUntil.m
//  MIT_itrade
//
//  Created by wanc on 14-4-24.
//  Copyright (c) 2014年 ___ZhengDaXinXi___. All rights reserved.
//
/*********************************
 文件名: ManagerGlobeUntil.m
 功能描述: 全局数据单例
 创建人: GT
 修改日期: 2015.10.30
 *********************************/
#import "ManagerGlobeUntil.h"
#import <CommonCrypto/CommonDigest.h>
//utils
//#import "Global.h"
#import "AppDelegate.h"
#import "NSString+Conversion.h"

@interface ManagerGlobeUntil() {
    
}
@end

@implementation ManagerGlobeUntil

+ (instancetype)sharedManager {
    static ManagerGlobeUntil *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[ManagerGlobeUntil alloc]init];
    });
    
    return _sharedManager;
}

#pragma mark -- init method
-(id)init
{
    if (self = [super init]) {
        _loginState = NO;
        _tradeType = 0;
        self.isNetworkReachability = YES;
        self.isSingleLogin = NO;
    }
    
    return self;
}


#pragma mark -- 清空用户信息

//- (void)clearUserInfoData {
//    self.loginState = NO;
//    UserInfoModel *model = [[UserInfoModel alloc]init];
//    [self updataUserInfoWithModel:model];
//}
#pragma mark --  数据存储

/*    对个人信息进行处理         */
//- (void)updataUserInfoWithModel:(UserInfoModel*)model {
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
//    [userDefaults setObject:data forKey:@"userInfoSave"];
//    [userDefaults synchronize];
//}
//- (UserInfoModel*)getUserInfo {
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSData *data = [userDefault objectForKey:@"userInfoSave"];
//    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
//}

/*    对系统信息进行配置         */
//- (void)updataSystemBaseInfoWithModel:(SystemBaseInfoModel*)model {
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
//    [userDefaults setObject:data forKey:@"SystemBaseInfoSave"];
//    [userDefaults synchronize];
//}
//- (SystemBaseInfoModel*)getSystemBaseInfo {
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSData *data = [userDefault objectForKey:@"SystemBaseInfoSave"];
//    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
//}

/*    对自选数据进行处理         */
- (void)updataOptionDatas:(NSArray*)optionDatas {
    if (!optionDatas) {
        optionDatas = [[NSArray alloc]init];
    }
    [[NSUserDefaults  standardUserDefaults] setObject:optionDatas
                                               forKey:@"optionDatas"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray*)getOptionDatas {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:@"optionDatas"];
}

- (BOOL)optionDatasIsExistOptionData:(NSDictionary*)optionData {
    
    NSArray *optionalDatas = [[ManagerGlobeUntil sharedManager] getOptionDatas];
    return [optionalDatas containsObject:optionData];
}
//所有商品代码数据
- (void)updataAllGoodsInfoDatas:(NSArray*)allGoodsInfoDatas {
    [[NSUserDefaults  standardUserDefaults] setObject:allGoodsInfoDatas
                                               forKey:@"allGoodsInfoDatas"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray*)martchDatasWithMartchCase:(NSString*)marchCase {
    NSArray *allGoodsInfo = [self allGoodsInfo];
    NSMutableArray *martchDatas = [[NSMutableArray alloc]init];
    for (NSDictionary *dataDic in allGoodsInfo) {
        NSString *codeStr = [dataDic objectForKey:@"code"];
        if ([codeStr rangeOfString:marchCase].location != NSNotFound) {
            [martchDatas addObject:dataDic];
        }
    }
    return martchDatas;
}

- (NSArray*)allGoodsInfo {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:@"allGoodsInfoDatas"];
}
//搜索历史数据存储
- (void)updataSearchHistoryDatas:(NSArray*)searchHistoryDatas {
    if (!searchHistoryDatas) {
        searchHistoryDatas = [[NSArray alloc]init];
    }
    [[NSUserDefaults  standardUserDefaults] setObject:searchHistoryDatas
                                               forKey:@"historySearchDatas"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)insertSingleSearchGoodsInfo:(NSDictionary*)singleGoodsInfo {
    NSMutableArray *historySearchDatas = [[self getSearchHistoryDatas] mutableCopy];
    NSString *currentGoodsCode = [NSString stringTransformObject:[singleGoodsInfo objectForKey:@"code"]];
    
    //获取所有商品代码
    NSMutableArray *allSearchHistoryCodeDatas = [[NSMutableArray alloc]init];
    for (NSDictionary *goodsInfo in historySearchDatas) {
        NSString *code = [goodsInfo objectForKey:@"code"];
        [allSearchHistoryCodeDatas addObject:code];
    }
    
    if ([allSearchHistoryCodeDatas containsObject:currentGoodsCode]) {//已存在
        [historySearchDatas removeObject:singleGoodsInfo];
        [historySearchDatas addObject:singleGoodsInfo];
    } else {//不存在
        [historySearchDatas addObject:singleGoodsInfo];
    }

    [self updataSearchHistoryDatas:[historySearchDatas copy]];
}
- (void)clearAllHistorySearchGoodsInfo {
    NSArray *historySearchDatas = [[NSArray alloc]init];
    [[NSUserDefaults  standardUserDefaults] setObject:historySearchDatas
                                               forKey:@"historySearchDatas"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSArray*)getSearchHistoryDatas {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *arr = [userDefault objectForKey:@"historySearchDatas"];
    if (!arr) {
        arr = [[NSArray alloc]init];
    }
    return arr;
}
#pragma mark -- 字符串转JSON，JSON转字符串
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        ////NSLog(Localized(@"json解析失败：%@", nil),err);
        return nil;
    }
    return dic;
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
#pragma mark - date
- (NSInteger)rangeNumWithBeginT:(NSString *)b endT:(NSString*)e
{
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"HH:mm"];
    
    NSDate *date1 = [dataFormatter dateFromString:b];
    NSDate *date2 = [dataFormatter dateFromString:e];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *d = [cal components:unitFlags fromDate:date1 toDate:date2 options:0];
    
    NSInteger min = [d hour]*60+[d minute];
    
    //针对跨天的交易节做处理
    if (min < 0) {
        min += 24*60;
    }
    return min+1;
}
#pragma mark -- 获取设备标识
- (NSString*)getDeviceIdentifier {
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return uuid;
}
- (NSString*)getEncryptDeviceIdentifier {
    return [self MD5EncryptSting:[self getDeviceIdentifier]];
}

#pragma mark -- MD5 加密
- (NSString*)MD5EncryptSting:(NSString*)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
#pragma mark - MBProgressHUD

- (void)showAlertWithMsg:(NSString*)str delegate:(id)delegate {
    
    [self showAlertWithTitle:nil message:str delegate:delegate];
}

- (void)showAlertWithTitle:(NSString*)title message:(NSString*)msg delegate:(id)delegate {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title
                                                   message:msg
                                                  delegate:delegate
                                         cancelButtonTitle:SSKJLocalized(@"确定", nil)
                                         otherButtonTitles: nil];
    [alert show];
}
- (void)hideAllHUDFormeView:(id)View
{
    [MBProgressHUD hideAllHUDsForView:(UIView*)View animated:YES];
}

- (void)showTRHUDWithMsg:(NSString*)str inView:(id)View
{
    if (!HUD)
    {
        HUD = [MBProgressHUD showHUDAddedTo:(UIView *)View animated:YES];
        HUD.delegate = (id<MBProgressHUDDelegate> )self;
        HUD.labelText = str;
        HUD.yOffset = -74.0f;
        
    }
}

- (void)showHUDWithMsg:(NSString*)str inView:(id)View
{
//    if (!HUD)
//    {
//        
//    }
    HUD = [MBProgressHUD showHUDAddedTo:(UIView *)View animated:YES];
    HUD.delegate = (id<MBProgressHUDDelegate> )self;
    HUD.labelText = str;
}

- (void)showTextHUDWithMsg:(NSString*)str inView:(id)View
{
    [self hideHUD];
    UIView *v = (UIView*)View;
    if (!v)
    {
        v = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).window;
    }
    HUD = [MBProgressHUD showHUDAddedTo:v animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.delegate = (id<MBProgressHUDDelegate> )self;
    HUD.detailsLabelText = str;
    [HUD hide:YES afterDelay:2.f];
}
- (void)hideHUD
{
    if (HUD)
    {
        
        [HUD hide:YES afterDelay:0.3];
    }
    
}

- (void)hideHUDFromeView:(UIView*)view
{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

#pragma mark -- 字体大小比例
-(CGFloat)setDifferenceScreenFontSizeWithFontOfSize:(CGFloat)size
{
    if (ScreenWidth == 375) {
        return size;
    }else if(ScreenWidth == 320)
    {
        return size*0.85;
    }else if(ScreenWidth == 414) {
        return size *1.05;
    }
    return size;
    
}
-(CGFloat)setCurrentViewHightWithBaseViewHight:(CGFloat)hight
{
    if (ScreenWidth == 375) {
        return hight;
    }else if(ScreenWidth == 320)
    {
        return hight*0.85;
    }else if(ScreenWidth == 414) {
        return hight *1.1;
    }
    return hight;
}
@end
