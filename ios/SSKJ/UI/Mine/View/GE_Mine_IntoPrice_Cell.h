//
//  GE_Mine_IntoPrice_Cell.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GE_Mine_IntoPrice_Cell : UITableViewCell

//type 1是入金  2是出金
- (void)initModel:(NSDictionary *)model type:(NSInteger)type;


@end

NS_ASSUME_NONNULL_END
