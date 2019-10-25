//
//  GE_Trading_ChiCang_View.m
//  SSKJ
//
//  Created by 张超 on 2019/4/1.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Trading_ChiCang_View.h"

@implementation GE_Trading_ChiCang_View

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _yuanYouLabel.font = [UIFont systemFontOfSize:ScaleW(14)];
    _zuoLabel.font = [UIFont systemFontOfSize:ScaleW(14)];
    
    _zhiYingLabel.font = [UIFont systemFontOfSize:ScaleW(14)];
    _zhiYingTextField.font = [UIFont systemFontOfSize:ScaleW(14)];
    
    _zhiSunLabel.font = [UIFont systemFontOfSize:ScaleW(14)];
    _zhiSunTextField.font = [UIFont systemFontOfSize:ScaleW(14)];
    
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:ScaleW(16)];
    
    
}

- (void)initModel:(GE_Trading_ChiCang_Model *)model
{
    self.model = model;
    [self requestGetGoodsDetail:model.code];
    
    self.yuanYouLabel.text = model.pname;
    
    self.zuoLabel.text = [NSString stringWithFormat:@"%@",[model.otype integerValue] == 1 ? @"做多" : @"做空"];
    
    self.zuoLabel.textColor = [model.otype integerValue] == 1 ? RED_HEX_COLOR : GREEN_HEX_COLOR;
    
    self.zhiYingTextField.text = model.stopProfitPrice;
    self.zhiSunTextField.text = model.stopLossPrice;
}

//确认
- (IBAction)confimBtnClick:(UIButton *)sender {
 
/*
    做多：
    止盈范围：止盈价 > 最新价+最小止盈点位*最小变动价
    提示：“止盈价必须大于计算出来的”
    止损范围：止损价 < 最新价 - 最小止损点位*最小变动价
    提示：“止损价必须小于计算出来”
    做空：
    止盈范围：止盈价 < 最新价 - 最小止盈点位*最小变动价
    提示：“止盈价必须小于计算出来的”
    止损范围：止损价 > 最新价 + 最小止损点位*最小变动价
    提示：“止损价必须大于计算出来”
 */
    
    //止盈价
    double zhiYingPrice = self.zhiYingTextField.text.doubleValue;
    //止损价
    double zhiSunPrice = self.zhiSunTextField.text.doubleValue;
    //最新价
    NSString *priceStr = [NSString stringWithFormat:@"%.3f",self.stockModel.price.doubleValue];
    double price = priceStr.doubleValue;
    //最小变动价
    double minChange = self.stockModel.jggd.doubleValue;
    //最小止盈点位
    double minZhiYing = self.stockModel.stopProfit.doubleValue;
    //最小止损点位
    double minZhiSun = self.stockModel.stopLoss.doubleValue;
    
    if ([self.zuoLabel.text containsString:@"做多"]) {
        
//        做多：
//        止盈范围：止盈价 > 最新价+最小止盈点位*最小变动价
//        提示：“止盈价必须大于计算出来的”
//        止损范围：止损价 < 最新价 - 最小止损点位*最小变动价
//        提示：“止损价必须小于计算出来”
        
        if (zhiYingPrice <= (price + minZhiYing * minChange)) {
            if (zhiYingPrice>0) {
                [MBProgressHUD showError:[NSString stringWithFormat:@"止盈价必须大于%.3f",price + minZhiYing * minChange]];
                return;
            }
        }else if (zhiSunPrice >= (price - minZhiSun * minChange)) {
            if (zhiSunPrice>0) {
                [MBProgressHUD showError:[NSString stringWithFormat:@"止损价必须小于%.3f",price - minZhiSun * minChange]];
                return;
            }
        }
        
    }else if ([self.zuoLabel.text containsString:@"做空"]){
        
//        做空：
//        止盈范围：止盈价 < 最新价 - 最小止盈点位*最小变动价
//        提示：“止盈价必须小于计算出来的”
//        止损范围：止损价 > 最新价 + 最小止损点位*最小变动价
//        提示：“止损价必须大于计算出来”
        
        if (zhiYingPrice >= (price - minZhiYing * minChange)) {
            if (zhiYingPrice>0) {
                [MBProgressHUD showError:[NSString stringWithFormat:@"止盈价必须小于%.3f",price - minZhiYing * minChange]];
                return;
            }
            
        }else if (zhiSunPrice <= (price + minZhiSun * minChange)){
            if (zhiSunPrice>0) {
                [MBProgressHUD showError:[NSString stringWithFormat:@"止损价必须大于%.3f",price + minZhiSun * minChange]];
                return;
            }
        }
    }
    
    
//    if (self.zhiYingTextField.text.length == 0) {
//        [MBProgressHUD showError:@"请输入止盈价"];
//        return;
//    }else if (self.zhiSunTextField.text.length == 0){
//        [MBProgressHUD showError:@"请输入止损价"];
//        return;
//    }
    
    [self httpRequest];
    
}

//头像上传
- (void)httpRequest
{
    NSDictionary *params = @{@"account":[SSKJ_User_Tool sharedUserTool].getAccount,
                             @"app":@"app",
                             @"action":@"stockCountManage",
                             @"sessionId":[SSKJ_User_Tool sharedUserTool].getToken,
                             @"systemType":@"IOS",
                             @"id":self.model.hold_id,
                             @"stopLossPrice":_zhiSunTextField.text.length?_zhiSunTextField.text:@"0",
                             @"stopProfitPrice":_zhiYingTextField.text.length?_zhiYingTextField.text:@"0"
                             };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:[NSString stringWithFormat:@"%@",ProductBaseURL] RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            if (self.sureBtnBlock) {
                self.sureBtnBlock();
            }
            [MBProgressHUD showError:network_Model.msg];
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
    }];
    
}


#pragma mark --- 获取单个商品详情 ---
- (void)requestGetGoodsDetail:(NSString *)code
{
    
    NSDictionary *params = @{@"action":@"oneStockInfo",
                             @"account":[[SSKJ_User_Tool sharedUserTool] getAccount],
                             @"stockCode":code,
                             @"sessionId":[[SSKJ_User_Tool sharedUserTool] getToken]
                             };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self  animated:YES];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_Pubilc_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *networkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        //        NSLog(@"获取单个商品详情 %@",networkModel.data);
        if (networkModel.status.integerValue == 200) {
            self.stockModel = [GE_Trading_OneStock_Model mj_objectWithKeyValues:networkModel.data[0]];
        }else{
            [MBProgressHUD showError:networkModel.msg];
        }
        [hud hideAnimated:YES];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        //        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
}


@end
