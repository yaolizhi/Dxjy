//
//  GE_Trading_HistoryDelegateCell.h
//  SSKJ
//
//  Created by 张超 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GE_Trading_HistioryOrder_Model.h"


NS_ASSUME_NONNULL_BEGIN

@interface GE_Trading_HistoryDelegateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *zuoduoLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuanyouLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *buyPriceLabel1;
@property (weak, nonatomic) IBOutlet UILabel *buyPriceLabel2;
@property (weak, nonatomic) IBOutlet UILabel *sellPriceLabel1;
@property (weak, nonatomic) IBOutlet UILabel *sellPriceLabel2;
@property (weak, nonatomic) IBOutlet UILabel *shoushuLabel1;
@property (weak, nonatomic) IBOutlet UILabel *shoushuLabel2;
@property (weak, nonatomic) IBOutlet UILabel *yingkuiLabel1;
@property (weak, nonatomic) IBOutlet UILabel *yingkuiLabel2;
@property (weak, nonatomic) IBOutlet UILabel *shouxufeiLabel1;
@property (weak, nonatomic) IBOutlet UILabel *shouxufeiLabel2;
@property (weak, nonatomic) IBOutlet UILabel *baozhengjinLabel1;
@property (weak, nonatomic) IBOutlet UILabel *baozhengjinLabel2;
@property (weak, nonatomic) IBOutlet UILabel *zhiyingLabel1;
@property (weak, nonatomic) IBOutlet UILabel *zhiyingLabel2;
@property (weak, nonatomic) IBOutlet UILabel *zhisunLabel1;
@property (weak, nonatomic) IBOutlet UILabel *zhisunLabel2;
@property (weak, nonatomic) IBOutlet UILabel *guoyefeiLabel1;
@property (weak, nonatomic) IBOutlet UILabel *guoyefeiLabel2;

- (void)setDataWithModel:(GE_Trading_HistioryOrder_Model *)model type:(NSString *)str;


@end

NS_ASSUME_NONNULL_END
