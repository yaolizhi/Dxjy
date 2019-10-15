//
//  AccessaryTypeView.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/1/7.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXY_KLine_MainView.h"
#import "LXY_KLine_AccessoryLabelView.h"
NS_ASSUME_NONNULL_BEGIN

@interface AccessaryTypeView : UIView

@property (nonatomic, copy) void (^mainAccessaryTypeBlock)(LXY_KMAINACCESSORYTYPE type);
@property (nonatomic, strong) void (^accessaryTypeBlock)(LXY_ACCESSORYTYPE type);


@end

NS_ASSUME_NONNULL_END
