//
//  GE_Mine_Withdrawal_VC.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_Withdrawal_VC.h"

#import "GE_Mine_Withdrawal_View.h"

#import "GE_Mine_AccountRecord_Model.h"

#import "GE_Mine_SysSet_Model.h"

@interface GE_Mine_Withdrawal_VC ()

@property (nonatomic,strong) GE_Mine_Withdrawal_View * keyongView;

@property (nonatomic,strong) GE_Mine_Withdrawal_View * banktypeView;

@property (nonatomic,strong) GE_Mine_Withdrawal_View * bankCodeView;

@property (nonatomic,strong) GE_Mine_Withdrawal_View * cnyPriceView;

@property (nonatomic,strong) GE_Mine_Withdrawal_View * priceView;

@property (nonatomic,strong) UILabel * feeLabel;

@property (nonatomic,strong) UILabel * totalPrice;

@property (nonatomic,assign) double fee;


//确认
@property (nonatomic,strong) UIButton * sureBtn;

@property (nonatomic,assign) CGFloat  keyongPrice;;


@end

@implementation GE_Mine_Withdrawal_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"出金";
    
    [self keyongView];
    
    [self banktypeView];
    
    [self bankCodeView];
    
    [self cnyPriceView];
    
    [self feeLabel];
    
    [self totalPrice];
    
    [self priceView];
    
    [self sureBtn];
    
    [self requestAccountInfoUrl];
    //出售手续费
    [self httpRequestWithFee];
    
    
}

- (GE_Mine_Withdrawal_View *)keyongView
{
    if (_keyongView == nil) {
        _keyongView = [[GE_Mine_Withdrawal_View alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, ScaleH(50))];
        
        _keyongView.titleLabel.text = @"可用余额(¥)";
        
        _keyongView.detailtextField.textColor = kMainColor;
        
        _keyongView.detailtextField.enabled = NO;
        
        _keyongView.detailtextField.text = @"0.00";
        
        [self.view addSubview:_keyongView];
    }
    return _keyongView;
}

- (GE_Mine_Withdrawal_View *)banktypeView
{
    if (_banktypeView == nil) {
        _banktypeView = [[GE_Mine_Withdrawal_View alloc]initWithFrame:CGRectMake(0, ScaleH(61), ScreenWidth, ScaleH(50))];
        
        _banktypeView.titleLabel.text = @"银行卡类型";
        
        _banktypeView.detailtextField.enabled = NO;
        
        [self.view addSubview:_banktypeView];
    }
    return _banktypeView;
}

- (GE_Mine_Withdrawal_View *)bankCodeView
{
    if (_bankCodeView == nil) {
        _bankCodeView = [[GE_Mine_Withdrawal_View alloc]initWithFrame:CGRectMake(0, ScaleH(112), ScreenWidth, ScaleH(50))];
        
        _bankCodeView.titleLabel.text = @"银行卡号码";
        
        _bankCodeView.detailtextField.enabled = NO;
        
        [self.view addSubview:_bankCodeView];
    }
    return _bankCodeView;
}

- (GE_Mine_Withdrawal_View *)cnyPriceView
{
    if (_cnyPriceView == nil) {
        
        _cnyPriceView = [[GE_Mine_Withdrawal_View alloc]initWithFrame:CGRectMake(0, ScaleH(173), ScreenWidth, ScaleH(50))];
        
        _cnyPriceView.titleLabel.text = @"出金金额(￥)";
        
        [_cnyPriceView.detailtextField addTarget:self action:@selector(textFiedValueChanged:) forControlEvents:(UIControlEventEditingChanged)];

        _cnyPriceView.detailtextField.keyboardType = UIKeyboardTypeDecimalPad;
        
        _cnyPriceView.detailtextField.enabled = YES;
        
        _cnyPriceView.detailtextField.placeholder = @"请输入出金金额";
        
        [_cnyPriceView.detailtextField addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
        
        [self.view addSubview:_cnyPriceView];
    }
    return _cnyPriceView;
}

- (UILabel *)feeLabel
{
    if (_feeLabel == nil) {
        _feeLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kMainBlackColor font:systemFont(14)];
        
        [self.view addSubview:_feeLabel];
        
        [_feeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(@(ScaleW(-10)));
            
            make.top.equalTo(self.cnyPriceView.mas_bottom).offset(ScaleW(10));
        }];
    }
    return _feeLabel;
}

- (UILabel *)totalPrice
{
    if (_totalPrice == nil) {
        _totalPrice = [FactoryUI createLabelWithFrame:CGRectZero text:@"实到金额(¥):" textColor:kMainBlackColor font:systemFont(14)];
        
        [self.view addSubview:_totalPrice];
        
        [_totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@(ScaleW(10)));
            
            make.top.equalTo(self.cnyPriceView.mas_bottom).offset(ScaleW(10));
        }];
    }
    return _totalPrice;
}

- (GE_Mine_Withdrawal_View *)priceView
{
    if (_priceView == nil) {
        _priceView = [[GE_Mine_Withdrawal_View alloc]initWithFrame:CGRectMake(0,ScaleH(224) , ScreenWidth, ScaleH(50))];
        
        _priceView.titleLabel.text = @"";
        
        _priceView.detailtextField.enabled = NO;
        
        _priceView.detailtextField.placeholder = @"--";
        
        [self.view addSubview:_priceView];
        
        _priceView.hidden = YES;
    }
    return _priceView;
}

#pragma mark -- 提交
- (UIButton *)sureBtn
{
    if (_sureBtn == nil) {
        
        _sureBtn = [FactoryUI createButtonWithFrame:CGRectZero title:@"确认" titleColor:kMainWihteColor imageName:nil backgroundImageName:nil target:self selector:@selector(sureBtnAction) font:systemFont(ScaleW(15))];
        
        _sureBtn.backgroundColor = kMainColor;
        
        _sureBtn.layer.cornerRadius = ScaleH(5);
        
        _sureBtn.layer.shadowOffset =  CGSizeMake(1, 1);
        
        _sureBtn.layer.shadowOpacity = 0.8;
        
        _sureBtn.layer.shadowColor =  kMainColor.CGColor;
        
        [self.view addSubview:_sureBtn];
        
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.priceView.mas_bottom).offset(ScaleH(50));
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.right.equalTo(@(ScaleW(-15)));
            
            make.height.equalTo(@(ScaleH(45)));
            
        }];
    }
    return _sureBtn;
}

-(void)changedTextField:(id)textField
{
   
}

- (void)sureBtnAction
{
    [self requestOurPriceUrl];
}

- (void)textFiedValueChanged:(UITextField *)textField
{
    self.totalPrice.text = [NSString stringWithFormat:@"实到金额(¥):%.2f",self.cnyPriceView.detailtextField.text.doubleValue - self.cnyPriceView.detailtextField.text.doubleValue * self.fee / 100];
}


- (void)requestOurPriceUrl
{
    if (self.cnyPriceView.detailtextField.text.length == 0) {

        [MBProgressHUD showError:@"请输入出金金额"];

        return;

    }

    NSDictionary *params = @{@"amount":self.cnyPriceView.detailtextField.text};
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:[NSString stringWithFormat:@"%@/home/Pay/goldYield",ProductBaseServer] RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
//        NSLog(@"%@",responseObject);
        
        WL_Network_Model * model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (model.status.integerValue == 200)
        {
            [MBProgressHUD showError:@"您的出金申请正在审核中，请耐心等待"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [MBProgressHUD showError:model.msg];
        }
        
        [hud hideAnimated:YES];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
}

#pragma mark --- 账户明细 ---
- (void)requestAccountInfoUrl
{
    NSDictionary *params = @{@"account":[[SSKJ_User_Tool sharedUserTool] getAccount]
                             };
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_Pubilc_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model * model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (model.status.integerValue == 200)
        {
            
            self.keyongPrice = [model.data[@"wallone"] doubleValue];
            
            self.keyongView.detailtextField.text = model.data[@"wallone"];
            
            self.banktypeView.detailtextField.text = model.data[@"cardType"];
            
            self.bankCodeView.detailtextField.text =model.data[@"cardAccount"];
        }
        else
        {
            [MBProgressHUD showError:model.msg];
        }
        
        [hud hideAnimated:YES];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
}

//出售手续费
- (void)httpRequestWithFee
{
    NSDictionary *params = @{@"amount":self.cnyPriceView.detailtextField.text};
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:[NSString stringWithFormat:@"%@/home/Pay/getGoldYieldFee",ProductBaseServer] RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        //        NSLog(@"%@",responseObject);
        
        WL_Network_Model * model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (model.status.integerValue == 200)
        {
            weakSelf.fee = [model.data[@"gold_yield_fee"] doubleValue];
            
            weakSelf.feeLabel.text = [NSString stringWithFormat:@"手续费 %@%@",model.data[@"gold_yield_fee"],@"%"] ;
        }
        else
        {
            [MBProgressHUD showError:model.msg];
        }
        
        [hud hideAnimated:YES];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        //        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
}

@end
