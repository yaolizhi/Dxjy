//
//  WL_LoginUser_Tool.m
//  明
//
//  Created by mac for csh on 16/6/3.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import "SSKJ_User_Tool.h"

@interface SSKJ_User_Tool()

@end

@implementation SSKJ_User_Tool

+(void)clearUserInfo
{
//    NSUserDefaults *settings=[NSUserDefaults standardUserDefaults];
    SSKJUserDefaultsSET(@"", @"token");
    SSKJUserDefaultsSET(@"", @"account");
    SSKJUserDefaultsSET(@"", @"mobile");
    SSKJUserDefaultsSET(@"", @"uid");
    SSKJUserDefaultsSET(@"", @"logined");
    SSKJUserDefaultsSET(@"", @"outRate");
    SSKJUserDefaultsSET(@"", @"closeOutRate");
    SSKJUserDefaultsSET(@"", @"inRate");
}

+(SSKJ_User_Tool *)sharedUserTool
{
    
    static SSKJ_User_Tool *sharedSVC=nil;

        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,
        ^{
            
            sharedSVC = [[self alloc] init];
        });
  
    return sharedSVC;
}

#pragma mark -保存登录信息
-(void)saveLoginInfoWithLoginModel:(SSKJ_Login_Model *)loginModel;
{
    NSUserDefaults *settings=[NSUserDefaults standardUserDefaults];
    
    if (![loginModel.tel isEqual:[NSNull null]]){
        [settings setObject:loginModel.tel forKey:@"mobile"];
    }
    
    if (![loginModel.token isEqual:[NSNull null]]){
        [settings setObject:loginModel.token forKey:@"token"];
    }
    
    if (![loginModel.account isEqual:[NSNull null]]) {
        [settings setObject:loginModel.account forKey:@"account"];
    }
    
    if (![loginModel.uid isEqual:[NSNull null]]) {
        [settings setObject:loginModel.uid forKey:@"uid"];
    }
    
    [settings setObject:@"1" forKey:@"logined"];
    
}

// 保存用户信息
-(void)saveUserInfoWithUserInfoModel:(SSKJ_UserInfo_Model *)userInfoModel
{
    NSUserDefaults *settings=[NSUserDefaults standardUserDefaults];
    
//    if (![userInfoModel.uid isEqual:[NSNull null]]){
//        [settings setObject:userInfoModel.uid forKey:@"uid"];
//    }
    
    
    
}

- (void)saveSysSetInfoModel:(GE_Mine_SysSet_Model *)syssetModel
{
    NSUserDefaults *settings=[NSUserDefaults standardUserDefaults];
    
    if (![syssetModel.outRate isEqual:[NSNull null]]) {
        [settings setObject:syssetModel.outRate forKey:@"outRate"];
    }
    
    if (![syssetModel.outRate isEqual:[NSNull null]]) {
        [settings setObject:syssetModel.closeOutRate forKey:@"closeOutRate"];
    }
    if (![syssetModel.inRate isEqual:[NSNull null]]) {
        [settings setObject:syssetModel.inRate forKey:@"inRate"];
    }
    
    if (![syssetModel.minInCharge isEqual:[NSNull null]]) {
        [settings setObject:syssetModel.minInCharge forKey:@"minInCharge"];
    }
    
    
}

#pragma mark - 获取手机号
-(NSString *)getMobile
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"mobile"];
    
}

#pragma mark - 获取token
-(NSString *)getToken
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"token"];
}


#pragma mark - 获取用户account
-(NSString *)getAccount
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"account"];
    
}

#pragma mark - 获取用户id
-(NSString *)getUID
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"uid"];
    
}

#pragma mark - 获取用户id
-(NSString *)getLogin
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"logined"];
    
}

-(NSString *)getOutRate
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"outRate"];
}

-(NSString *)getCloseOutRate
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"closeOutRate"];
}

-(NSString *)getInRate
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"inRate"];
}

#pragma mark- 最小入金
-(NSString *)getMinInCharge
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"minInCharge"];
}


@end




























