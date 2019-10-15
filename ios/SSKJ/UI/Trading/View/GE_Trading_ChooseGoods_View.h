//
//  GE_Trading_ChooseGoods_View.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GE_Trading_goodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GE_Trading_ChooseGoods_View : UIView

@property(nonatomic,copy)void (^ChooseGoodsBlock)(GE_Trading_goodsModel * model);

@property (nonatomic,strong) NSArray *dataSource;
@end

NS_ASSUME_NONNULL_END
