//
//  Transaction_HistoryTransactionInquiry_HeaderView.h
//  ZYW_MIT
//
//  Created by Wang on 2017/11/21.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Transaction_HistoryTransactionInquiry_HeaderViewDelegate  <NSObject>
@optional
- (void)selectedStartDate;
- (void)selectedEndDate;
@end
@interface Transaction_HistoryTransactionInquiry_HeaderView : UIView
@property(nonatomic, strong)UILabel *startDateLabel;
@property(nonatomic, strong)UILabel *endDateLabel;
@property(nonatomic, unsafe_unretained)id<Transaction_HistoryTransactionInquiry_HeaderViewDelegate>delegate;
@end
