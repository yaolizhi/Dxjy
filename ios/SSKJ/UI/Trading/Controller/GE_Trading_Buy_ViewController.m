//
//  GE_Trading_Buy_ViewController.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Trading_Buy_ViewController.h"

#import "GE_Trading_Buy_Cell.h"

#import "GE_Trading_goodsModel.h"

#import "GE_Trading_OneStock_Model.h"

#import "GE_Trading_ConfirmAlertView.h"

#import "GE_Trading_ConfirmAlertView.h"

#import "Home_Search_View.h"//搜索

#import "Martet_Search_ViewController.h"

@interface GE_Trading_Buy_ViewController ()<UITableViewDataSource,UITableViewDelegate,ManagerSocketDelegate>

@property (strong, nonatomic) Home_Search_View *searchView;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) GE_Trading_Buy_Cell *cell;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) GE_Trading_goodsModel *goodsmodel;

@property (nonatomic,strong) GE_Trading_OneStock_Model *oneStockModel;//单只股票详情

// 确认购买view
@property (nonatomic, strong) GE_Trading_ConfirmAlertView *confirmAlertView;

@property (nonatomic, copy) NSString *codeStr;//股票代码

@end

@implementation GE_Trading_Buy_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self searchView];
    
    [self tableView];
    
    WS(weakSelf);
    
    self.BuyRefreshBlock = ^(NSInteger index) {
        
        [[ManagerSocket sharedManager] closeConnectSocket];
        
        if (weakSelf.codeStr.length > 0) {
            [weakSelf requestBuyGetGoodsDetail:weakSelf.codeStr];
        }
        
    };
    if (weakSelf.codeStr.length > 0) {
        [weakSelf requestBuyGetGoodsDetail:self.codeStr];
    }
    
    
    //单利变量 如果存入股票代码  刷新界面
    if ([ManagerGlobeUntil sharedManager].goodsCode.length>0) {
        [self notificationClickedNotifa:nil];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.codeStr.length > 0) {
        [self requestBuyGetGoodsDetail:self.codeStr];
    }
}

#pragma mark - 通知函数
-(void)notificationClickedNotifa:(NSNotification *)nitifa
{
    WS(weakSelf);
    [[ManagerSocket sharedManager] openConnectSocketWithConnectSuccess:^{
        
        NSString *type = [weakSelf dictionaryToJson:@{@"sub":@[[NSString stringWithFormat:@"stock@%@",[ManagerGlobeUntil sharedManager].goodsCode]]}];
        [[ManagerSocket sharedManager] socketSendMsg:type];
        
    }];
    self.codeStr = [ManagerGlobeUntil sharedManager].goodsCode;
    [self requestBuyGetGoodsDetail:[ManagerGlobeUntil sharedManager].goodsCode];
}

#pragma mark - 页面即将消失
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[ManagerSocket sharedManager] closeConnectSocket];
        
}

-(void)socketDidReciveData:(id)data
{
    NSDictionary *pushGoodsInfoDatas = nil;
    if ([data isKindOfClass:[NSString class]]){
        pushGoodsInfoDatas = [self dictionaryWithJsonString:data];
    }
    else if ([data isKindOfClass:[NSDictionary class]]){
        pushGoodsInfoDatas = data;
    }
    self.goodsmodel = [GE_Trading_goodsModel mj_objectWithKeyValues:pushGoodsInfoDatas];
//    NSLog(@"%@",pushGoodsInfoDatas);
    self.cell.price = self.goodsmodel.price;
    self.cell.changeRate = self.goodsmodel.changeRate;
    
    self.confirmAlertView.priceLabel.text = self.goodsmodel.price;

}

#pragma mark -- 创建搜索框
- (Home_Search_View *)searchView{
    if (_searchView == nil) {
        _searchView = [[Home_Search_View alloc]initWithFrame:CGRectMake(ScaleW(25), ScaleW(15), ScreenWidth - ScaleW(50), ScaleW(30))];
        _searchView.backgroundColor = kMainWihteColor;
        [WLTools textField:_searchView.textfield setPlaceHolder:SSKJLocalized(@"请输入股票名称或代码搜索", nil) color:kMainGrayColor];
        _searchView.textfield.textColor = kMainDarkBlackColor;
        [_searchView.searchBtn setImage:[UIImage imageNamed:@"Trading_Seach"] forState:UIControlStateNormal];
        WS(weakSelf);
        _searchView.SearchBtnBlock = ^(NSString * _Nonnull searchStr) {
            Martet_Search_ViewController *vc = [[Martet_Search_ViewController alloc]init];
            vc.searchStr = searchStr;
            vc.index = 2;
            vc.SearchCodeBlock = ^(NSString * _Nonnull code) {
                weakSelf.codeStr = code;
                [weakSelf requestBuyGetGoodsDetail:code];
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [self.view addSubview:_searchView];
        
    }
    return _searchView;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.backgroundColor = kMainBackgroundColor;
        
        [_tableView setSeparatorColor:kMainWihteColor];
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = [UIView new];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.left.right.equalTo(@0);
            
            make.top.equalTo(self.searchView.mas_bottom).offset(ScaleW(15));
        }];
        
    }
    return _tableView;
}

- (void)headerRefresh
{
    if (self.codeStr.length > 0) {
        [self requestBuyGetGoodsDetail:self.codeStr];
    }else{
        [self.tableView.mj_header endRefreshing];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 500.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"chicangView%ld",indexPath.row]];
    
    if (!self.cell)
    {
        self.cell = [[GE_Trading_Buy_Cell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[NSString stringWithFormat:@"chicangView%ld",indexPath.row]];
    }
    
    self.cell.vc = self;
    
    self.cell.oneStockModel = self.oneStockModel;
    
    WS(weakSelf);
    
    self.cell.BuyOrderBlock = ^(NSDictionary * _Nonnull index) {
        [weakSelf.confirmAlertView showWithData:index];
    };

    
    return self.cell;
}


#pragma mark --- 获取单个商品详情 ---
- (void)requestBuyGetGoodsDetail:(NSString *)code
{
    [[ManagerSocket sharedManager] openConnectSocketWithConnectSuccess:^{
        
        NSString *type = [WLTools wlDictionaryToJson:@{@"sub":[NSString stringWithFormat:@"stock@%@",code]}];
        [[ManagerSocket sharedManager] socketSendMsg:type];
        
    }];
    
    [ManagerSocket sharedManager].delegate =self;
    
    NSDictionary *params = @{
                             @"code":code,
                             };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_getpro_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model *networkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (networkModel.status.integerValue == 200)
        {
            self.oneStockModel = [GE_Trading_OneStock_Model mj_objectWithKeyValues:networkModel.data[0]];
        }
        else
        {
            [MBProgressHUD showError:networkModel.msg];
        }
        [self.tableView reloadData];
        
        [hud hideAnimated:YES];
        
        [self.tableView.mj_header endRefreshing];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark --- 下单 ---
- (void)requestPostCreateOrdereUrl:(NSDictionary *)params
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_add_order_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *networkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (networkModel.status.integerValue == 200)
        {
            [MBProgressHUD showError:@"下单成功"];
            
            //刷新头部数据  风险率  冻结保证金  可用余额
            [[NSNotificationCenter defaultCenter] postNotificationName:@"requestAccountInfoUrl" object:nil];
            
        }else{
            [MBProgressHUD showError:networkModel.msg];
        }
        [hud hideAnimated:YES];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
}

#pragma mark -- 下单弹出试图 ---
-(GE_Trading_ConfirmAlertView *)confirmAlertView
{
    if (nil == _confirmAlertView) {
        _confirmAlertView =  [[GE_Trading_ConfirmAlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        __weak typeof(self)weakSelf = self;
        _confirmAlertView.ConfirmBlock = ^(NSDictionary *dic) {
            [weakSelf requestPostCreateOrdereUrl:dic];
        };
    }
    return _confirmAlertView;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark -- 数据转换 --
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
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
