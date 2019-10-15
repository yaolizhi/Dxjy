//
//  Market_Index_List_Cell.h
//  ZYW_MIT
//
//  Created by James on 2018/8/22.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Market_Main_List_Model.h"

@interface Market_Index_List_Cell : UITableViewCell

@property(nonatomic,strong)UILabel *coinNameLabel;

@property(nonatomic,strong)UILabel *codeLabel;

@property(nonatomic,strong)UILabel *priceLabel;

@property(nonatomic,strong)UILabel *cnyLabel;

@property(nonatomic,strong)UIButton *rateButton;

@property(nonatomic,strong)UIView *lineView;

-(void)initWithCellModel:(Market_Main_List_Model *)model;

@end
