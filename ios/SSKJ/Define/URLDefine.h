//
//  UrlDefine.h
//  SSKJ
//
//  Created by James on 2018/6/14.
//  Copyright © 2018年 James. All rights reserved.
//

#define ENVIRONMENT 0 //  0－开发/1－正式

#if ENVIRONMENT == 0
/* ************************  开发服务器接口地址  *********************************** */
//192.168.1.225    www.qmmqq.com
#define ProductBaseServer  @"http://www.00086gp.com"  //@"http://47.244.28.95" 香港步基

#define ProductBaseURLPath   "/app/interface?"

#define ProductBaseURL       ProductBaseServer ProductBaseURLPath

#define SocketUrl @"ws://www.qmmqq.com:7272"

/*******************************************************************************************/


#elif ENVIRONMENT == 1


/* ************************  发布正式服务器接口地址  *********************************** */

#define ProductBaseServer    @"http://www.00086gp.com"  //@"http://47.244.28.95" 香港步基

#define ProductBaseURLPath   "/app/interface?"

#define ProductBaseURL       ProductBaseServer ProductBaseURLPath

#define SocketUrl @"ws://47.244.28.95:7272/"

/*******************************************************************************************/

#endif


/************************************ 登录、注册、忘记密码、获取验证码 ****************************/

/* 用户注册 */
#define GE_Register_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/register"]
// 用户登录
#define GE_Login_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/user_login"]
//获取验证码
#define GE_GetCode_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/send_sms"]
//忘记密码
#define GE_Reset_opwd_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/reset_opwd"]
//修改登录密码
#define GE_xiugai_pwd_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/xiugai_pwd"]

/* 用户信息 */
#define GE_Pubilc_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/Users/getuserinfo"]

/*******************************************************************************************/


/************************************ 我的 ****************************/
//上传图片
#define GE_Upload_pic_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/Qbw/upload_pic"]
//用户信息
#define GE_getuserinfo_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/Users/getuserinfo"]
//实名开户
#define GE_set_renzheng_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/set_renzheng"]
//实名开户
#define GE_set_renzheng_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/set_renzheng"]
//实名开户
#define GE_set_renzheng_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/set_renzheng"]
//充值信息获取
#define GE_Pingtai_info_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/ajax/pingtai_info"]


/*******************************************************************************************/

/************************************ 行情 ****************************/
//首页轮播图
#define GE_getBanner_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/ajax/getBanner"]
//行情列表
#define GE_getpro_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/ajax/getpro"]
//行情k线
#define GE_index_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Ajax/index"]
//搜索
#define GE_search_all_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/Users/search_all"]
//添加自选
#define GE_add_optional_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/Users/add_optional"]
//自选列表
#define GE_optional_list_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/Users/optional_list"]
//删除自选
#define GE_optional_del_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/Users/optional_del"]
//平台公告
#define GE_Notice_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/api/NoticeList"]
//公告详情
#define GE_NoticeDetail_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/api/Notice"]



/*******************************************************************************************/

/************************************ 交易 ****************************/
//持仓列表
#define GE_chicang_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Order/chicang"]
//成交列表
#define GE_chengjiao_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Order/chengjiao"]
//下单
#define GE_add_order_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Order/add_order"]
//平仓
#define GE_pingcang_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Order/pingcang"]

/*******************************************************************************************/

//版本更新
#define GE_CheckVersion_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Version/check_version"]

//风险书
#define GE_FengXianShu_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/agree"]
