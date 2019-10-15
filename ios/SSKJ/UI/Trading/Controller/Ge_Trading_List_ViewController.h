//
//  Ge_Trading_List_ViewController.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface Ge_Trading_List_ViewController : SSKJ_BaseViewController


@property(nonatomic,copy)void (^WeiTuoRefreshBlock)(NSInteger index);




@end

NS_ASSUME_NONNULL_END
