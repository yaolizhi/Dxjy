//
//  Market_Chart_Nav_View.h
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Market_Chart_Nav_View : UIView

@property(nonatomic,strong)UIButton *backButton;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIButton *alphaButton;

@property(nonatomic,copy)void (^backBtnBlock)(void);

@end
