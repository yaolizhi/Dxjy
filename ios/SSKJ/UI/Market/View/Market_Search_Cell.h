//
//  Market_Search_Cell.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/5/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Market_Search_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface Market_Search_Cell : UITableViewCell

@property (nonatomic,strong) UILabel * namelabel;

@property (nonatomic,strong) UILabel * codeabel;

@property (nonatomic,strong) UIButton * addBtn;

@property (nonatomic,strong) UIView * lineview;

@property (nonatomic, copy) void (^AddZiXuanBlock)(Market_Search_Model *model);

@property (nonatomic,strong) Market_Search_Model *model;

- (void)initDataWithModel:(Market_Search_Model *)model index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
