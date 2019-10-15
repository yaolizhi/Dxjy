//
//  SSKJ_UserInfo_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/10.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_UserInfo_Model : NSObject

@property (nonatomic,copy) NSString * account;

@property (nonatomic,copy) NSString * auth_status;

@property (nonatomic,copy) NSString * is_start_google;

@property (nonatomic,copy) NSString * level;

@property (nonatomic,copy) NSString * mobile;

@property (nonatomic,copy) NSString * realname;

@property (nonatomic,copy) NSString * status;

@property (nonatomic,copy) NSString * tgno;//推荐码

@property (nonatomic,copy) NSString * user_id;

@property (nonatomic,copy) NSString * coin_type;//币种类型

@property (nonatomic,copy) NSString * wallone;//可用

@property (nonatomic,copy) NSString * guarantee_rate;//维持担保比例

@property (nonatomic,copy) NSString * headimg;//头像


@end

NS_ASSUME_NONNULL_END
