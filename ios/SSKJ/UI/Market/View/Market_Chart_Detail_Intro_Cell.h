//
//  Market_Chart_Detail_Intro_Cell.h
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Market_Chart_Detail_Intro_Model.h"

@interface Market_Chart_Detail_Intro_Cell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *introTableView;

@property(nonatomic,strong)NSArray *array;

@property(nonatomic,strong)Market_Chart_Detail_Intro_Model *model;

-(void)initWithCellModel:(Market_Chart_Detail_Intro_Model *)model;

@end
