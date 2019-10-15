//
//  GE_Trading_ConfirmAlertView.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GE_Trading_ConfirmAlertView : UIView

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, copy) void (^ConfirmBlock)(NSDictionary *dic);

-(void)showWithData:(NSDictionary *)data;

-(void)hide;

@end

NS_ASSUME_NONNULL_END
