//
//  Market_Chart_Detail_Intro_detail_Cell.h
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Market_Main_List_Model.h"

@interface Market_Chart_Detail_Intro_detail_Cell : UITableViewCell

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong)UILabel *contentLabel;

-(void)initWitCellModel:(Market_Main_List_Model *)model;


@end
