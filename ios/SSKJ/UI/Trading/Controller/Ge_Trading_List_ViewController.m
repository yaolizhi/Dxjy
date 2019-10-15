//
//  Ge_Trading_List_ViewController.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Ge_Trading_List_ViewController.h"

#import "GE_Trading_ChiCang_Cell.h"

#import "GE_Trading_ChiCang_Model.h"

#import "SSKJ_NoDataView.h"

@interface Ge_Trading_List_ViewController ()<UITableViewDataSource,UITableViewDelegate,getSellOrBuyProtocol>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation Ge_Trading_List_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self tableView];
    
    WS(weakSelf);
    
    self.WeiTuoRefreshBlock = ^(NSInteger index) {
        
        [weakSelf.dataSource removeAllObjects];
        
        if ([kLogined integerValue] == 1) {
            
            [weakSelf requestListUrl];
        }
        else
        {
    
            [weakSelf.tableView reloadData];
            
            [SSKJ_NoDataView showNoData:weakSelf.dataSource.count toView:weakSelf.tableView offY:0];

        }
        
    };
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
            
            make.top.left.right.equalTo(@0);
            
            make.bottom.equalTo(@(0));
        }];
        
    }
    return _tableView;
}

- (void)headerRefresh
{
    [self.dataSource removeAllObjects];
    
    [self requestListUrl];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return ScaleH(5);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [FactoryUI createViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(5)) Color:kMainBackgroundColor];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GE_Trading_ChiCang_Cell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"chicangView%ld",indexPath.row]];
    
    if (!cell)
    {
        cell = [[GE_Trading_ChiCang_Cell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[NSString stringWithFormat:@"chicangView%ld",indexPath.row]];
        
        cell.delegate = self;
        
    }
    [cell setDataFrom:self.dataSource[indexPath.section] style:(ChiCangTableViewCellStyleGuaDan)];
    return cell;
    
}

- (void)sellOrBuyData:(GE_Trading_ChiCang_Model *)model style:(ChiCangTableViewCellStyle)style view:(UIView *)view
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定撤销此订单吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self requestCheDanDataUrl:model];
    }]];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}


#pragma mark -- 挂单列表请求 --
- (void)requestListUrl
{
    NSDictionary *params = @{@"account":[[SSKJ_User_Tool sharedUserTool] getAccount],
                             @"action":@"dealInfo",
                             @"billStatus":@(2),
                             @"sessionId":[[SSKJ_User_Tool sharedUserTool] getToken]
                             };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_Pubilc_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
//        NSLog(@"挂单列表请求:%@",responseObject);
        
        WL_Network_Model *networkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (networkModel.status.integerValue == 200) {
            
            if ([networkModel.data[@"list"] isKindOfClass:[NSArray class]]) {
                
                NSArray *array = networkModel.data[@"list"];
                
                if (array.count > 0) {
                    
                    for (NSDictionary *dic in array) {
                        
                        GE_Trading_ChiCang_Model *model = [GE_Trading_ChiCang_Model mj_objectWithKeyValues:dic];
                        
                        [self.dataSource addObject:model];
                        
                    }
                }
            }
        }
        else
        {
            [MBProgressHUD showError:networkModel.msg];
        }
        
        [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
        
        [hud hideAnimated:YES];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
}

#pragma mark --- 撤单请求 ---
- (void)requestCheDanDataUrl:(GE_Trading_ChiCang_Model *)model
{
    NSDictionary * params = @{@"action":@"cancelBill",
                              @"account":[[SSKJ_User_Tool sharedUserTool] getAccount],
                              @"id":model.hold_id,
                              @"sessionId":[[SSKJ_User_Tool sharedUserTool] getToken]
                              };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_Pubilc_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model *networkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (networkModel.status.integerValue == 200) {
            
            [MBProgressHUD showError:@"撤单成功"];
            
            //刷新头部数据  风险率  冻结保证金  可用余额
            [[NSNotificationCenter defaultCenter] postNotificationName:@"requestAccountInfoUrl" object:nil];
            
            [self headerRefresh];
        }
        else
        {
            [MBProgressHUD showError:networkModel.msg];
        }
        
        [hud hideAnimated:YES];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
}




- (NSMutableArray *)dataSource
{
    if (_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
