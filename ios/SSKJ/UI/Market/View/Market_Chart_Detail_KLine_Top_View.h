//
//  Market_Chart_Detail_KLine_Top_View.h
//  ZYW_MIT
//
//  Created by James on 2018/7/28.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Market_Chart_Detail_KLine_Top_View : UIView

@property(nonatomic,copy)void (^itemBlock)(NSInteger type);

@end
