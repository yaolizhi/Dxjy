//
//  GE_ZiXun_HangYeCell.h
//  SSKJ
//
//  Created by 张超 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GE_ZiXun_HangYeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *pingLunLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;


//type传入  1：代表行业资讯  2：平台新闻
- (void)initWithModel:(NSDictionary *)model type:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
