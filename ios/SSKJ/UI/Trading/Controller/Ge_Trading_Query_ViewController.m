//
//  Ge_Trading_Query_ViewController.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Ge_Trading_Query_ViewController.h"
#import "GE_Trading_CurrentDelegateVC.h"
#import "GE_Trading_HistoryDelegateCell.h"

#import "SSKJ_NoDataView.h"
#import "GE_Login_ViewController.h"

#define KpageSize @"10"


@interface Ge_Trading_Query_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,assign) NSInteger page;


@end

@implementation Ge_Trading_Query_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    
    [self tableView];

    WS(weakSelf);
    
    self.ChengJiaoRefreshBlock = ^(NSInteger index) {
        
        [weakSelf.dataSource removeAllObjects];
        
        if ([kLogined integerValue] == 1) {
            
            [weakSelf requestHistoryChiCangUrl];
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
                
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.right.equalTo(@0);
            
            make.bottom.equalTo(@(0));
        }];
        
        _tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshheader)];
        _tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
        
    }
    return _tableView;
}

- (void)refreshheader{
    self.page = 1;
    
    [self.dataSource removeAllObjects];
    
    if ([kLogined integerValue] == 1) {
        
        [self requestHistoryChiCangUrl];
    }
    else
    {
        [self.tableView reloadData];
        
        [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
    }
    
}
- (void)refreshFooter{
    self.page ++;
    
    if ([kLogined integerValue] == 1) {
        
        [self requestHistoryChiCangUrl];
    }
    else
    {
        [self.dataSource removeAllObjects];
        
        [self.tableView reloadData];
        
        [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleH(5);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [FactoryUI createViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(5)) Color:kMainBackgroundColor];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GE_Trading_HistoryDelegateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"GE_Trading_HistoryDelegateCell" owner:nil options:nil][0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setDataWithModel:self.dataSource[indexPath.section] type:@""];
    
    return cell;
}

#pragma mark -- 历史订单列表 --
- (void)requestHistoryChiCangUrl
{
    NSDictionary *params = @{@"p":@(self.page),
                             @"pageSize":KpageSize,
                             };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_chengjiao_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        //        NSLog(@"历史订单列表:%@",responseObject);
        WL_Network_Model *networkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (networkModel.status.integerValue == 200) {
            if ([networkModel.data isKindOfClass:[NSArray class]]) {
                
                NSArray *array = networkModel.data;
                
                if (array.count < KpageSize.integerValue) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    self.tableView.mj_footer.state = MJRefreshStateIdle;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
