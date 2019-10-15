//
//  Market_Chart_Detail_Type_Section_View.h
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Market_Chart_Detail_Type_Section_View : UITableViewHeaderFooterView

//成交
@property(nonatomic,strong)UIButton *dealButton;

//简介
@property(nonatomic,strong)UIButton *introButton;

//分割线
@property(nonatomic,strong)UIView *lineView;

@property(nonatomic,copy)void (^itemBlock)(NSInteger type);

@end
