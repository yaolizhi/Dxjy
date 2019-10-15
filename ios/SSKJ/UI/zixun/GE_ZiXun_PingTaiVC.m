//
//  GE_ZiXun_PingTaiVC.m
//  SSKJ
//
//  Created by 张超 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_ZiXun_PingTaiVC.h"
#import "GE_ZiXun_HangYeCell.h"
#import "CEWebVC.h"
#import "SSKJ_NoDataView.h"


#import "GE_Market_NoticeDetail_VC.h"

#define kPage_size @"10"


@interface GE_ZiXun_PingTaiVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;

@end

@implementation GE_ZiXun_PingTaiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"公告列表", nil);
    
    self.dataSource = [[NSMutableArray alloc] init];
    self.page = 1;
    
    [self.view addSubview:self.tableView];
    
    [self httpRequest];
    
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
        
        _tableView.separatorColor = kMainBackgroundColor;
        
        //        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.right.equalTo(@0);
            
            make.bottom.equalTo(@(0));
        }];
        
        WS(weakSelf);
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf footerRefresh];
        }];
        
    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GE_ZiXun_HangYeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"GE_ZiXun_HangYeCell" owner:nil options:nil][0];
    }
    
    [cell initWithModel:self.dataSource[indexPath.row] type:2];
    
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return ScaleH(0);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [FactoryUI createViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(5)) Color:kMainBackgroundColor];
    
    return view;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    
    GE_Market_NoticeDetail_VC *vc = [[GE_Market_NoticeDetail_VC alloc] init];
    vc.ID = self.dataSource[indexPath.row][@"id"];

    [self.navigationController pushViewController:vc animated:YES];
}

//平台公告
- (void)httpRequest
{
    WS(weakSelf);
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = @{@"nowpage":@(self.page),
                             @"nownums":kPage_size};
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:[NSString stringWithFormat:@"%@",GE_Notice_URL] RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            [weakSelf handleDataWithModel:network_Model];
        }else{
            [MBProgressHUD showError:network_Model.msg];
            [weakSelf endRefresh];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
    }];
}

-(void)headerRefresh
{
    self.page = 1;
    [self httpRequest];
}

-(void)footerRefresh
{
    [self httpRequest];
}

-(void)handleDataWithModel:(WL_Network_Model *)net_model
{
    NSArray *array = net_model.data[@"data"];
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    if (array.count != kPage_size.integerValue) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
    
    [self endRefresh];
    
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
    
    [self.tableView reloadData];
    
    self.page++;
    
}

-(void)endRefresh
{
    if (self.tableView.mj_header.state == MJRefreshStateRefreshing) {
        self.tableView.mj_header.state = MJRefreshStateIdle;
    }
    if (self.tableView.mj_footer.state == MJRefreshStateRefreshing) {
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
}

@end
