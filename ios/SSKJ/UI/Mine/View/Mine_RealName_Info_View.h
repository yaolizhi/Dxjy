//
//  Mine_RealName_Info_View.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/5/17.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Mine_RealName_Info_View : UIView

@property (nonatomic,strong) UIView * bgView;

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UIView * nameBgView;

@property (nonatomic,strong) UITextField * nameTextField;

@property (nonatomic,strong) UIView * cardNameBgView;

@property (nonatomic,strong) UITextField * cardNameTextField;

@property (nonatomic,strong) UIView * cardAddressBgView;

@property (nonatomic,strong) UITextField * cardAddressTextField;

@property (nonatomic,strong) UIView * cardNumBgView;

@property (nonatomic,strong) UITextField * cardNumTextField;



@end

NS_ASSUME_NONNULL_END
