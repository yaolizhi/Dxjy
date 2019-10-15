//
//  GE_Mine_Setting_VC.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_Setting_VC.h"

#import "GE_Mine_EditPwd_VC.h"

#import "BFEX_System_Version_View.h"

#import "BFEX_System_Version_Model.h"
#import "GE_Login_ViewController.h"

@interface GE_Mine_Setting_VC ()

@property (nonatomic,strong) UIView * pwdBGView;

@property (nonatomic,strong) UILabel * pwdLabel;

@property (nonatomic,strong) UIImageView * rightImg;

@property (nonatomic,strong) UIView * versionBGView;

@property (nonatomic,strong) UILabel * versionLabel;

@property (nonatomic,strong) UILabel * versionTitle;

//版本更新
@property(nonatomic,strong)BFEX_System_Version_View *versionView;
@property(nonatomic,strong)BFEX_System_Version_Model *versionModel;

@end

@implementation GE_Mine_Setting_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
    [self pwdBGView];
    
    [self pwdLabel];
    
    [self rightImg];
    
    [self versionBGView];
    
    [self versionTitle];
    
    [self versionLabel];
}

- (UIView *)pwdBGView
{
    if (_pwdBGView == nil)
    {
        _pwdBGView = [FactoryUI createViewWithFrame:CGRectZero Color:kMainWihteColor];
        
        _pwdBGView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pwdAction)];
        
        [_pwdBGView addGestureRecognizer:tap];
        
        [self.view addSubview:_pwdBGView];
        
        [_pwdBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.right.equalTo(@0);
            
            make.height.equalTo(@(ScaleH(50)));
            
        }];
    }
    return _pwdBGView;
}

- (UILabel *)pwdLabel
{
    if (_pwdLabel == nil) {
        
        _pwdLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"登录密码" textColor:kMainBlackColor font:systemFont(ScaleW(15))];
        
        [self.pwdBGView addSubview:_pwdLabel];
        
        [_pwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.pwdBGView.mas_centerY);
            
            make.height.equalTo(@(ScaleH(15)));
            
            make.left.equalTo(@(ScaleW(15)));
        }];
        
    }
    return _pwdLabel;
}

- (UIImageView *)rightImg
{
    if (_rightImg == nil) {
        _rightImg = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@"GE_Mine_Right_jiantou"];
        
        [self.pwdBGView addSubview:_rightImg];
        
        [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.pwdBGView.mas_centerY);
            
            make.right.equalTo(@(ScaleW(-15)));
        }];
    }
    return _rightImg;
}

- (UIView *)versionBGView
{
    if (_versionBGView == nil)
    {
        _versionBGView = [FactoryUI createViewWithFrame:CGRectZero Color:kMainWihteColor];
        
        _versionBGView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkVersion)];
        
        [_versionBGView addGestureRecognizer:tap];
        
        [self.view addSubview:_versionBGView];
        
        [_versionBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(@0);
            
            make.top.equalTo(self.pwdBGView.mas_bottom).offset(1);
            
            make.height.equalTo(@(ScaleH(50)));
            
        }];
    }
    return _versionBGView;
}

- (UILabel *)versionTitle
{
    if (_versionTitle == nil) {
        
        _versionTitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"版本管理" textColor:kMainBlackColor font:systemFont(ScaleW(15))];
        
        [self.versionBGView addSubview:_versionTitle];
        
        [_versionTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.versionBGView.mas_centerY);
            
            make.height.equalTo(@(ScaleH(15)));
            
            make.left.equalTo(@(ScaleW(15)));
        }];
        
    }
    return _versionTitle;
}

- (UILabel *)versionLabel
{
    if (_versionLabel == nil) {
        
        _versionLabel = [FactoryUI createLabelWithFrame:CGRectZero text:[NSString stringWithFormat:@"V%@",AppVersion] textColor:kMainBlackColor font:systemFont(ScaleW(15))];
        
        [self.versionBGView addSubview:_versionLabel];
        
        [_versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.versionBGView.mas_centerY);
            
            make.right.equalTo(@(ScaleW(-15)));
        }];
        
    }
    return _versionLabel;
}



- (void)pwdAction
{
    
    if ([SSKJ_User_Tool sharedUserTool].getAccount.length == 0) {
        BLAlertView *alertView = [[BLAlertView alloc] initWithTitle:SSKJLocalized(@"未登录", nil) message:SSKJLocalized(@"请先登录账号", nil) sureBtn:SSKJLocalized(@"登录", nil) cancleBtn:SSKJLocalized(@"取消", nil)];
        
        //        WS(weakSelf);
        
        alertView.cancelBlock = ^(NSString *message)
        {
            //LSLog(Localized(@"取消登录", nil));
        };
        
        alertView.sureBlock = ^(NSString *message)
        {
            GE_Login_ViewController *vc = [[GE_Login_ViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        [alertView showBLAlertView];
        return;
    }
    
    GE_Mine_EditPwd_VC *VC = [[GE_Mine_EditPwd_VC alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 检测版本更新
- (void)checkVersion
{
    NSDictionary *params = @{@"account":[SSKJ_User_Tool sharedUserTool].getAccount,
                             @"version":AppVersion,
                             @"type":@(2),
                             };
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_CheckVersion_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            weakSelf.versionModel=[BFEX_System_Version_Model mj_objectWithKeyValues:network_Model.data];
            
            if ([weakSelf.versionModel.version compare:AppVersion options:NSCaseInsensitiveSearch] > 0)
            {
                [weakSelf.versionView hide:NO];
                
                if (weakSelf.versionModel.uptype.integerValue == YES) //强制更新
                {
                    weakSelf.versionView.cancelButton.hidden=YES;
                    
                    weakSelf.versionView.lineView.hidden=YES;
                    
                    [weakSelf.versionView.sureButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(weakSelf.versionView.mainView.mas_left);
                        
                        make.right.equalTo(weakSelf.versionView.mainView.mas_right);
                        
                        make.height.equalTo(@50);
                        
                        make.bottom.equalTo(weakSelf.versionView.mainView.mas_bottom);
                    }];
                }
                else
                {
                    weakSelf.versionView.lineView.hidden=NO;
                    
                    weakSelf.versionView.cancelButton.hidden=NO;
                    
                    [weakSelf.versionView.sureButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(weakSelf.versionView.cancelButton.mas_right);
                        
                        make.right.equalTo(weakSelf.versionView.mainView.mas_right);
                        
                        make.top.equalTo(weakSelf.versionView.cancelButton.mas_top);
                        
                        make.width.equalTo(weakSelf.versionView.cancelButton.mas_width);
                        
                        make.bottom.equalTo(weakSelf.versionView.cancelButton.mas_bottom);
                    }];
                    
                }
                
                
                [weakSelf.versionView initWithTitle:weakSelf.versionModel.title andMessage:weakSelf.versionModel.content version:weakSelf.versionModel.version];
                
                [weakSelf.versionView hide:NO];
            }
            else
            {
                [MBProgressHUD showError:@"当前是最新版本"];
            }
            
        }else{
            
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        //        NSLog(@"%@",error);
    }];
    
}

#pragma mark - 版本更新
-(BFEX_System_Version_View *)versionView
{
    if (_versionView==nil)
    {
        _versionView=[[BFEX_System_Version_View alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        WS(weakSelf);
        
        _versionView.sureButtonBlock = ^{
            
            [weakSelf upgrade_Button_Event];
        };
        _versionView.hidden = YES;
        
        [[UIApplication sharedApplication].keyWindow addSubview:_versionView];
    }
    
    return _versionView;
}

#pragma mark - 版本更新控制 立即更新 事件
-(void)upgrade_Button_Event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.versionModel.addr]];
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
