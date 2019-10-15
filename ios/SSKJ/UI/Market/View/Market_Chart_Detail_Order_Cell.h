//
//  Market_Chart_Detail_Order_Cell.h
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Market_Chart_Detail_Deal_Model.h"

@interface Market_Chart_Detail_Order_Cell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *orderTableView;

//成交数组
@property(nonatomic,strong)NSMutableArray<Market_Chart_Detail_Deal_Model *> *dealArray;

@property(nonatomic,copy)NSString *code;


-(void)initWithCellArrayModel:(NSMutableArray<Market_Chart_Detail_Deal_Model *> *)dealArray andCode:(NSString *)code;

@end
