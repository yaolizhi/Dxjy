//
//  GE_Trading_Buy_Cell.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GE_Trading_goodsModel.h"

#import "GE_Trading_OneStock_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface GE_Trading_Buy_Cell : UITableViewCell

@property (nonatomic,strong) UIViewController *vc;

@property (nonatomic,strong) UILabel * nowPriceLabel;

@property (nonatomic,strong) UITextField * priceTextField;

@property(nonatomic,copy)void (^BuyOrderBlock)(NSDictionary * index);

@property (nonatomic,strong) GE_Trading_OneStock_Model *oneStockModel;//单只股票详情

@property (nonatomic,copy) NSString * price;

@property (nonatomic,copy) NSString * changeRate;
@end

NS_ASSUME_NONNULL_END
