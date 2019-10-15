//
//  GE_Mine_EditPwd_VC.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_EditPwd_VC.h"

#import "VerifyCodeButton.h"

#import "GE_Login_ViewController.h"

@interface GE_Mine_EditPwd_VC ()

//手机号
@property (nonatomic,strong) UIView *phoneBgView;

@property (nonatomic,strong) UILabel *phoneTitle;

@property (nonatomic,strong) UITextField *phoneTextField;

//验证码
@property (nonatomic,strong) UIView *codeBgView;

@property (nonatomic,strong) UILabel *codeTitle;

@property (nonatomic,strong) UITextField *codeTextField;

@property (nonatomic,strong) VerifyCodeButton * codeBtn;

@property (nonatomic,strong) UIView *lineView;

//登录密码
@property (nonatomic,strong) UIView *pwdBgView;

@property (nonatomic,strong) UILabel *pwdTitle;

@property (nonatomic,strong) UITextField *pwdTextField;

//确认密码
@property (nonatomic,strong) UIView *secondBgView;

@property (nonatomic,strong) UILabel *secondTitle;

@property (nonatomic,strong) UITextField *secondTextField;

@property (nonatomic,strong) UIButton *sureBtn;

@end

@implementation GE_Mine_EditPwd_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改登录密码";
    
    [self phoneBgView];
    
    [self phoneTitle];
    
    [self phoneTextField];
    
    [self codeBgView];
    
    [self codeTitle];
    
    [self codeBtn];
    
    [self lineView];
    
    [self codeTextField];
    
    [self pwdBgView];
    
    [self pwdTitle];
    
    [self pwdTextField];
    
    [self secondBgView];
    
    [self secondTitle];
    
    [self secondTextField];
    
    [self sureBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (UIView *)phoneBgView
{
    if (_phoneBgView == nil) {
        
        _phoneBgView = [FactoryUI createViewWithFrame:CGRectZero Color:UIColorFromRGB(0xffffff)];
        
        [self.view addSubview:_phoneBgView];
        
        [_phoneBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@(0));
            
            make.height.equalTo(@(ScaleH(50)));
            
            make.left.right.equalTo(@(0));
        }];
    }
    return _phoneBgView;
}

- (UILabel *)phoneTitle
{
    if (_phoneTitle == nil) {
        
        _phoneTitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"手机号" textColor:kMainBlackColor font:systemFont(ScaleW(15))];
        
        [self.phoneBgView addSubview:_phoneTitle];
        
        [_phoneTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.phoneBgView.mas_centerY);
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.width.equalTo(@(ScaleW(70)));
            
            make.height.equalTo(@(ScaleH(15)));
        }];
    }
    return _phoneTitle;
}

- (UITextField *)phoneTextField
{
    if (_phoneTextField == nil) {
        
        _phoneTextField = [FactoryUI createTextFieldWithFrame:CGRectZero text:[[SSKJ_User_Tool sharedUserTool]getMobile] placeHolder:@""];
        
        _phoneTextField.keyboardType = UIKeyboardTypeDecimalPad;
        
        _phoneTextField.enabled = NO;
        
        _phoneTextField.textColor = kMainBlackColor;
        
        _phoneTextField.font = systemFont(ScaleW(15));
        
        [self.phoneBgView addSubview:_phoneTextField];
        
        [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.right.equalTo(@0);
            
            make.left.equalTo(self.phoneTitle.mas_right).offset(ScaleW(15));
        }];
    }
    return _phoneTextField;
}

- (UIView *)codeBgView
{
    if (_codeBgView == nil) {
        
        _codeBgView = [FactoryUI createViewWithFrame:CGRectZero Color:UIColorFromRGB(0xffffff)];
        
        [self.view addSubview:_codeBgView];
        
        [_codeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.phoneBgView.mas_bottom).offset(1);
            
            make.height.equalTo(@(ScaleH(50)));
            
            make.left.right.equalTo(@(0));
        }];
    }
    return _codeBgView;
}

- (UILabel *)codeTitle
{
    if (_codeTitle == nil) {
        
        _codeTitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"验证码" textColor:kMainBlackColor font:systemFont(ScaleW(15))];
        
        [self.codeBgView addSubview:_codeTitle];
        
        [_codeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.codeBgView.mas_centerY);
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.width.equalTo(@(ScaleW(70)));
            
            make.height.equalTo(@(ScaleH(15)));
        }];
    }
    return _codeTitle;
}

- (VerifyCodeButton *)codeBtn
{
    if (_codeBtn == nil) {
        
        _codeBtn = [VerifyCodeButton buttonWithType:UIButtonTypeCustom];
        
        _codeBtn.backgroundColor = kMainWihteColor;
        
        [_codeBtn addTarget:self action:@selector(codeBtnVerification:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.codeBgView addSubview:_codeBtn];
        
        [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.bottom.top.equalTo(@0);
            
            make.width.equalTo(@90);
        }];
    }
    return _codeBtn;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        
        _lineView = [FactoryUI createViewWithFrame:CGRectZero Color:kMainColor];
        
        [self.codeBgView addSubview:_lineView];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.codeBtn.mas_left).offset(ScaleH(-5));
            
            make.centerY.equalTo(self.codeBgView.mas_centerY);
            
            make.height.equalTo(@(ScaleH(15)));
            
            make.width.equalTo(@(ScaleW(1)));
            
        }];
    }
    return _lineView;
}

- (UITextField *)codeTextField
{
    if (_codeTextField == nil) {
        
        _codeTextField = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:@"请输入短信验证码"];
        
        _codeTextField.keyboardType = UIKeyboardTypeDecimalPad;
        
        _codeTextField.textColor = kMainBlackColor;
        
        _codeTextField.font = systemFont(ScaleW(15));
        
        [self.codeBgView addSubview:_codeTextField];
        
        [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(@0);
            
            make.right.equalTo(@(ScaleW(-100)));
            
            make.left.equalTo(self.phoneTitle.mas_right).offset(ScaleW(15));
        }];
    }
    return _codeTextField;
}

- (UIView *)pwdBgView
{
    if (_pwdBgView == nil) {
        
        _pwdBgView = [FactoryUI createViewWithFrame:CGRectZero Color:UIColorFromRGB(0xffffff)];
        
        [self.view addSubview:_pwdBgView];
        
        [_pwdBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.codeBgView.mas_bottom).offset(1);
            
            make.height.equalTo(@(ScaleH(50)));
            
            make.left.right.equalTo(@(0));
        }];
    }
    return _pwdBgView;
}

- (UILabel *)pwdTitle
{
    if (_pwdTitle == nil) {
        
        _pwdTitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"登录密码" textColor:kMainBlackColor font:systemFont(ScaleW(15))];
        
        [self.pwdBgView addSubview:_pwdTitle];
        
        [_pwdTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.pwdBgView.mas_centerY);
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.width.equalTo(@(ScaleW(70)));
            
            make.height.equalTo(@(ScaleH(15)));
        }];
    }
    return _pwdTitle;
}

- (UITextField *)pwdTextField
{
    if (_pwdTextField == nil) {
        
        _pwdTextField = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:@"请输入新登录密码"];
        
        _pwdTextField.keyboardType = UIKeyboardTypeASCIICapable;
        
        _pwdTextField.textColor = kMainBlackColor;
        
        _pwdTextField.secureTextEntry = YES;
        
        _pwdTextField.font = systemFont(ScaleW(15));
        
        [self.pwdBgView addSubview:_pwdTextField];
        
        [_pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.right.equalTo(@0);
            
            make.left.equalTo(self.pwdTitle.mas_right).offset(ScaleW(15));
        }];
    }
    return _pwdTextField;
}

- (UIView *)secondBgView
{
    if (_secondBgView == nil) {
        
        _secondBgView = [FactoryUI createViewWithFrame:CGRectZero Color:UIColorFromRGB(0xffffff)];
        
        [self.view addSubview:_secondBgView];
        
        [_secondBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.pwdBgView.mas_bottom).offset(1);
            
            make.height.equalTo(@(ScaleH(50)));
            
            make.left.right.equalTo(@(0));
        }];
    }
    return _secondBgView;
}

- (UILabel *)secondTitle
{
    if (_secondTitle == nil) {
        
        _secondTitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"确认密码" textColor:kMainBlackColor font:systemFont(ScaleW(15))];
        
        [self.secondBgView addSubview:_secondTitle];
        
        [_secondTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.secondBgView.mas_centerY);
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.width.equalTo(@(ScaleW(70)));
            
            make.height.equalTo(@(ScaleH(15)));
        }];
    }
    return _secondTitle;
}

- (UITextField *)secondTextField
{
    if (_secondTextField == nil) {
        
        _secondTextField = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:@"请再次输入登录密码"];
        
        _secondTextField.keyboardType = UIKeyboardTypeASCIICapable;
        
        _secondTextField.secureTextEntry = YES;
        
        _secondTextField.textColor = kMainBlackColor;
        
        _secondTextField.font = systemFont(ScaleW(15));
        
        [self.secondBgView addSubview:_secondTextField];
        
        [_secondTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.right.equalTo(@0);
            
            make.left.equalTo(self.secondTitle.mas_right).offset(ScaleW(15));
        }];
    }
    return _secondTextField;
}

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
            
            make.top.equalTo(self.secondBgView.mas_bottom).offset(ScaleH(50));
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.right.equalTo(@(ScaleW(-15)));
            
            make.height.equalTo(@(ScaleH(45)));
        }];
    }
    return _sureBtn;
}

// 获取验证码点击事件
- (void)codeBtnVerification:(UIButton *)sender {
    
    if (![RegularExpression validateMobile:self.phoneTextField.text]) {
        
        [MBProgressHUD showError:@"请输入资金账号"];
        
        return;
    }
    
    [self requestGetMobileCode];
}

- (void)sureBtnAction
{
    if (![RegularExpression validateMobile:self.phoneTextField.text]) {
        
        [MBProgressHUD showError:@"请输入新资金账号"];
        
        return;
    }
    
    if (self.codeTextField.text.length != 6) {
        
        [MBProgressHUD showError:@"请输入验证码"];
        
        return;
    }
    
    if (![RegularExpression validatePassword:self.pwdTextField.text]) {
        
        [MBProgressHUD showError:@"请输入登录密码"];
        
        return;
    }
    
    if (![self.pwdTextField.text isEqualToString:self.secondTextField.text]) {
        
        [MBProgressHUD showError:@"两次密码输入不一致"];
        
        return;
    }
    
    [self requestGE_xiugai_pwd_URL];
    
}

#pragma mark === 获取验证码 ---
- (void)requestGetMobileCode
{
    NSDictionary *params = @{@"mobile":self.phoneTextField.text,
                             @"type":@"9"};
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_GetCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model *model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (model.status.integerValue == 200) {
            
            [MBProgressHUD showError:@"发送成功"];
            
            [self.codeBtn timeFailBeginFrom:60];  // 倒计时60s
        }
        else
        {
            [MBProgressHUD showError:model.msg];
        }
        
        [hud hideAnimated:YES];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
    }];
}

#pragma mark -- 修改登录密码 ---
- (void)requestGE_xiugai_pwd_URL
{
    NSDictionary *params = @{
                             @"mobile":self.phoneTextField.text,
                             @"code":self.codeTextField.text,
                             @"opwd":self.pwdTextField.text,
                             @"opwd1":self.secondTextField.text
                             };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_xiugai_pwd_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model *model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (model.status.integerValue == 200) {
            
            [MBProgressHUD showError:@"修改成功"];
            
            [SSKJ_User_Tool clearUserInfo];
            
            GE_Login_ViewController *vc = [[GE_Login_ViewController alloc]init];
            
            vc.formVC = 1;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            [MBProgressHUD showError:model.msg];
        }
        
        [hud hideAnimated:YES];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
