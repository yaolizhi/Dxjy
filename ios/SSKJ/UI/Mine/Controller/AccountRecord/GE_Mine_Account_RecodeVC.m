//
//  GE_Mine_Account_RecodeVC.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_Account_RecodeVC.h"

#import "GE_Mine_AccountRecode_View.h"

#import "GE_Mine_AccountRecord_Model.h"

@interface GE_Mine_Account_RecodeVC ()

@property (nonatomic,strong) GE_Mine_AccountRecode_View * accountView;

@property (nonatomic,strong) GE_Mine_AccountRecode_View * coinView;

@property (nonatomic,strong) GE_Mine_AccountRecode_View * totalView;

@property (nonatomic,strong) GE_Mine_AccountRecode_View * keyongView;

@property (nonatomic,strong) GE_Mine_AccountRecode_View * yidongView;

@property (nonatomic,strong) GE_Mine_AccountRecode_View * biliView;

@end

@implementation GE_Mine_Account_RecodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"账户明细";
    
    [self accountView];
    
    [self coinView];
    
    [self totalView];
    
    [self keyongView];
    
    [self yidongView];
    
    [self biliView];
    
    [self requestGE_getuserinfo_URL];
}

- (GE_Mine_AccountRecode_View *)accountView
{
    if (_accountView == nil) {
        _accountView = [[GE_Mine_AccountRecode_View alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(50))];
        
        _accountView.titleLabel.text = @"账户:";
        
        [self.view addSubview:_accountView];
    }
    return _accountView;
}

- (GE_Mine_AccountRecode_View *)coinView
{
    if (_coinView == nil) {
        _coinView = [[GE_Mine_AccountRecode_View alloc]initWithFrame:CGRectMake(0, ScaleH(51), ScreenWidth, ScaleH(50))];
        
        _coinView.titleLabel.text = @"币种:";
        
        [self.view addSubview:_coinView];
    }
    return _coinView;
}

- (GE_Mine_AccountRecode_View *)totalView
{
    if (_totalView == nil) {
        _totalView = [[GE_Mine_AccountRecode_View alloc]initWithFrame:CGRectMake(0, ScaleH(102), ScreenWidth, ScaleH(50))];
        
        _totalView.titleLabel.text = @"可用资金:";
        
        [self.view addSubview:_totalView];
    }
    return _totalView;
}

- (GE_Mine_AccountRecode_View *)keyongView
{
    if (_keyongView) {
        _keyongView = [[GE_Mine_AccountRecode_View alloc]initWithFrame:CGRectMake(0, ScaleH(153), ScreenWidth, ScaleH(50))];
        
        _keyongView.titleLabel.text = @"维持担保比例:";
        
        [self.view addSubview:_keyongView];
    }
    return _keyongView;
}

- (GE_Mine_AccountRecode_View *)yidongView
{
    if (_yidongView) {
        _yidongView = [[GE_Mine_AccountRecode_View alloc]initWithFrame:CGRectMake(0,ScaleH(204) , ScreenWidth, ScaleH(50))];
        
        _yidongView.titleLabel.text = @"维持担保比例:";
        
        [self.view addSubview:_yidongView];
    }
    return _yidongView;
}

- (GE_Mine_AccountRecode_View *)biliView
{
    if (_biliView) {
        _biliView = [[GE_Mine_AccountRecode_View alloc]initWithFrame:CGRectMake(0,ScaleH(255) , ScreenWidth, ScaleH(50))];
        
        _biliView.titleLabel.text = @"强平比例:";
        
        [self.view addSubview:_biliView];
    }
    return _biliView;
}

#pragma mark --- 账户明细 ---
- (void)requestGE_getuserinfo_URL
{
//    NSDictionary *params = @{@"account":[[SSKJ_User_Tool sharedUserTool] getAccount]};
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_getuserinfo_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == 200)
        {
            SSKJ_UserInfo_Model *model = [SSKJ_UserInfo_Model mj_objectWithKeyValues:netModel.data];
            
            [[SSKJ_User_Tool sharedUserTool] saveUserInfoWithUserInfoModel:model];
            
            weakSelf.accountView.detailLabel.text = model.account;
            
            weakSelf.coinView.detailLabel.text = model.coin_type;
            
            weakSelf.totalView.detailLabel.text = model.wallone;
            
            weakSelf.keyongView.detailLabel.text = [NSString stringWithFormat:@"%@%@",model.guarantee_rate,@"%"];
            
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
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
