//
//  GE_Trading_ChiCang_View.h
//  SSKJ
//
//  Created by 张超 on 2019/4/1.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GE_Trading_ChiCang_Model.h"
#import "GE_Trading_OneStock_Model.h"

typedef void(^SureBtnBlock)(void);



NS_ASSUME_NONNULL_BEGIN

@interface GE_Trading_ChiCang_View : UIView

@property (weak, nonatomic) IBOutlet UILabel *yuanYouLabel;
@property (weak, nonatomic) IBOutlet UILabel *zuoLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhiYingLabel;
@property (weak, nonatomic) IBOutlet UITextField *zhiYingTextField;
@property (weak, nonatomic) IBOutlet UILabel *zhiSunLabel;
@property (weak, nonatomic) IBOutlet UITextField *zhiSunTextField;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;


@property (nonatomic, copy) SureBtnBlock sureBtnBlock;

@property (nonatomic, strong) GE_Trading_ChiCang_Model *model;

@property (nonatomic, strong) GE_Trading_OneStock_Model *stockModel;



- (void)initModel:(GE_Trading_ChiCang_Model *)model;


@end

NS_ASSUME_NONNULL_END
