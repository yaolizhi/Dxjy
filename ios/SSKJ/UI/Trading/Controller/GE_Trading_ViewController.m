//
//  GE_Trading_ViewController.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Trading_ViewController.h"

#import "GE_Trading_Buy_ViewController.h"

#import "GE_Trading_Sell_ViewController.h"

#import "Ge_Trading_List_ViewController.h"

#import "GE_Trading_ChiCang_ViewController.h"

#import "Ge_Trading_Query_ViewController.h"

#import "GE_Trading_headerView.h"

#import "GE_Mine_AccountRecord_Model.h"


@interface GE_Trading_ViewController ()<NinaPagerViewDelegate>

@property (nonatomic, strong) NinaPagerView *ninaPagerView;

@property (nonatomic, strong) GE_Trading_Buy_ViewController *buyVC;//买入

@property (nonatomic, strong) GE_Trading_Sell_ViewController *sellVC;//卖出

@property (nonatomic, strong) Ge_Trading_List_ViewController *listVC;//挂单

@property (nonatomic, strong) GE_Trading_ChiCang_ViewController *chicangVC;//持仓

@property (nonatomic, strong) Ge_Trading_Query_ViewController *queryVC;//查询

@property (nonatomic, strong) GE_Trading_headerView * headerView;//头部试图


@end

@implementation GE_Trading_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"交易" ;
    
    self.view.backgroundColor = kMainBackgroundColor;
    
    [self headerView];
    
    [self addninaPagerView:0];
    
    //刷新头部信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestAccountInfoUrl) name:@"requestAccountInfoUrl" object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    
//    [self requestSysSetUrl];
    
    if ([kLogined integerValue] == 1) {
        
        [self requestAccountInfoUrl];
    }
    
    if ([ManagerGlobeUntil sharedManager].goodsCode.length>0) {
        [self notificationClickedNotifa:nil];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [ManagerGlobeUntil sharedManager].DefalutSeleted = nil;
}

#pragma mark - 通知函数
-(void)notificationClickedNotifa:(NSNotification *)nitifa
{
    [self addninaPagerView:[ManagerGlobeUntil sharedManager].DefalutSeleted];
}

-(void)addninaPagerView:(NSInteger)index
{
    self.buyVC = [[GE_Trading_Buy_ViewController alloc]init];
    
    self.sellVC = [[GE_Trading_Sell_ViewController alloc]init];
    
    self.listVC = [[Ge_Trading_List_ViewController alloc]init];
    
    self.chicangVC = [[GE_Trading_ChiCang_ViewController alloc]init];
    
    self.queryVC = [[Ge_Trading_Query_ViewController alloc]init];
    
    NSArray *controllers=@[_buyVC,
                           _sellVC,
                           _chicangVC,
                           _queryVC,
                           ];
    
    NSArray *titleArray =@[@"融资",
                           @"融券",
                           @"持仓",
                           @"成交",
                           ];
    _ninaPagerView = [[NinaPagerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar - Height_TabBar) WithTitles:titleArray WithObjects:controllers];
    
    _ninaPagerView.topTabBackGroundColor = kMainWihteColor;
    
    _ninaPagerView.delegate = self;
    
    _ninaPagerView.topTabHeight = 50;
    
    _ninaPagerView.titleFont = 15;
    
    _ninaPagerView.ninaDefaultPage = index;
    
    _ninaPagerView.sliderBlockColor = UIColorFromRGB(0xbbbbbb);
    
    _ninaPagerView.underlineColor = kMainColor;
    
    _ninaPagerView.selectTitleColor = kMainColor;
    
    [self.view addSubview:_ninaPagerView];
}

- (GE_Trading_headerView *)headerView
{
    if (_headerView == nil) {
        
        _headerView = [[GE_Trading_headerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 75)];
        
        WS(weakSelf);
        
        _headerView.bcTapBlock = ^(NSString * index) {
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"爆仓率说明" message:[NSString stringWithFormat:@"当爆仓率<=%@%@时,系统会自动强平",[[SSKJ_User_Tool sharedUserTool] getCloseOutRate],@"%"] preferredStyle:UIAlertControllerStyleAlert];
                        
            [alertVC addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }]];
            
            [weakSelf presentViewController:alertVC animated:YES completion:nil];
            
//            NSString *msg = [NSString stringWithFormat:@"%@<=%@%@",ZBLocalized(@"当爆仓率", nil),weakSelf.trans_ware,ZBLocalized(@"系统会自动强平", nil)];
//
//            BLAlertView *alert = [[BLAlertView alloc] initWithTitle:ZBLocalized(@"爆仓率说明", nil) message:msg sureBtn:ZBLocalized(@"我知道了", nil) cancleBtn:nil];
//
//            alert.sureBlock = ^(NSString *message) {};
//
//            [alert showBLAlertView];
        };
        
        [self.view addSubview:_headerView];
        
        _headerView.hidden = YES;
    }
    return _headerView;
}


- (void)ninaCurrentPageIndex:(NSInteger)currentPage currentObject:(id)currentObject lastObject:(id)lastObject {
    
//    NSLog(@"Current page is %ld",currentPage);
    switch (currentPage) {
        case 0:
//            NSLog(@"买入");
            self.buyVC.BuyRefreshBlock(1);
            break;
        case 1:
//            NSLog(@"卖出");
            self.sellVC.SellRefreshBlock(1);
            break;
        case 2:
//            NSLog(@"持仓");
            self.chicangVC.ChiCangRefreshBlock(1);
            break;
        case 3:
        {
//            NSLog(@"持仓");
            self.queryVC.ChengJiaoRefreshBlock(1);
        }
            
            break;
//        case 4:
////            NSLog(@"持仓");
//            break;
            
        default:
            break;
    }
}

//账户明细
- (void)requestAccountInfoUrl
{
    NSDictionary *params = @{@"action":@"accountInfo",
                             @"account":[[SSKJ_User_Tool sharedUserTool] getAccount],
                             @"sessionId":[[SSKJ_User_Tool sharedUserTool] getToken]};
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_Pubilc_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
//        NSLog(@"%@",responseObject);
        
        WL_Network_Model * model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (model.status.integerValue == 200)
        {
            GE_Mine_AccountRecord_Model *dataModel = [GE_Mine_AccountRecord_Model mj_objectWithKeyValues:model.data[@"stockUserInfo"]];
            
            [self.headerView setDataWithDic:dataModel];
            
        }
        else
        {
            [MBProgressHUD showError:model.msg];
        }
        
//        [hud hideAnimated:YES];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        NSLog(@"%@",error);
//        [hud hideAnimated:YES];
    }];
}

#pragma mark --- 交易设置信息 ---
- (void)requestSysSetUrl
{
    NSDictionary *params = @{@"action":@"sysSet",
                             @"account":[[SSKJ_User_Tool sharedUserTool] getAccount],
                             @"sessionId":[[SSKJ_User_Tool sharedUserTool] getToken]
                             };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_Pubilc_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        //        NSLog(@"%@",responseObject);
        
        WL_Network_Model * network_Model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            GE_Mine_SysSet_Model *model = [GE_Mine_SysSet_Model mj_objectWithKeyValues:network_Model.data];
            
            [[SSKJ_User_Tool sharedUserTool] saveSysSetInfoModel:model];
        }
        else
        {
            [MBProgressHUD showError:network_Model.msg];
        }
        
        [hud hideAnimated:YES];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
}

@end
