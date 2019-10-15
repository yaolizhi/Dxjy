//
//  GE_Trading_ChiCang_ViewController.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Trading_ChiCang_ViewController.h"

#import "GE_Trading_ChiCang_Cell.h"

#import "GE_Trading_ChiCang_Model.h"

#import "SSKJ_NoDataView.h"

#import "GE_Trading_ChiCang_View.h"

@interface GE_Trading_ChiCang_ViewController ()<UITableViewDataSource,UITableViewDelegate,getSellOrBuyProtocol>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIScrollView *backView;

@property (nonatomic,assign) NSInteger firstRefresh;


@end

@implementation GE_Trading_ChiCang_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstRefresh = 1;
    
    [self tableView];
    
    WS(weakSelf);
    
    self.ChiCangRefreshBlock = ^(NSInteger index) {
        
        [weakSelf.dataSource removeAllObjects];
        
        if ([kLogined integerValue] == 1) {
            
            [weakSelf requestChiCangUrl];
        }
        else
        {
            [weakSelf.tableView reloadData];
            [SSKJ_NoDataView showNoData:weakSelf.dataSource.count toView:weakSelf.tableView offY:0];
        }
        
    };
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.timer invalidate];
}

//每10秒刷新一次
- (void)timerFired{
    self.firstRefresh ++;
    
    if ([kLogined integerValue] == 1) {
        
        [self headerRefresh];
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
    [self requestChiCangUrl];
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
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GE_Trading_ChiCang_Cell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"chicangView%ld",indexPath.row]];
    
    if (!cell)
    {
        cell = [[GE_Trading_ChiCang_Cell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[NSString stringWithFormat:@"chicangView%ld",indexPath.row]];

        cell.delegate = self;

    }

    [cell setDataFrom:self.dataSource[indexPath.section] style:(ChiCangTableViewCellStyleChiCang)];
    
    
    WS(weakSelf);
    
    cell.setBtnBlock = ^{
        self.backView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height_NavBar-Height_TabBar-50)];
        self.backView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight-Height_NavBar-Height_TabBar-50);
        self.backView.backgroundColor = [UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:0.4];
        
        UIView *contentView=[[UIView alloc]init];
        contentView.backgroundColor = [UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:0.4];
        
        [self.backView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(0));
            make.width.mas_equalTo(ScreenWidth);
                    make.height.mas_equalTo(ScreenHeight-Height_NavBar-Height_TabBar-50);
        }];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesClicki)];
        [contentView addGestureRecognizer:tapGes];
        
        GE_Trading_ChiCang_View *setView = (GE_Trading_ChiCang_View *)[[NSBundle mainBundle] loadNibNamed:@"Xib" owner:nil options:nil][0];
        //设置数据
        [setView initModel:self.dataSource[indexPath.section]];
        
        
        setView.sureBtnBlock = ^ {
            [weakSelf.backView removeFromSuperview];
        };
        [self.backView addSubview:setView];
        [setView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.backView.mas_bottom);
            make.left.equalTo(@0);
            make.width.equalTo(@(ScreenWidth));
            make.height.equalTo(@(240));
        }];
        
        [self.view addSubview:self.backView];
    };
    
    return cell;

}

- (void)tapGesClicki
{
    [self.backView removeFromSuperview];
}

- (void)sellOrBuyData:(GE_Trading_ChiCang_Model *)model style:(ChiCangTableViewCellStyle)style view:(UIView *)view
{
    
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定平仓吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self requestGetHeaderDataUrl:model];
    }]];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark -- 持仓列表 --
- (void)requestChiCangUrl
{
    [self.dataSource removeAllObjects];
    
    MBProgressHUD *hud;
    if (self.firstRefresh > 1) {
        hud = nil;
    }else{
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_chicang_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *networkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (networkModel.status.integerValue == 200) {
            if ([networkModel.data isKindOfClass:[NSArray class]]) {
                
                NSArray *array = networkModel.data;
                
                if (array.count > 0) {
                    
                    self.dataSource = [GE_Trading_ChiCang_Model mj_objectArrayWithKeyValuesArray:array];
                
                }
            }
        }
        else
        {
//            [MBProgressHUD showError:networkModel.msg];
        }
        [self.tableView reloadData];
        
        [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
        
        [hud hideAnimated:YES];
        
        [self.tableView.mj_header endRefreshing];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        NSLog(@"%@",error);
        [hud hideAnimated:YES];
        [self.dataSource removeAllObjects];
        [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
    }];
}


#pragma mark --- 平仓请求 ---
- (void)requestGetHeaderDataUrl:(GE_Trading_ChiCang_Model *)model
{
    NSDictionary * params = @{
                              @"order_id":model.hold_id,
                              };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_pingcang_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model *networkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (networkModel.status.integerValue == 200) {
            
            [MBProgressHUD showError:@"平仓成功"];
            
            //刷新头部数据  风险率  冻结保证金  可用余额
            [[NSNotificationCenter defaultCenter] postNotificationName:@"requestAccountInfoUrl" object:nil];
            
            [self headerRefresh];
        }
        else
        {
            [MBProgressHUD showError:networkModel.msg];
        }
        
        [self.tableView reloadData];
        
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
