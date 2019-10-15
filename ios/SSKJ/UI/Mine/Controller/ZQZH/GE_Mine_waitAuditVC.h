//
//  GE_Mine_waitAuditVC.h
//  SSKJ
//
//  Created by 张超 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GE_Mine_waitAuditVC : UITableViewController

// 1:成功  2:审核中 3:失败
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSDictionary *dataSource;

@end

NS_ASSUME_NONNULL_END
