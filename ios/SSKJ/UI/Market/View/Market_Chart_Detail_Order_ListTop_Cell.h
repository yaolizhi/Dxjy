//
//  Market_Chart_Detail_Order_ListTop_Cell.h
//  ZYW_MIT
//
//  Created by James on 2018/7/28.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Market_Chart_Detail_Order_ListTop_Cell : UITableViewCell

//时间
@property(nonatomic,strong)UILabel *timeLabel;

//方向
@property(nonatomic,strong)UILabel *arrowLabel;

//价格
@property(nonatomic,strong)UILabel *priceLabel;

//数量
@property(nonatomic,strong)UILabel *numberLabel;

-(void)initWithSection:(NSString *)code;

@end
