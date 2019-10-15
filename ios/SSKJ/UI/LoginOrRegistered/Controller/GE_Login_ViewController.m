//
//  GE_Login_ViewController.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Login_ViewController.h"

#import "GE_Register_ViewController.h"

#import "GE_Forget_Pwd_ViewController.h"

#import "AppDelegate.h"

@interface GE_Login_ViewController ()

@property (nonatomic,strong) UIButton * backBtn;

@property (nonatomic,strong) UIImageView *bgImg;

@property (nonatomic,strong) UIImageView *logoImg;

@property (nonatomic,strong) UILabel * huanyinglabel;

@property (nonatomic,strong) UIView *accountBGView;

@property (nonatomic,strong) UIImageView * accountImg;

@property (nonatomic,strong) UITextField * accountTextField;

@property (nonatomic,strong) UIView * pwdBGView;

@property (nonatomic,strong) UIImageView * pwdImg;

@property (nonatomic,strong) UITextField * pwdTextField;

@property (nonatomic,strong) UIButton * showBtn;

@property (nonatomic,strong) UIButton * loginBtn;

@property (nonatomic,strong) UIButton * forgetBtn;

@property (nonatomic,strong) UIButton * registerBtn;

@end

@implementation GE_Login_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kMainWihteColor;
    
    [self bgImg];
    
    [self logoImg];
    
    [self huanyinglabel];
    
    [self backBtn];
    
    [self accountBGView];
    
    [self accountImg];
    
    [self accountTextField];
    
    [self pwdBGView];
    
    [self pwdImg];
    
    [self showBtn];
    
    [self pwdTextField];
    
    [self loginBtn];
    
    [self registerBtn];
    
    [self forgetBtn];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}


- (UIImageView *)bgImg
{
    if (_bgImg == nil) {
        
        UIImage *image = [UIImage imageNamed:@"GE_Login_BGImg"];
        
        _bgImg = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@""];
        
        [self.view addSubview:_bgImg];
        
        [_bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.top.equalTo(@0);
            
            make.height.equalTo(@(ScaleH(image.size.height)));
            
        }];
    }
    return _bgImg;
}

- (UIImageView *)logoImg
{
    if (_logoImg == nil) {
        
        UIImage *image = [UIImage imageNamed:@"GE_Login_logo"];
        
        _logoImg = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@"GE_Login_logo"];
        
        [self.view addSubview:_logoImg];
        
        [_logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.view.mas_centerX);
            
            make.centerY.equalTo(self.bgImg.mas_centerY).offset(-ScaleH(30));
            
            make.height.equalTo(@(ScaleW(image.size.height)));
            
            make.width.equalTo(@(ScaleW(image.size.width)));
            
        }];
    }
    return _logoImg;
}
- (UILabel *)huanyinglabel
{
    if (_huanyinglabel == nil) {
        
        _huanyinglabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"登录交易系统" textColor:kMainDarkBlackColor font:systemFont(ScaleW(15))];
        
        _huanyinglabel.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:_huanyinglabel];
        
        [_huanyinglabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.view.mas_centerX);
            
            make.top.equalTo(self.logoImg.mas_bottom).offset(ScaleH(15));

            make.left.equalTo(@(ScaleW(0)));
            
            make.right.equalTo(@(ScaleW(0)));
            
        }];
    }
    return _huanyinglabel;
}


- (UIButton *)backBtn
{
    if (_backBtn == nil) {
        _backBtn = [FactoryUI createButtonWithFrame:CGRectZero title:nil titleColor:nil imageName:@"Login_Back_Img" backgroundImageName:nil target:self selector:@selector(backBtnAction) font:nil];
        
        [self.view addSubview:_backBtn];
        
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@30);
            
            make.left.equalTo(@0);
            
            make.width.height.equalTo(@50);
            
        }];
    }
    return _backBtn;
}

- (UIView *)accountBGView
{
    if (_accountBGView == nil) {
       
        _accountBGView = [FactoryUI createViewWithFrame:CGRectZero Color:UIColorFromRGB(0xF5F5F5)];
       
        _accountBGView.layer.borderColor = UIColorFromRGB(0xF5F5F5).CGColor;
        
        _accountBGView.layer.borderWidth = 1;
        
        _accountBGView.layer.cornerRadius = 5;
        
        _accountBGView.layer.masksToBounds = YES;
        
        [self.view addSubview:_accountBGView];
        
        [_accountBGView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.huanyinglabel.mas_bottom).offset(ScaleH(30));
            
            make.right.equalTo(@(-ScaleW(35)));
            
            make.height.equalTo(@(ScaleH(45)));
            
            make.left.equalTo(@(ScaleW(35)));
        }];
    }
    return _accountBGView;
}

- (UIImageView *)accountImg{
    if (_accountImg == nil) {
        
        UIImage *image = [UIImage imageNamed:@"Login_zhanghu"];
        
        _accountImg = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@"Login_zhanghu"];
        
        [self.accountBGView addSubview:_accountImg];
        
        [_accountImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(10)));
            make.centerY.equalTo(self.accountBGView.mas_centerY);
            make.width.equalTo(@(ScaleW(image.size.width)));
            make.height.equalTo(@(ScaleW(image.size.height)));
        }];
    }
    return _accountImg;
}

- (UITextField *)accountTextField
{
    if (_accountTextField == nil) {
        
        _accountTextField = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:@"请输入资金账号"];
        
        _accountTextField.keyboardType = UIKeyboardTypeDecimalPad;
        
        _accountTextField.textColor = kMainBlackColor;
        
        _accountTextField.font = systemFont(ScaleW(15));
        
        [self.accountBGView addSubview:_accountTextField];
        
        [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.right.equalTo(@0);
            
            make.left.equalTo(self.accountImg.mas_right).offset(ScaleW(10));
        }];
    }
    return _accountTextField;
}



- (UIView *)pwdBGView
{
    if (_pwdBGView == nil) {
        
        _pwdBGView = [FactoryUI createViewWithFrame:CGRectZero Color:UIColorFromRGB(0xF5F5F5)];
        
        _pwdBGView.layer.borderColor = UIColorFromRGB(0xF5F5F5).CGColor;
        
        _pwdBGView.layer.borderWidth = 1;
        
        _pwdBGView.layer.cornerRadius = 5;
        
        _pwdBGView.layer.masksToBounds = YES;
        
        [self.view addSubview:_pwdBGView];
        
        [_pwdBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.accountBGView.mas_bottom).offset(ScaleH(15));
            
            make.right.equalTo(@(-ScaleW(35)));
            
            make.height.equalTo(@(ScaleH(45)));
            
            make.left.equalTo(@(ScaleW(35)));
        }];
    }
    return _pwdBGView;
}

- (UIImageView *)pwdImg{
    if (_pwdImg == nil) {
        
        UIImage *image = [UIImage imageNamed:@"Login_mima"];
        
        _pwdImg = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@"Login_mima"];
        
        [self.pwdBGView addSubview:_pwdImg];
        
        [_pwdImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(10)));
            make.centerY.equalTo(self.pwdBGView.mas_centerY);
            make.width.equalTo(@(ScaleW(image.size.width)));
            make.height.equalTo(@(ScaleW(image.size.height)));
        }];
    }
    return _pwdImg;
}

- (UIButton *)showBtn
{
    if (_showBtn == nil) {
        _showBtn = [FactoryUI createButtonWithFrame:CGRectZero title:@"" titleColor:nil imageName:@"GE_Pwd_hippen" backgroundImageName:nil target:self selector:@selector(showBtnAcion) font:nil];
        
        [self.pwdBGView addSubview:_showBtn];
        
        [_showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.right.equalTo(@0);
            
            make.width.equalTo(@(ScaleW(40)));
        }];
    }
    return _showBtn;
}

- (UITextField *)pwdTextField
{
    if (_pwdTextField == nil) {
        
        _pwdTextField = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:@"8-12位字母和数字组合"];
        
        _pwdTextField.keyboardType = UIKeyboardTypeASCIICapable;
        
        _pwdTextField.textColor = kMainBlackColor;
        
        _pwdTextField.font = systemFont(ScaleW(15));
        
        _pwdTextField.secureTextEntry = YES;
        
        [self.pwdBGView addSubview:_pwdTextField];
        
        [_pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(@0);
            
            make.left.equalTo(self.pwdImg.mas_right).offset(ScaleW(10));

            make.right.equalTo(@(ScaleW(-40)));
        }];
    }
    return _pwdTextField;
}

- (UIButton *)loginBtn
{
    if (_loginBtn == nil) {
        
        _loginBtn = [FactoryUI createButtonWithFrame:CGRectZero title:@"登录" titleColor:kMainWihteColor imageName:nil backgroundImageName:nil target:self selector:@selector(loginBtnAction) font:systemFont(ScaleW(15))];
        
        _loginBtn.backgroundColor = kMainColor;
        
        _loginBtn.layer.cornerRadius = ScaleH(22.5);
        
        _loginBtn.layer.shadowOffset =  CGSizeMake(1, 1);
        
        _loginBtn.layer.shadowOpacity = 0.8;
        
        _loginBtn.layer.shadowColor =  kMainColor.CGColor;
        
        [self.view addSubview:_loginBtn];
        
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.pwdBGView.mas_bottom).offset(ScaleH(30));
            
            make.left.equalTo(@(ScaleW(35)));
            
            make.right.equalTo(@(ScaleW(-35)));
            
            make.height.equalTo(@(ScaleH(45)));
        }];
    }
    return _loginBtn;
}

- (UIButton *)registerBtn
{
    if (_registerBtn == nil) {
        
        _registerBtn = [FactoryUI createButtonWithFrame:CGRectZero title:@"立即注册" titleColor:kMainBlackColor imageName:nil backgroundImageName:nil target:self selector:@selector(registerBtnAction) font:systemFont(ScaleW(15))];
        
        [self.view addSubview:_registerBtn];
        
        [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.loginBtn.mas_bottom).offset(ScaleH(15));
            
            make.left.equalTo(@(ScaleW(35)));
            
            make.height.equalTo(@(ScaleH(40)));
            
            make.width.equalTo(@(ScaleH(80)));
        }];
    }
    return _registerBtn;
}

- (UIButton *)forgetBtn
{
    if (_forgetBtn == nil) {
        
        _forgetBtn = [FactoryUI createButtonWithFrame:CGRectZero title:@"忘记密码?" titleColor:kMainColor imageName:nil backgroundImageName:nil target:self selector:@selector(forgetBtnAction) font:systemFont(ScaleW(15))];
        
        [self.view addSubview:_forgetBtn];
        
        [_forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.loginBtn.mas_bottom).offset(ScaleH(15));
            
            make.right.equalTo(@(ScaleW(-35)));
            
            make.height.equalTo(@(ScaleH(40)));
            
            make.width.equalTo(@(ScaleH(80)));
        }];
    }
    return _forgetBtn;
}

- (void)backBtnAction
{
    if (self.formVC == 1) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

- (void)showBtnAcion
{
    if (!self.showBtn.selected)
    {
        [self.showBtn setImage:[UIImage imageNamed:@"GE_Pwd_Show"] forState:UIControlStateNormal];
        
        self.showBtn.selected = YES;
        
        self.pwdTextField.secureTextEntry = NO;
    }
    else
    {
        [self.showBtn setImage:[UIImage imageNamed:@"GE_Pwd_hippen"] forState:UIControlStateNormal];
        
        self.showBtn.selected = NO;
        
        self.pwdTextField.secureTextEntry = YES;
    }
    
}

- (void)loginBtnAction
{
    if (![RegularExpression validateMobile:self.accountTextField.text]) {
        
        [MBProgressHUD showError:@"请输入资金账号"];
        
        return;
    }
    
    if (![RegularExpression validatePassword:self.pwdTextField.text]) {
        
        [MBProgressHUD showError:@"请输入正确的密码"];
        
        return;
    }
    
    [self requestBull_Login_URL];
}

- (void)registerBtnAction
{
    GE_Register_ViewController *vc = [[GE_Register_ViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)forgetBtnAction
{
    GE_Forget_Pwd_ViewController *vc = [[GE_Forget_Pwd_ViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --- 登录请求 ---
- (void)requestBull_Login_URL
{
    NSDictionary *params = @{
                             @"mobile":self.accountTextField.text,
                             @"opwd":self.pwdTextField.text
                             };
    
//    NSLog(@"%@",GE_Login_URL);
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_Login_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model * model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (model.status.integerValue == 200)
        {
            SSKJ_Login_Model *loginModel = [SSKJ_Login_Model mj_objectWithKeyValues:model.data];
            
            loginModel.tel = self.accountTextField.text;
            
            [[SSKJ_User_Tool sharedUserTool] saveLoginInfoWithLoginModel:loginModel];
            
            if (self.formVC == 1) {
                
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                
                [delegate gotoMain];
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else
        {
            [MBProgressHUD showError:model.msg];
        }
        
        [hud hideAnimated:YES];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        NSLog(@"%@",error);
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
