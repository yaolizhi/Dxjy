//
//  Market_Chart_Detail_Order_List_Cell.h
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Market_Chart_Detail_Deal_Model.h"

@interface Market_Chart_Detail_Order_List_Cell : UITableViewCell

//时间
@property(nonatomic,strong)UILabel *timeLabel;

//方向
@property(nonatomic,strong)UILabel *arrowLabel;

//价格
@property(nonatomic,strong)UILabel *priceLabel;

//数量
@property(nonatomic,strong)UILabel *numberLabel;

-(void)initWithCellModel:(Market_Chart_Detail_Deal_Model *)model;

@end
