//
//  Market_Chart_Bottom_View.h
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Market_Chart_Bottom_View : UIView

//币币交易
@property(nonatomic,strong)UIButton *coinButton;

//合约交易
@property(nonatomic,strong)UIButton *contractButton;

@property(nonatomic,copy)void (^itmeBlock)(NSInteger type);

/**
 单独一个按钮
 */
-(void)oneSingleClicked;

@end
