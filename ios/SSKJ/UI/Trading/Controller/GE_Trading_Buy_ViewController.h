//
//  GE_Trading_Buy_ViewController.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GE_Trading_Buy_ViewController : SSKJ_BaseViewController

@property(nonatomic,copy)void (^BuyRefreshBlock)(NSInteger index);


@end

NS_ASSUME_NONNULL_END
