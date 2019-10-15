//
//  GE_Mine_IntoPriceVC.m
//  SSKJ
//
//  Created by 张超 on 2019/3/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_IntoPriceVC.h"
#import "SHESelectTable.h"

#import "JA_Mine_IntoPrice_Web_VC.h"

#import "Mine_IntoPrice_Model.h"

#import "Mine_CreateQrcode_VC.h"

@interface GE_Mine_IntoPriceVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *yueLabel1;
@property (weak, nonatomic) IBOutlet UILabel *yueLabel2;
@property (weak, nonatomic) IBOutlet UILabel *bankCardTypeLabel1;
@property (weak, nonatomic) IBOutlet UILabel *bankCardTypeLabel2;
@property (weak, nonatomic) IBOutlet UILabel *ruJinUpLabel1;
@property (weak, nonatomic) IBOutlet UITextField *ruJinUpTextField;
@property (weak, nonatomic) IBOutlet UILabel *ruJinDownLabel1;
@property (weak, nonatomic) IBOutlet UILabel *ruJinDownLabel2;
@property (weak, nonatomic) IBOutlet UIButton *confimBtn;

@property (nonatomic, strong) NSMutableArray *bankArray;
@property (nonatomic, strong) NSMutableDictionary *bankDic;

@property (nonatomic, strong) NSMutableArray *wgBankList;//网关支付
@property (nonatomic, strong) NSMutableArray *kjBankList;//快捷支付
@property (nonatomic, assign) NSInteger index;//默认网关支付


@property (weak, nonatomic) IBOutlet UILabel *detailsLabel0;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel1;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel2;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel3;
@property (weak, nonatomic) IBOutlet UIView *xianXiaBgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *bankNumber;

@property (weak, nonatomic) IBOutlet UILabel *bankName;

@property (weak, nonatomic) IBOutlet UILabel *qqNumber;
@end

@implementation GE_Mine_IntoPriceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"入金";
    self.view.backgroundColor = kMainBackgroundColor;
    self.bankArray = [[NSMutableArray alloc] init];
    self.bankDic = [[NSMutableDictionary alloc] init];

    
    _yueLabel1.font = [UIFont systemFontOfSize:ScaleW(15)];
    _yueLabel2.font = [UIFont systemFontOfSize:ScaleW(15)];
    
    _bankCardTypeLabel1.font = [UIFont systemFontOfSize:ScaleW(15)];
    _bankCardTypeLabel2.font = [UIFont systemFontOfSize:ScaleW(15)];
    
    _ruJinUpLabel1.font = [UIFont systemFontOfSize:ScaleW(15)];
    _ruJinUpTextField.font = [UIFont systemFontOfSize:ScaleW(15)];
    _ruJinUpTextField.delegate = self;
    
    _ruJinDownLabel1.font = [UIFont systemFontOfSize:ScaleW(15)];
    _ruJinDownLabel2.font = [UIFont systemFontOfSize:ScaleW(15)];
    
    _confimBtn.titleLabel.font = [UIFont systemFontOfSize:ScaleW(16)];
    
    self.detailsLabel0.font = [UIFont systemFontOfSize:ScaleW(13)];
    self.detailsLabel0.text = SSKJLocalized(@"关于入金说明：", nil);
    self.detailsLabel1.font = [UIFont systemFontOfSize:ScaleW(12)];
    self.detailsLabel1.text = SSKJLocalized(@"1、入金时间：7*24小时；", nil);
    self.detailsLabel2.font = [UIFont systemFontOfSize:ScaleW(12)];
    self.detailsLabel2.text = SSKJLocalized(@"2、入金最低金额：50元 ；", nil);
    self.detailsLabel3.font = [UIFont systemFontOfSize:ScaleW(12)];
    self.detailsLabel3.text = SSKJLocalized(@"3、入金到账时间：30分钟；", nil);
    
    
    self.yueLabel2.text = [NSString stringWithFormat:@"¥%@",self.dataSource[@"wallone"]];
    
    [self requestIntoPriceInfoUrl];
    [self httpRequestWithBank];
    [self requrstbankListUrl];
    
    self.index = 3;
    
}

- (IBAction)nameAction:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.nameLabel.text;
    [MBProgressHUD showError:SSKJLocalized(@"户名复制成功", nil)];
}

- (IBAction)bankNumberAction:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.bankNumber.text;
    [MBProgressHUD showError:SSKJLocalized(@"账号复制成功", nil)];
}

- (IBAction)bankNameAction:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.bankName.text;
    [MBProgressHUD showError:SSKJLocalized(@"开户银行复制成功", nil)];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    NSString *new_text_str = [textField.text stringByReplacingCharactersInRange:range withString:string];
//
//    if (textField == self.ruJinUpTextField) {
//
//        NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
//        [futureString  insertString:string atIndex:range.location];
//        NSInteger flag=0;
//        const NSInteger limited = 2;//小数点后需要限制的个数
//        for (int i = futureString.length-1; i>=0; i--) {
//
//            if ([futureString characterAtIndex:i] == '.') {
//                if (flag > limited) {
//                    return NO;
//                }
//                break;
//            }
//            flag++;
//        }
//
//        _ruJinDownLabel2.text = [NSString stringWithFormat:@"%.2f",new_text_str.doubleValue / [SSKJ_User_Tool sharedUserTool].getInRate.doubleValue];
//
//    }
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    
                }
                    break;
                case 1:
                {
                    //银行卡类型
                    //出售币种
                    NSArray *seleArray=self.bankArray;
                    
                    static int  selectIndex;
                    
                    //获取某个控件在屏幕上的位置
                    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
                    CGRect rect=[_bankCardTypeLabel2 convertRect:_bankCardTypeLabel2.bounds toView:window];
                    
                    SHESelectTable *sTable=[[SHESelectTable alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withTableFrame:CGRectMake(cell.x+_bankCardTypeLabel2.x, rect.origin.y+ _bankCardTypeLabel2.frame.size.height, ScreenWidth - 100, ScreenHeight-rect.origin.y+_bankCardTypeLabel2.frame.size.height-Height_NavBar) withDataArray:seleArray withSelectindex:selectIndex];
                    sTable.selTable.frame = CGRectMake(cell.x+_bankCardTypeLabel2.x, rect.origin.y+_bankCardTypeLabel2.frame.size.height, ScreenWidth-100, ScreenHeight-rect.origin.y+_bankCardTypeLabel2.frame.size.height-Height_NavBar);
//                    44*seleArray.count
                    sTable.selTable.bounces = YES;
                    
                    //block回调
                    WS(weakSelf);
                    sTable.returnBlock=^(NSString *string)
                    {
                        if ([string isEqualToString:@"源泉网银支付"]) {
                            weakSelf.index = 1;
                            self.xianXiaBgView.hidden = YES;
                            self.confimBtn.hidden = NO;
                        }else if ([string isEqualToString:@"源泉快捷支付"]){
                            weakSelf.index = 2;
                            self.xianXiaBgView.hidden = YES;
                            self.confimBtn.hidden = NO;
                        }else if ([string isEqualToString:@"银联快捷支付"]){
                            weakSelf.index = 3;
                            self.xianXiaBgView.hidden = YES;
                            self.confimBtn.hidden = NO;
                        }else if ([string isEqualToString:@"银联扫码"]){
                            weakSelf.index = 4;
                            self.xianXiaBgView.hidden = YES;
                            self.confimBtn.hidden = NO;
                        }else{
                            weakSelf.index = 5;
                            self.xianXiaBgView.hidden = NO;
                            self.confimBtn.hidden = YES;
                        }
                        weakSelf.bankCardTypeLabel2.text = string;
                        
                        weakSelf.ruJinDownLabel2.text = @"选择银行";
                        
                        [weakSelf.tableView reloadData];
                    };
                    
                    //弹出select table
                    [[UIApplication sharedApplication].keyWindow addSubview:sTable];
                    [UIView animateWithDuration:0.2 animations:^{
                        
                        sTable.selTable.alpha=1;
                    }];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //银行卡类型
                    //出售币种
                    NSMutableArray *seleArray = [NSMutableArray array];
                    if (self.index == 1) {
                        for (Mine_IntoPrice_Model *model in self.wgBankList) {
                            [seleArray addObject:model.bankName];
                        }
                    }else if (self.index == 2) {
                        for (Mine_IntoPrice_Model *model in self.kjBankList) {
                            [seleArray addObject:model.bankName];
                        }
                    }
                    
                    
                    static int  selectIndex;
                    
                    //获取某个控件在屏幕上的位置
                    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
                    CGRect rect=[self.ruJinDownLabel2 convertRect:self.ruJinDownLabel2.bounds toView:window];
                    
                    SHESelectTable *sTable=[[SHESelectTable alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withTableFrame:CGRectMake(cell.x+self.ruJinDownLabel2.x, rect.origin.y+ self.ruJinDownLabel2.frame.size.height, ScreenWidth - 100, ScreenHeight-rect.origin.y+self.ruJinDownLabel2.frame.size.height-Height_NavBar) withDataArray:seleArray withSelectindex:selectIndex];
                    sTable.selTable.frame = CGRectMake(cell.x+self.ruJinDownLabel2.x - ScaleW(50), rect.origin.y+self.ruJinDownLabel2.frame.size.height, ScreenWidth-100, ScreenHeight-rect.origin.y+self.ruJinDownLabel2.frame.size.height-Height_NavBar);
                    //                    44*seleArray.count
                    sTable.selTable.bounces = YES;
                    
                    //block回调
                    WS(weakSelf);
                    sTable.returnBlock=^(NSString *string)
                    {
                        weakSelf.ruJinDownLabel2.text = string;
                    };
                    
                    //弹出select table
                    [[UIApplication sharedApplication].keyWindow addSubview:sTable];
                    [UIView animateWithDuration:0.2 animations:^{
                        
                        sTable.selTable.alpha=1;
                    }];
                    
                }
                    break;
                case 1:
                {
                    //入金金额（$）
                    
                }
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 1) {
                return ScaleW(50);
            }
            return ScaleW(50);
            
        }
            break;
        case 1:
        {
            if (self.index == 5) {
                return .0f;
            }
            
            if (indexPath.row == 0) {
                if (self.index == 3||self.index == 4) {
                    return ScaleW(1);
                }else{
                    return ScaleW(50);
                }
                
            }
            
            return ScaleW(50);
        }
            break;
        case 2:
        {
            return ScaleW(400);
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleW(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
    view.backgroundColor = kMainBackgroundColor;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}


//确认按钮
- (IBAction)confimBtnClick:(UIButton *)sender {
    
    if (_ruJinUpTextField.text.doubleValue == 0) {
        [MBProgressHUD showError:@"请填写入金金额"];
        return;
    }
    
    WS(weakSelf);
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:SSKJLocalized(@"提示", nil) message:SSKJLocalized(@"确定入金么", nil) preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:UIAlertActionStyleDefault handler:nil]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:SSKJLocalized(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf httpRequestWithChongZhi];

    }]];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
}

//获取展示信息
- (void)requestIntoPriceInfoUrl{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *params = @{@"key":@"xiangangjinan"};
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_Pingtai_info_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue== 200) {
            
            self.nameLabel.text = netModel.data[@"name"];
            
            self.bankNumber.text = netModel.data[@"account"];
            
            self.bankName.text = netModel.data[@"addr"];
            
            self.qqNumber.text = [NSString stringWithFormat:@"线下转账有疑问请咨询客服:QQ:%@或者关注:“%@”公众号",netModel.data[@"qq"],netModel.data[@"gongzh"]];
            
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        [hud hideAnimated:YES];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
    }];
}

//获取银行列表
- (void)requrstbankListUrl{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:[NSString stringWithFormat:@"%@/home/Payfinsaas/yq_bank_code",ProductBaseServer] RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200){
            self.wgBankList = [Mine_IntoPrice_Model mj_objectArrayWithKeyValuesArray:network_Model.data[@"wg_code"]];
            self.kjBankList = [Mine_IntoPrice_Model mj_objectArrayWithKeyValuesArray:network_Model.data[@"kj_code"]];
            
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
    }];
}

//获取可用支付通道
- (void)httpRequestWithBank
{
    NSDictionary *params = @{@"account":[SSKJ_User_Tool sharedUserTool].getAccount,
                             @"app":@"app",
                             @"action":@"getCardList",
                             @"sessionId":[SSKJ_User_Tool sharedUserTool].getToken,
                             @"systemType":@"IOS"
                             };
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:[NSString stringWithFormat:@"%@/home/Pay/payChannelList",ProductBaseServer] RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            NSArray *dataArr = network_Model.data;
            for (int i = 0; i<dataArr.count; i++) {
                NSDictionary *dic = dataArr[i];
//                if ([dic[@"p4_typeCode"] isEqualToString:@"pay.unionpay.native"]) {
//
//                }else{
                    [self.bankArray addObject:dic[@"p4_typeName"]];
                    [self.bankDic setObject:dic[@"p4_typeCode"] forKey:dic[@"p4_typeName"]];
//                }
                
            }
            [self.bankArray addObject:@"大额支付"];
            
            self.bankCardTypeLabel2.text = self.bankArray[0];
            
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
    }];
}

//入金下单
- (void)httpRequestWithChongZhi{
    NSString *paytype;
    if ([self.bankCardTypeLabel2.text isEqualToString:@"源泉网银支付"]) {
        paytype = @"pay.unionpay.wangyin";
    }else if ([self.bankCardTypeLabel2.text isEqualToString:@"源泉快捷支付"]){
        paytype = @"pay.unionpay.kuaijie";
    }else if ([self.bankCardTypeLabel2.text isEqualToString:@"银联快捷支付"]){
        paytype = @"pay.unionpay.wappay";
    }else if ([self.bankCardTypeLabel2.text isEqualToString:@"银联扫码"]){
        paytype = @"pay.unionpay.native";
    }
    
    NSString *bankcode;
    if (self.index == 1) {
        for (Mine_IntoPrice_Model *model in self.wgBankList) {
            if ([model.bankName isEqualToString:self.ruJinDownLabel2.text]) {
                bankcode = model.bankId;
            }
        }
    }else if (self.index == 2){
        for (Mine_IntoPrice_Model *model in self.kjBankList) {
            if ([model.bankName isEqualToString:self.ruJinDownLabel2.text]) {
                bankcode = model.bankId;
            }
        }
    }
    
    NSDictionary *params = @{
                             @"amount":_ruJinUpTextField.text,
                             @"paytype":paytype,
                             @"sebeitype":@"IOS",
                             @"bankcode":bankcode
                             };

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:[NSString stringWithFormat:@"%@/home/Payfinsaas/goldEntry",ProductBaseServer] RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            
//            [self httpRequestWithChongZhiWithPrice:network_Model.data[@"price"] orderID:network_Model.data[@"info"]];
            if (self.index == 3) {
                JA_Mine_IntoPrice_Web_VC *vc = [[JA_Mine_IntoPrice_Web_VC alloc]init];
    
                vc.urlStr= network_Model.data[@"info"];
    
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else if (self.index == 4) {
                Mine_CreateQrcode_VC *vc = [[Mine_CreateQrcode_VC alloc]init];
                vc.urlStr= network_Model.data[@"info"];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:network_Model.data[@"info"]]];
            }
            
            

        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
    }];
}

- (void)httpRequestWithChongZhiWithPrice:(NSString *)price orderID:(NSString *)orderID
{
    NSDictionary *params = @{@"account":[SSKJ_User_Tool sharedUserTool].getAccount,
                             @"token":[SSKJ_User_Tool sharedUserTool].getToken,
                             @"type":@(1),
                             @"amount":price,
                             @"outTradeNo":orderID
                             };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:[NSString stringWithFormat:@"%@/home/Trade/tradeCreate",ProductBaseServer] RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:network_Model.data]];
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
    }];
}

- (NSMutableArray *)wgBankList{
    if (_wgBankList == nil) {
        _wgBankList = [NSMutableArray array];
    }
    return _wgBankList;
}

- (NSMutableArray *)kjBankList{
    if (_kjBankList == nil) {
        _kjBankList = [NSMutableArray array];
    }
    return _kjBankList;
}

@end
