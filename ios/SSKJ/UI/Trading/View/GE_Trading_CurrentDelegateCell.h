//
//  GE_Trading_CurrentDelegateCell.h
//  SSKJ
//
//  Created by 张超 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GE_Trading_HistioryOrder_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface GE_Trading_CurrentDelegateCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *zuoDuoLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuanYouLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel1;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel2;
@property (weak, nonatomic) IBOutlet UILabel *weituoPriceLabel1;
@property (weak, nonatomic) IBOutlet UILabel *weituoPriceLabel2;
@property (weak, nonatomic) IBOutlet UILabel *weituoCountLabel1;
@property (weak, nonatomic) IBOutlet UILabel *weituoCountLabel2;
@property (weak, nonatomic) IBOutlet UILabel *chengJiaoLabel1;
@property (weak, nonatomic) IBOutlet UILabel *chengJiaoLabel2;
@property (weak, nonatomic) IBOutlet UILabel *chedanLabel1;
@property (weak, nonatomic) IBOutlet UILabel *chedanLabel2;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel1;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel2;

- (void)setDataWithModel:(GE_Trading_HistioryOrder_Model *)model type:(NSString *)str;


@end

NS_ASSUME_NONNULL_END
