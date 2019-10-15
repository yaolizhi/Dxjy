//
//  Market_Chart_Detail_Price_Section_View.h
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Market_Main_List_Model.h"

@interface Market_Chart_Detail_Price_Section_View : UITableViewHeaderFooterView

@property(nonatomic,strong)UILabel *priceLabel;

@property(nonatomic,strong)UILabel *rateLabel;

@property(nonatomic,strong)UILabel *heightLabel;

@property(nonatomic,strong)UILabel *heightValueLabel;

@property(nonatomic,strong)UILabel *lowLabel;

@property(nonatomic,strong)UILabel *lowValueLabel;

@property(nonatomic,assign)BOOL isLightSkin;  //浅色皮肤

@property (nonatomic,strong)Market_Main_List_SocketProduct_Model *socketProductModel;

@property(nonatomic,strong)UILabel *cnyPriceLabel;

-(void)initWithSectionModel:(Market_Main_List_Model *)model;

@property (nonatomic, strong) UIView  *senctionView;

-(void)changeUIAction;

@end
