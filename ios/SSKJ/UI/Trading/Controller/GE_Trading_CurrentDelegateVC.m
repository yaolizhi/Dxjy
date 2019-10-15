//
//  GE_Trading_CurrentDelegateVC.m
//  SSKJ
//
//  Created by 张超 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Trading_CurrentDelegateVC.h"
#import "GE_Trading_CurrentDelegateCell.h"

#import "GE_Trading_HistoryDelegateCell.h"

#import "GE_Trading_HistioryOrder_Model.h"

#import "SSKJ_NoDataView.h"

#define KTodayPageSize @"10"

@interface GE_Trading_CurrentDelegateVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,assign) NSInteger page;

@end

@implementation GE_Trading_CurrentDelegateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self.typeStr isEqualToString:@"委托"]) {
        
        self.title = SSKJLocalized(@"当日委托", nil);
        
//        [self requestTodayListUrl];
    }else{
        self.title = SSKJLocalized(@"当日成交", nil);
        
//        [self requestTodayChiCangUrl];
    }
    
    [self.view addSubview:self.tableView];
}

- (void)headerRefresh
{
    self.page = 1;
    
    [self.dataSource removeAllObjects];
    
    if ([self.typeStr isEqualToString:@"委托"]) {
        
        [self requestTodayListUrl];
    }else{
        [self requestTodayChiCangUrl];
    }
    
}

- (void)footerRefresh
{
    self.page ++ ;
    
    if ([self.typeStr isEqualToString:@"委托"]) {
        
        [self requestTodayListUrl];
    }else{
        
        [self requestTodayChiCangUrl];
    }
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
        
        _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
        
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.right.equalTo(@0);
            
            make.bottom.equalTo(@(0));
        }];
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.typeStr isEqualToString:@"委托"]) {
        GE_Trading_CurrentDelegateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"GE_Trading_CurrentDelegateCell" owner:nil options:nil][0];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setDataWithModel:self.dataSource[indexPath.section] type:self.typeStr];
        
        return cell;
    }
    else
    {
        GE_Trading_HistoryDelegateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"GE_Trading_HistoryDelegateCell" owner:nil options:nil][0];
        }
        
        //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setDataWithModel:self.dataSource[indexPath.section] type:@""];
        
        return cell;
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.typeStr isEqualToString:@"委托"])
    {
        return 145;
    }
    else
    {
        return 205;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return ScaleH(5);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [FactoryUI createViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(5)) Color:kMainBackgroundColor];
    
    return view;
    
}

#pragma mark -- 当日委托请求 --
- (void)requestTodayListUrl
{
    NSDictionary *params = @{@"account":[[SSKJ_User_Tool sharedUserTool] getAccount],
                             @"action":@"dealInfo",
                             @"toDay":[WLTools getOrderTimeMS],
                             @"sessionId":[[SSKJ_User_Tool sharedUserTool] getToken]
                             };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_Pubilc_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
//        NSLog(@"当日委托请求:%@",responseObject);
        
        WL_Network_Model *networkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (networkModel.status.integerValue == 200) {
            
            if ([networkModel.data[@"list"] isKindOfClass:[NSArray class]]) {
                
                NSArray *array = networkModel.data[@"list"];
                
                if (array.count != KTodayPageSize.integerValue) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
                
                if (array.count > 0) {
                    
                    for (NSDictionary *dic in array) {
                        
                        GE_Trading_HistioryOrder_Model *model = [GE_Trading_HistioryOrder_Model mj_objectWithKeyValues:dic];
                        
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

#pragma mark -- 持仓列表 --
- (void)requestTodayChiCangUrl
{
    NSDictionary *params = @{@"account":[[SSKJ_User_Tool sharedUserTool] getAccount],
                             @"action":@"dealInfo",
                             @"toDay":[WLTools getOrderTimeMS],
                             @"billStatus":@(4),
                             @"sessionId":[[SSKJ_User_Tool sharedUserTool] getToken]
                             };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_Pubilc_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
//        NSLog(@"持仓列表请求:%@",responseObject);
        WL_Network_Model *networkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (networkModel.status.integerValue == 200) {
            if ([networkModel.data[@"list"] isKindOfClass:[NSArray class]]) {
                
                NSArray *array = networkModel.data[@"list"];
                
                if (array.count != KTodayPageSize.integerValue) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
                
                if (array.count > 0) {
                    
                    for (NSDictionary *dic in array) {
                        
                        GE_Trading_HistioryOrder_Model *model = [GE_Trading_HistioryOrder_Model mj_objectWithKeyValues:dic];
                        
                        [self.dataSource addObject:model];
                        
                    }
                }
            }
        }
        else
        {
            [MBProgressHUD showError:networkModel.msg];
        }
        [self.tableView reloadData];
        
        [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
        
        [hud hideAnimated:YES];
        
        [self.tableView.mj_header endRefreshing];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
}

-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray array];
    }
    return  _dataSource;
}

@end
