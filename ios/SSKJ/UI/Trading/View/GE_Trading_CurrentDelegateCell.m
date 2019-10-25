//
//  GE_Trading_CurrentDelegateCell.m
//  SSKJ
//
//  Created by 张超 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Trading_CurrentDelegateCell.h"

@implementation GE_Trading_CurrentDelegateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.zuoDuoLabel.font = [UIFont systemFontOfSize:ScaleW(16)];
    self.yuanYouLabel.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.stateLabel.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.typeLabel1.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.typeLabel2.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.weituoPriceLabel1.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.weituoPriceLabel2.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.weituoCountLabel1.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.weituoCountLabel2.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.chengJiaoLabel1.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.chengJiaoLabel2.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.chedanLabel1.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.chedanLabel2.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.timeLabel1.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.timeLabel2.font = [UIFont systemFontOfSize:ScaleW(13)];
    
}

- (void)setDataWithModel:(GE_Trading_HistioryOrder_Model *)model type:(NSString *)str
{
    self.zuoDuoLabel.text = model.otype.integerValue == 1 ? @"做多" : @"做空";
    
    self.zuoDuoLabel.textColor = model.buyBillType.integerValue == 1 ? RED_HEX_COLOR : GREEN_HEX_COLOR;
    
    self.yuanYouLabel.text = model.pname;
    
    self.timeLabel2.text = [WLTools convertTimestamp:model.selltime.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"];
    
//    self.typeLabel2.text = model.tradingType.integerValue == 0 ? @"建仓" : @"平仓";
//
//    self.weituoPriceLabel2.text = model.tradingType.integerValue == 0 ? model.price : @"市价";
    
    self.weituoCountLabel2.text = model.entrustCount;
    
    self.chengJiaoLabel2.text = model.entrustSuccessCount;
    
    self.chedanLabel2.text = @"0";
    
    //订单状态 1:已接收 2:待成交 3:已取消 4:已成交 5:已作废
//    switch (model.billStatus.integerValue) {
//        case 1:
//            self.stateLabel.text = @"已接收";
//            break;
//        case 2:
//            self.stateLabel.text = @"待成交";
//            break;
//        case 3:
//            self.stateLabel.text = @"已撤单";
//            self.chedanLabel2.text = model.entrustCount;
//            break;
//        case 4:
//            self.stateLabel.text = @"已成交";
//            break;
//        case 5:
//            self.stateLabel.text = @"已作废";
//            break;
//            
//        default:
//            break;
//    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
