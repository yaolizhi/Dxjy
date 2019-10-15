//
//  BFEX_System_Version_Model.h
//  ZYW_MIT
//
//  Created by James on 2018/7/5.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFEX_System_Version_Model : NSObject

//下载地址
@property(nonatomic,copy)NSString *downUrl;
@property(nonatomic,copy)NSString *addr;

//版本号
@property(nonatomic,copy)NSString *appVersion;
@property(nonatomic,copy)NSString *version;

//更新标题
@property(nonatomic,copy)NSString *title;

//更新内容
@property(nonatomic,copy)NSString *details;
@property(nonatomic,copy)NSString *content;

//发布时间
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *uptime;

//是否强制更新
@property(nonatomic,assign)NSString *upState;
@property(nonatomic,assign)NSString *uptype;


@end
