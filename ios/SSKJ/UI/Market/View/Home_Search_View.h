//
//  Home_Search_View.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/5/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Home_Search_View : UIView

@property (nonatomic,strong) UITextField * textfield;

@property (nonatomic,strong) UIButton * searchBtn;

@property (nonatomic, copy) void (^SearchBtnBlock)(NSString * searchStr);


@end

NS_ASSUME_NONNULL_END
