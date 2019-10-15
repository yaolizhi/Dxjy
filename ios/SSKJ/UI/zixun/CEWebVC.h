//
//  CEWebVC.h
//  ZYW_MIT
//
//  Created by 张超 on 2018/11/15.
//  Copyright © 2018 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CEWebVC : SSKJ_BaseViewController

@property (nonatomic, copy)NSString *detailID;

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *detailStr;
@property (nonatomic, copy) NSString *timeStr;
// 1: 资讯详情   2: 公告详情
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, copy) NSString *newsid;

@end

NS_ASSUME_NONNULL_END
