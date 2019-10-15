//
//  ManagerGlobeUntil.h
//  MIT_itrade
//
//  Created by wanc on 14-4-24.
//  Copyright (c) 2014年 ___ZhengDaXinXi___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
//#import "UserInfoModel.h"
//#import "SystemBaseInfoModel.h"
#import "MBProgressHUD.h"
@interface ManagerGlobeUntil : NSObject
{
    MBProgressHUD *HUD;
}

//区分币币交易还是合约交易（1：币币交易，2：合约交易，0 其他）
@property(nonatomic, assign)NSInteger tradeType;
//登录状态


@property (nonatomic, assign) BOOL isSingleLogin;
@property (nonatomic) BOOL loginState;//登录状态
@property (nonatomic) BOOL isHadShowNotificationMessageAlertView;//是否已经展示弹框视图
@property(nonatomic)BOOL isNetworkReachability;//网络连接状态
@property (nonatomic, copy) NSString * goodsCode;
@property (nonatomic, assign) BOOL DefalutSeleted;


+ (instancetype)sharedManager;
//获取设备UDID
- (NSString*)getDeviceIdentifier;
- (NSString*)getEncryptDeviceIdentifier;
//清空登录信息
- (void)clearUserInfoData;
/*    对个人信息进行处理         */
//- (void)updataUserInfoWithModel:(UserInfoModel*)model;
//- (UserInfoModel*)getUserInfo;
///*    对系统信息进行配置         */
//- (void)updataSystemBaseInfoWithModel:(SystemBaseInfoModel*)model;
//- (SystemBaseInfoModel*)getSystemBaseInfo;
/*    对自选数据进行处理         */
- (void)updataOptionDatas:(NSMutableArray*)optionDatas;
- (NSMutableArray*)getOptionDatas;
- (BOOL)optionDatasIsExistOptionData:(NSDictionary*)optionData;
//所有商品代码数据
- (void)updataAllGoodsInfoDatas:(NSArray*)allGoodsInfoDatas;
- (NSArray*)allGoodsInfo;
- (NSArray*)martchDatasWithMartchCase:(NSString*)marchCase;
//搜索历史数据存储
- (void)updataSearchHistoryDatas:(NSArray*)searchHistoryDatas;
- (void)insertSingleSearchGoodsInfo:(NSDictionary*)singleGoodsInfo;
- (void)clearAllHistorySearchGoodsInfo;
- (NSArray*)getSearchHistoryDatas;
//json和字符串相互转换
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
- (NSString*)dictionaryToJson:(NSDictionary *)dic;
//MD5 加密
- (NSString*)MD5EncryptSting:(NSString*)str;

/* 加载框视图 */
- (void)showAlertWithMsg:(NSString*)str delegate:(id)delegate;
- (void)showAlertWithTitle:(NSString*)title message:(NSString*)msg delegate:(id)delegate;
- (void)showHUDWithMsg:(NSString*)str inView:(id)View;
- (void)showTRHUDWithMsg:(NSString*)str inView:(id)View;
- (void)showTextHUDWithMsg:(NSString*)str inView:(id)View;
- (void)hideHUD;
- (void)hideAllHUDFormeView:(id)View;
- (void)hideHUDFromeView:(UIView*)view;
/* 字体大小 */
-(CGFloat)setDifferenceScreenFontSizeWithFontOfSize:(CGFloat)size;
/*不同屏幕 视图缩放比例  */
-(CGFloat)setCurrentViewHightWithBaseViewHight:(CGFloat)hight;

- (NSInteger)rangeNumWithBeginT:(NSString *)b endT:(NSString*)e;

@end
