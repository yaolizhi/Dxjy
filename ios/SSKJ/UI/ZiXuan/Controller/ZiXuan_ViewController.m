//
//  ZiXuan_ViewController.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/5/9.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "ZiXuan_ViewController.h"

#import "Market_Index_Title_Section_View.h"

#import "Market_Chart_Detail_ViewController.h" //币种行情

#import "Market_Main_List_Model.h"

#import "ZiXuan_TableViewCell.H"

#import "Home_Search_View.h"

#import "Martet_Search_ViewController.h"

#import "GE_Login_ViewController.h"

static NSString * titleSectionID = @"ZiXuanSectionID";

static NSString * ZIXuanCell = @"ZIXuanCellID";

@interface ZiXuan_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) Home_Search_View *searchView;

@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,assign) NSInteger index;

@end

@implementation ZiXuan_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 1;
    
    self.title = SSKJLocalized(@"自选", nil);
    
    [self searchView];
    
    [self tableView];
    
    [self addRightNavItemWithTitle:SSKJLocalized(@"编辑", nil) color:kMainWihteColor font:systemFont(14)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.dataSource removeAllObjects];
    
    if ([[[SSKJ_User_Tool sharedUserTool] getLogin] integerValue] == 1)
    {
        [self requestoptional_listURl];
    }else{
        [self.tableView reloadData];
        
        [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:ScaleW(100)];

    }
    
}

- (void)rigthBtnAction:(id)sender{
    if (self.index == 1) {
        self.index = 2;
        [self addRightNavItemWithTitle:SSKJLocalized(@"完成", nil) color:kMainWihteColor font:systemFont(14)];
        [self.tableView reloadData];
    }else{
        self.index = 1;
        [self addRightNavItemWithTitle:SSKJLocalized(@"编辑", nil) color:kMainWihteColor font:systemFont(14)];
        [self.tableView reloadData];
    }
}

#pragma mark -- 创建搜索框
- (Home_Search_View *)searchView{
    if (_searchView == nil) {
        _searchView = [[Home_Search_View alloc]initWithFrame:CGRectMake(ScaleW(25), ScaleW(15), ScreenWidth - ScaleW(50), ScaleW(30))];
        WS(weakSelf);
        _searchView.SearchBtnBlock = ^(NSString * _Nonnull searchStr) {
            if ([[SSKJ_User_Tool sharedUserTool].getLogin integerValue] != 1) {
                BLAlertView *alertView = [[BLAlertView alloc] initWithTitle:SSKJLocalized(@"未登录", nil) message:SSKJLocalized(@"请先登录账号", nil) sureBtn:SSKJLocalized(@"登录", nil) cancleBtn:SSKJLocalized(@"取消", nil)];
                                
                alertView.cancelBlock = ^(NSString *message)
                {
                };
                
                alertView.sureBlock = ^(NSString *message)
                {
                    GE_Login_ViewController *vc = [[GE_Login_ViewController alloc] init];
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                };
                
                [alertView showBLAlertView];
            }else{
                Martet_Search_ViewController *vc = [[Martet_Search_ViewController alloc]init];
                vc.searchStr = searchStr;
                vc.index = 1;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        };
        [self.view addSubview:_searchView];
        [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(25)));
            make.right.equalTo(@(ScaleW(-25)));
            make.top.equalTo(@(ScaleW(15)));
            make.height.equalTo(@(ScaleW(30)));
        }];
        
    }
    return _searchView;
}


#pragma mark - 表格视图
-(UITableView *)tableView
{
    if (_tableView==nil)
    {
        NSLog(@"%f",Height_TabBar);
        
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, ScaleW(60), ScreenWidth, ScreenHeight - Height_TabBar - ScaleW(60) - Height_NavBar)];
        
        _tableView.delegate=self;
        
        _tableView.dataSource=self;
        
        _tableView.backgroundColor=kMainBackgroundColor;
        
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[Market_Index_Title_Section_View class] forHeaderFooterViewReuseIdentifier:titleSectionID];
        
        [_tableView registerClass:[ZiXuan_TableViewCell class] forCellReuseIdentifier:ZIXuanCell];
        
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        [self.view addSubview:_tableView];
        
//        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(@0);
//
//            make.top.equalTo(self.searchView.mas_bottom).offset(ScaleW(15));
//
//            make.width.equalTo(@(ScreenWidth));
//
//            make.bottom.equalTo(@(0));
//        }];
        
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        
    }
    
    return _tableView;
}

- (void)loadData
{
    [self.dataSource removeAllObjects];
    
    if ([[[SSKJ_User_Tool sharedUserTool] getLogin] integerValue] == 1) {
        [self requestoptional_listURl];
    }else{
        [self.tableView.mj_header endRefreshing];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZiXuan_TableViewCell *topCell=[tableView dequeueReusableCellWithIdentifier:ZIXuanCell forIndexPath:indexPath];

    [topCell initDatawithModel:self.dataSource[indexPath.row] index:self.index];
    
    WS(weakSelf);
    
    topCell.OptionalDelBlock = ^(Market_Main_List_Model * _Nonnull model) {
        [weakSelf requestGE_add_optional_URL:model];
    };
    
    return topCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(75);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleW(40);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    Market_Index_Title_Section_View *title_Section_View=[tableView dequeueReusableHeaderFooterViewWithIdentifier:titleSectionID];
    
    return title_Section_View;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    Market_Main_List_Model *cellModel=self.dataSource[indexPath.row];
    
    Market_Chart_Detail_ViewController *chart_VC=[[Market_Chart_Detail_ViewController alloc] init];
    
    chart_VC.model=cellModel;
    
    chart_VC.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:chart_VC animated:YES];
}

#pragma mark  -- 自选列表数据 --
- (void)requestoptional_listURl{
    
    [self.dataSource removeAllObjects];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_optional_list_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200) {
            weakSelf.dataSource = [Market_Main_List_Model mj_objectArrayWithKeyValuesArray:netModel.data];
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        [hud hideAnimated:YES];
        [self.tableView reloadData];
        [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:ScaleW(100)];
        [self.tableView.mj_header endRefreshing];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        [self.tableView.mj_header endRefreshing];
        [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:ScaleW(100)];
    }];
}

#pragma mark  -- 删除自选 --
- (void)requestGE_add_optional_URL:(Market_Main_List_Model *)model{
    
    [self.dataSource removeAllObjects];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = @{@"code":model.code};
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_optional_del_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200) {
            [weakSelf requestoptional_listURl];
            weakSelf.index = 1;
            [weakSelf addRightNavItemWithTitle:SSKJLocalized(@"编辑", nil) color:kMainWihteColor font:systemFont(14)];
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        [hud hideAnimated:YES];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        
    }];
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
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
