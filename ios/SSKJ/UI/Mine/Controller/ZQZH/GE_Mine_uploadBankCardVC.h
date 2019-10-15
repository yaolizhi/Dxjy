//
//  GE_Mine_uploadBankCardVC.h
//  SSKJ
//
//  Created by 张超 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GE_Mine_uploadBankCardVC : UITableViewController

@property (nonatomic, copy) NSString *cardType;
@property (nonatomic, copy) NSString *cardAccount;
@property (nonatomic, copy) NSString *cardAddress;
@property (nonatomic, copy) UIImage *cardimg1;
@property (nonatomic, copy) UIImage *cardimg2;

@end

NS_ASSUME_NONNULL_END
