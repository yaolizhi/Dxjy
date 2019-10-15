//
//  WL_LoginUser_Tool.h
//  明
//
//  Created by mac for csh on 16/6/3.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "WL_Network_Model.h"

#import "SSKJ_Login_Model.h"

#import "SSKJ_UserInfo_Model.h"

#import "GE_Mine_SysSet_Model.h"


@interface SSKJ_User_Tool : NSObject

//  清除本地保存的用户信息
+(void)clearUserInfo;

// 单例
+(SSKJ_User_Tool *)sharedUserTool;


// 保存登录信息
-(void)saveLoginInfoWithLoginModel:(SSKJ_Login_Model *)loginModel;

// 保存用户信息
-(void)saveUserInfoWithUserInfoModel:(SSKJ_UserInfo_Model *)userInfoModel;

//保存交易设置信息
-(void)saveSysSetInfoModel:(GE_Mine_SysSet_Model *)syssetModel;


-(NSString *)getMobile; // 用户手机号

-(NSString *)getToken;  // 用户token

-(NSString *)getAccount;  // 用户acount

-(NSString *)getUID;        // 用户id

-(NSString *)getLogin;        // 登录状态

-(NSString *)getOutRate;        // 出金汇率（美元转人民币）

-(NSString *)getInRate;        // 入金汇率（美元转人民币）

-(NSString *)getCloseOutRate;        // 强平比例

-(NSString *)getMinInCharge;   //最小入金


@end

















