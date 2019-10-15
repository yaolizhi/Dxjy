//
//  GE_Trading_ChiCang_Cell.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GE_Trading_ChiCang_Model.h"

typedef void(^SetBtnBlock)(void);

typedef NS_ENUM(NSUInteger,ChiCangTableViewCellStyle)
{
    ChiCangTableViewCellStyleChiCang,
    ChiCangTableViewCellStyleGuaDan,
};

@protocol getSellOrBuyProtocol<NSObject>

-(void)sellOrBuyData:(GE_Trading_ChiCang_Model *)model style:(ChiCangTableViewCellStyle)style view:(UIView *)view;

@end

NS_ASSUME_NONNULL_BEGIN

@interface GE_Trading_ChiCang_Cell : UITableViewCell

@property (nonatomic, copy) SetBtnBlock setBtnBlock;


//设置数据
-(void)setDataFrom:(GE_Trading_ChiCang_Model *)data style:(ChiCangTableViewCellStyle)style;

//平仓卖出撤单代理
@property(nonatomic,weak)id<getSellOrBuyProtocol>delegate;

@end

NS_ASSUME_NONNULL_END
