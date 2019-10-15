//
//  GE_Trading_HistoryDelegateCell.m
//  SSKJ
//
//  Created by 张超 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Trading_HistoryDelegateCell.h"

@implementation GE_Trading_HistoryDelegateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.zuoduoLabel.font = [UIFont systemFontOfSize:ScaleW(16)];
    self.yuanyouLabel.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.timeLabel.font = [UIFont systemFontOfSize:ScaleW(13)];
    
    self.buyPriceLabel1.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.buyPriceLabel2.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.sellPriceLabel1.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.sellPriceLabel2.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.shoushuLabel1.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.shoushuLabel2.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.yingkuiLabel1.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.yingkuiLabel2.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.shouxufeiLabel1.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.shouxufeiLabel2.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.baozhengjinLabel1.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.baozhengjinLabel2.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.zhiyingLabel1.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.zhiyingLabel2.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.zhisunLabel1.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.zhisunLabel2.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.guoyefeiLabel1.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.guoyefeiLabel2.font = [UIFont systemFontOfSize:ScaleW(13)];

}

- (void)setDataWithModel:(GE_Trading_HistioryOrder_Model *)model type:(NSString *)str
{
    self.zuoduoLabel.text = model.otype.integerValue == 1 ? @"融资" : @"融券";
    
    self.zuoduoLabel.textColor = model.otype.integerValue == 1 ? RED_HEX_COLOR : GREEN_HEX_COLOR;
    
    self.yuanyouLabel.text = model.pname;
    
    self.timeLabel.text = [WLTools convertTimestamp:model.selltime.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.buyPriceLabel2.text = model.buyprice;
    
    self.sellPriceLabel2.text = model.sellprice;
    
    self.shoushuLabel2.text = model.buynum;
    
    self.yingkuiLabel2.text  = model.profit ? model.profit : @"0";
    
    if ([model.profit containsString:@"-"]) {
        
        self.yingkuiLabel2.textColor = GREEN_HEX_COLOR;
    }
    else
    {
        self.yingkuiLabel2.textColor = RED_HEX_COLOR;
    }
    
    self.shouxufeiLabel2.text = model.sxfee;
    
    self.baozhengjinLabel2.text = model.totalprice;
    
    self.zhiyingLabel2.text = model.stopProfitPrice;
    
    self.zhisunLabel2.text = model.stopLossPrice;
    
    self.guoyefeiLabel2.text = model.dayfee;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
