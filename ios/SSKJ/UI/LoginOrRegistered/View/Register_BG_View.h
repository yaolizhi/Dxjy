//
//  Register_BG_View.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/5/17.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VerifyCodeButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface Register_BG_View : UIView

- (instancetype)initWithFrame:(CGRect)frame titleStr:(NSString *)titleStr textStr:(NSString *)textStr placeholderStr:(NSString *)placeholderStr;


@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UITextField * textField;

@property (nonatomic,strong) UIButton * showBtn;

@property (nonatomic,strong) VerifyCodeButton * codeBtn;

@property (nonatomic,strong) UIView * lineview;

@end

NS_ASSUME_NONNULL_END
