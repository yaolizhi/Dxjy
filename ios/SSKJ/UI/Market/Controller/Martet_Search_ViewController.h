//
//  Martet_Search_ViewController.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/5/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface Martet_Search_ViewController : SSKJ_BaseViewController

@property (nonatomic,strong) NSString * searchStr;

@property(nonatomic,copy)void (^SearchCodeBlock)(NSString * code);

@property (nonatomic,assign) NSInteger index;//1 行情点击进来  2 交易点击进来

@end

NS_ASSUME_NONNULL_END
