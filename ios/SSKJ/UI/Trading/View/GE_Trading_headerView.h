//
//  GE_Trading_headerView.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GE_Mine_AccountRecord_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface GE_Trading_headerView : UIView

- (void)setDataWithDic:(GE_Mine_AccountRecord_Model *)model;

@property(nonatomic,copy)void (^bcTapBlock)(NSString * index);

@end

NS_ASSUME_NONNULL_END
