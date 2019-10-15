//
//  Market_Chart_Detail_Intro_List_Cell.h
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Market_Main_List_Model.h"

@interface Market_Chart_Detail_Intro_List_Cell : UITableViewCell

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *valueLabel;

@property(nonatomic,strong)UIView *lineView;

-(void)initWithCellModel:(Market_Main_List_Model *)model andTitle:(NSString *)title andIndexPath:(NSIndexPath *)indexPath;

@end
