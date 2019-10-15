//
//  ZiXuan_TableViewCell.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/5/9.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Market_Main_List_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZiXuan_TableViewCell : UITableViewCell

@property (nonatomic,strong) UIButton * deletedBtn;

@property(nonatomic,strong)UILabel *coinNameLabel;

@property(nonatomic,strong)UILabel *codeLabel;

@property(nonatomic,strong)UILabel *priceLabel;

@property(nonatomic,strong)UILabel *cnyLabel;

@property(nonatomic,strong)UIButton *rateButton;

@property(nonatomic,strong)UIView *lineView;

@property(nonatomic,strong)Market_Main_List_Model *model;

@property(nonatomic,copy)void (^OptionalDelBlock)(Market_Main_List_Model * model);

- (void)initDatawithModel:(Market_Main_List_Model *)model index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
