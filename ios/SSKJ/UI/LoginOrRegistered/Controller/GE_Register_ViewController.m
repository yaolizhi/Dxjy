//
//  GE_Register_ViewController.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Register_ViewController.h"

#import "VerifyCodeButton.h"

#import "GE_Forget_Pwd_ViewController.h"

#import "Register_BG_View.h"

#import "BLUserProtocolViewController.h"

@interface GE_Register_ViewController ()
@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIButton * backBtn;

@property (nonatomic,strong) UIButton * loginBtn;

@property (nonatomic,strong) UILabel * titlelabel;

@property (nonatomic,strong) Register_BG_View *nameBgView;

@property (nonatomic,strong) Register_BG_View *accountBgView;

@property (nonatomic,strong) Register_BG_View *codeBgView;

@property (nonatomic,strong) Register_BG_View *pwdBgView;

@property (nonatomic,strong) Register_BG_View *surePwdBgView;

@property (nonatomic,strong) Register_BG_View *yqBgView;

@property (nonatomic,strong) UIButton * tongyiBtn;

@property (nonatomic,strong) UIButton * xieyiBtn;

//确认
@property (nonatomic,strong) UIButton * sureBtn;

@property (nonatomic,assign) NSInteger index;//判断用户是否同意协议


@end

@implementation GE_Register_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self scrollView];
    
    [self backBtn];
    
    [self loginBtn];
    
    [self titlelabel];
    
    [self nameBgView];
    
    [self accountBgView];
    
    [self codeBgView];
    
    [self pwdBgView];
    
    [self surePwdBgView];
    
    [self yqBgView];
    
    [self tongyiBtn];
    
    [self xieyiBtn];
    
    [self sureBtn];
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.sureBtn.bottom + ScaleW(50));
    
    self.index = 1;
    
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

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        
        _scrollView.backgroundColor = kMainWihteColor;
        
        if (@available(iOS 11.0, *))
        {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        [self.view addSubview:_scrollView];
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self.view);
        }];
    }
    return _scrollView;
}

- (UIButton *)backBtn
{
    if (_backBtn == nil) {
        _backBtn = [FactoryUI createButtonWithFrame:CGRectMake(ScaleW(5), Height_StatusBar + ScaleW(15), ScaleW(50), ScaleW(50)) title:nil titleColor:nil imageName:@"Login_Back_Img" backgroundImageName:nil target:self selector:@selector(backBtnAction) font:nil];

        [self.scrollView addSubview:_backBtn];
    }
    return _backBtn;
}

- (UIButton *)loginBtn
{
    if (_loginBtn == nil) {
        _loginBtn = [FactoryUI createButtonWithFrame:CGRectMake(ScreenWidth - ScaleW(55), Height_StatusBar + ScaleW(15), ScaleW(50), ScaleW(50)) title:SSKJLocalized(@"登录", nil) titleColor:kMainColor imageName:@"" backgroundImageName:nil target:self selector:@selector(backBtnAction) font:nil];
        
        [self.scrollView addSubview:_loginBtn];
    }
    return _loginBtn;
}

- (UILabel *)titlelabel
{
    if (_titlelabel == nil) {

        _titlelabel = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(20), self.backBtn.bottom + ScaleW(20), ScreenWidth - ScaleW(40), ScaleW(20)) text:SSKJLocalized(@"用户注册", nil) textColor:kMainBlackColor font:WLFontBoldSize(ScaleW(18))];
        _titlelabel.textAlignment = NSTextAlignmentLeft;
        [self.scrollView addSubview:_titlelabel];
    }
    return _titlelabel;
}

- (Register_BG_View *)nameBgView{
    if (_nameBgView == nil) {
        _nameBgView = [[Register_BG_View alloc]initWithFrame:CGRectMake(0, self.titlelabel.bottom + ScaleW(40), ScreenWidth, ScaleW(80)) titleStr:SSKJLocalized(@"姓名", nil) textStr:@"" placeholderStr:@"请输入您的姓名"];
        _nameBgView.codeBtn.hidden = YES;
        _nameBgView.showBtn.hidden = YES;
        _nameBgView.textField.keyboardType = UIKeyboardTypeDefault;
        [self.scrollView addSubview:_nameBgView];
    }
    return _nameBgView;
}

- (Register_BG_View *)accountBgView{
    if (_accountBgView == nil) {
        _accountBgView = [[Register_BG_View alloc]initWithFrame:CGRectMake(0, self.nameBgView.bottom, ScreenWidth, ScaleW(80)) titleStr:SSKJLocalized(@"登录账号", nil) textStr:@"" placeholderStr:@"请输入您的资金账号"];
        _accountBgView.codeBtn.hidden = YES;
        _accountBgView.showBtn.hidden = YES;
        _accountBgView.textField.keyboardType = UIKeyboardTypeNumberPad;
        [self.scrollView addSubview:_accountBgView];
    }
    return _accountBgView;
}

- (Register_BG_View *)codeBgView{
    if (_codeBgView == nil) {
        _codeBgView = [[Register_BG_View alloc]initWithFrame:CGRectMake(0, self.accountBgView.bottom, ScreenWidth, ScaleW(80)) titleStr:SSKJLocalized(@"验证码", nil) textStr:@"" placeholderStr:@"请输入验证码"];
        _codeBgView.showBtn.hidden = YES;
        _codeBgView.textField.keyboardType = UIKeyboardTypeNumberPad;
        [_codeBgView.codeBtn addTarget:self action:@selector(codeBtnVerification:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:_codeBgView];
    }
    return _codeBgView;
}

- (Register_BG_View *)pwdBgView{
    if (_pwdBgView == nil) {
        _pwdBgView = [[Register_BG_View alloc]initWithFrame:CGRectMake(0, self.codeBgView.bottom, ScreenWidth, ScaleW(80)) titleStr:SSKJLocalized(@"账号密码", nil) textStr:@"" placeholderStr:@"请设置8-12位字母、数字组合密码"];
        _pwdBgView.codeBtn.hidden = YES;
        _pwdBgView.textField.secureTextEntry = YES;
        [self.scrollView addSubview:_pwdBgView];
    }
    return _pwdBgView;
}

- (Register_BG_View *)surePwdBgView{
    if (_surePwdBgView == nil) {
        _surePwdBgView = [[Register_BG_View alloc]initWithFrame:CGRectMake(0, self.pwdBgView.bottom, ScreenWidth, ScaleW(80)) titleStr:SSKJLocalized(@"重复密码", nil) textStr:@"" placeholderStr:@"请再次输入密码"];
        _surePwdBgView.codeBtn.hidden = YES;
        _surePwdBgView.textField.secureTextEntry = YES;
        [self.scrollView addSubview:_surePwdBgView];
    }
    return _surePwdBgView;
}

- (Register_BG_View *)yqBgView{
    if (_yqBgView == nil) {
        _yqBgView = [[Register_BG_View alloc]initWithFrame:CGRectMake(0, self.surePwdBgView.bottom, ScreenWidth, ScaleW(80)) titleStr:SSKJLocalized(@"邀请码(必填)", nil) textStr:@"" placeholderStr:@"请输入邀请码"];
        _yqBgView.codeBtn.hidden = YES;
        _yqBgView.showBtn.hidden = YES;
        [self.scrollView addSubview:_yqBgView];
    }
    return _yqBgView;
}

- (UIButton *)tongyiBtn
{
    if (_tongyiBtn == nil) {
        
        _tongyiBtn = [FactoryUI createButtonWithFrame:CGRectMake(ScaleW(20), self.yqBgView.bottom + ScaleW(10), ScaleW(130), ScaleW(20)) title:SSKJLocalized(@" 提交注册即认为同意", nil) titleColor:kMainDarkBlackColor imageName:@"Retister_tongyi_seleted" backgroundImageName:nil target:self selector:@selector(tongyiBtnAction) font:systemFont(ScaleW(12))];
        
        _tongyiBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [self.scrollView addSubview:_tongyiBtn];
    }
    return _tongyiBtn;
}

- (UIButton *)xieyiBtn
{
    if (_xieyiBtn == nil) {
        
        _xieyiBtn = [FactoryUI createButtonWithFrame:CGRectMake(self.tongyiBtn.maxX, self.yqBgView.bottom + ScaleW(10), ScaleW(100), ScaleW(20)) title:SSKJLocalized(@"《用户注册协议》", nil) titleColor:kMainColor imageName:@"" backgroundImageName:nil target:self selector:@selector(xieyiBtnAcion) font:systemFont(ScaleW(12))];
        
        _xieyiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [self.scrollView addSubview:_xieyiBtn];
    }
    return _xieyiBtn;
}


#pragma mark -- 提交
- (UIButton *)sureBtn
{
    if (_sureBtn == nil) {
        _sureBtn = [FactoryUI createButtonWithFrame:CGRectMake(ScaleW(20), self.tongyiBtn.bottom + ScaleW(40), ScreenWidth - ScaleW(40), ScaleW(45)) title:SSKJLocalized(@"提交注册", nil) titleColor:kMainWihteColor imageName:nil backgroundImageName:nil target:self selector:@selector(sureBtnAction) font:systemFont(ScaleW(15))];

        _sureBtn.backgroundColor = kMainColor;

        _sureBtn.layer.cornerRadius = ScaleW(5);

        _sureBtn.layer.shadowOffset =  CGSizeMake(1, 1);

        _sureBtn.layer.shadowOpacity = 0.8;

        _sureBtn.layer.shadowColor =  kMainColor.CGColor;

        [self.scrollView addSubview:_sureBtn];
    }
    return _sureBtn;
}

- (void)backBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

//同意按钮点击事件
- (void)tongyiBtnAction
{
    if (self.index == 1) {
        [self.tongyiBtn setImage:[UIImage imageNamed:@"Retister_tongyi_Normal"] forState:UIControlStateNormal];
        
        self.index = 0;
    }
    else
    {
        [self.tongyiBtn setImage:[UIImage imageNamed:@"Retister_tongyi_seleted"] forState:UIControlStateNormal];
        
        self.index = 1;
    }
}

//用户注册协议
- (void)xieyiBtnAcion
{
    BLUserProtocolViewController *protocolVC = [[BLUserProtocolViewController alloc] init];
    
    [self.navigationController pushViewController:protocolVC animated:YES];
}

// 获取验证码点击事件
- (void)codeBtnVerification:(UIButton *)sender {

    if (![RegularExpression validateMobile:self.accountBgView.textField.text]) {

        [MBProgressHUD showError:@"请输入资金账号"];
    }
    else
    {
        [self requestGetMobileCode];
    }
}

- (void)sureBtnAction
{
    if (self.pwdBgView.textField.text.length == 0) {
        [MBProgressHUD showError:@"请输入您的姓名"];
        return;
    }

    
    if (![RegularExpression validateMobile:self.accountBgView.textField.text]) {

        [MBProgressHUD showError:@"请输入资金账号"];

        return;
    }

    if (self.codeBgView.textField.text.length != 6) {

        [MBProgressHUD showError:@"请输入验证码"];

        return;
    }

    if (self.pwdBgView.textField.text.length == 0) {
        [MBProgressHUD showError:@"请输入登录密码"];
        return;
    }

    if (![RegularExpression validatePassword:self.pwdBgView.textField.text]) {

        [MBProgressHUD showError:@"请输入8-12位字母和数字组合密码"];

        return;
    }

    if (![self.pwdBgView.textField.text isEqualToString:self.surePwdBgView.textField.text]) {

        [MBProgressHUD showError:@"两次密码输入不一致"];

        return;
    }

    if (self.yqBgView.textField.text.length == 0)
    {
        [MBProgressHUD showError:@"请输入邀请码"];

        return;
    }

    [self requestRegisterUrl];

}
#pragma mark === 获取验证码 ---
- (void)requestGetMobileCode
{
    NSDictionary *params = @{@"mobile":self.accountBgView.textField.text,
                             @"type":@"1"};

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_GetCode_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {

        WL_Network_Model *model = [WL_Network_Model mj_objectWithKeyValues:responseObject];

        if (model.status.integerValue == 200) {

            [MBProgressHUD showError:@"发送成功"];

            [self.codeBgView.codeBtn timeFailBeginFrom:60];  // 倒计时60s
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


#pragma mark -- 注册 ---
- (void)requestRegisterUrl
{
    NSDictionary *params = @{@"tjuser":self.yqBgView.textField.text,
                             @"mobile":self.accountBgView.textField.text,
                             @"opwd":self.pwdBgView.textField.text,
                             @"opwd1":self.surePwdBgView.textField.text,
                             @"code":self.codeBgView.textField.text,
                             @"username":self.nameBgView.textField.text
                             };

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_Register_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {

        WL_Network_Model *model = [WL_Network_Model mj_objectWithKeyValues:responseObject];

        if (model.status.integerValue == 200) {

            [MBProgressHUD showError:@"注册成功"];

            [self.navigationController popViewControllerAnimated:YES];
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
