//
//  GE_Market_ViewController.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Market_ViewController.h"

#import "Market_Index_Title_Section_View.h"

#import "Market_Index_Top_Cell.h"

#import "Market_Index_List_Cell.h"

#import "Market_Main_List_Model.h"

#import "Market_Chart_Detail_ViewController.h"

#import "GE_Market_Banner_Model.h"

#import "GE_Market_Notice_Model.h"

#import "GE_Market_NoticeDetail_VC.h"

#import "CEWebVC.h"//公告详情

#import "GE_Mine_SysSet_Model.h"

#import "GE_ZiXun_PingTaiVC.h"

//版本更新
#import "BFEX_System_Version_Model.h"
#import "BFEX_System_Version_View.h"

#import "Market_Main_Slider_Web_ViewController.h"

#define kPage_size @"10"

static NSString *topCellID=@"topCellID";

static NSString *listCellID=@"listCellID";

static NSString *titleSectionID=@"titleSectionID";

@interface GE_Market_ViewController ()<UITableViewDelegate,UITableViewDataSource,ManagerSocketDelegate,SDCycleScrollViewDelegate,UISearchBarDelegate>



@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,assign)CGFloat bannerHeight;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) NSMutableArray *bannerArray;

@property (nonatomic,strong) NSMutableArray *noticeArray;

//版本更新
@property(nonatomic,strong)BFEX_System_Version_View *versionView;
@property(nonatomic,strong)BFEX_System_Version_Model *versionModel;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableString *socketCodeString;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) BOOL isAppear;


@end

@implementation GE_Market_ViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=SSKJLocalized(@"行情", nil);
    
    self.view.backgroundColor=kMainBackgroundColor;
    
//    [[UIApplication sharedApplication].keyWindow addSubview:self.versionView];
    
    UIImage *imageBanner=[UIImage imageNamed:@"Market_banner"];
    
    self.bannerHeight=imageBanner.size.height;
    
    [self tableView];
    
    //版本更新
    [self checkVersion];
    
    //banner网络请求
    [self httpRequestWithBanner];
    
    //交易设置请求
//    [self requestSysSetUrl];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];

    
}

-(void)applicationDidBecomeActive:(NSNotification *)notification
{
    if (self.isAppear) {
        //获取股票列表
        [self requestCreateOrdereUrl];
        
        if ([[ManagerSocket sharedManager] socketIsConnected] == NO)
        {
            [self loadSocketMarketListData];
        }
        else
        {
            NSLog(@"\r行情->推送关闭~");
        }
        
        
        [self.timer fire];
        
    }
}

-(void)applicationDidEnterBackground:(NSNotification *)notification
{
    if (self.isAppear) {
        [[ManagerSocket sharedManager] closeConnectSocket];
        
        [self.navigationController setNavigationBarHidden:NO];
        [self.timer invalidate];
        self.timer = nil;
    }
    
}


-(NSTimer *)timer
{
    if (nil == _timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(connectSocket) userInfo:nil repeats:YES];
    }
    return _timer;
}

-(void)connectSocket
{
    NSMutableArray<Market_Main_List_Model *> *oldCoinArray=[self.dataSource copy];
    for (Market_Main_List_Model *coinModel in oldCoinArray) {
        [self.socketCodeString appendString:[NSString stringWithFormat:@"|%@",coinModel.code]];
    }
    
    
    NSString *type = [WLTools wlDictionaryToJson:@{@"sub":[NSString stringWithFormat:@"stock@%@",self.socketCodeString]}];
    
    if ([ManagerSocket sharedManager].socketIsConnected) {
        [[ManagerSocket sharedManager] socketSendMsg:type];
    }
}

#pragma mark - 页面即将显示
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    //获取股票列表
    [self requestCreateOrdereUrl];
    
    if ([[ManagerSocket sharedManager] socketIsConnected] == NO)
    {
         [self loadSocketMarketListData];
    }
    else
    {
        NSLog(@"\r行情->推送关闭~");
    }
    
    self.isAppear = YES;
    
    [self.timer fire];
    
}

#pragma mark - 页面即将消失
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[ManagerSocket sharedManager] closeConnectSocket];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.isAppear = NO;
    [self.timer invalidate];
    self.timer = nil;
    
}

- (void)loadSocketMarketListData
{
    self.socketCodeString = [NSMutableString string];
    
    NSMutableArray<Market_Main_List_Model *> *oldCoinArray=[self.dataSource copy];
    for (Market_Main_List_Model *coinModel in oldCoinArray) {
        [self.socketCodeString appendString:[NSString stringWithFormat:@"|%@",coinModel.code]];
    }
    [self.socketCodeString deleteCharactersInRange:NSMakeRange(0, 1)];
    
    
    [ManagerSocket sharedManager].delegate = self;
    
    [[ManagerSocket sharedManager] openConnectSocketWithConnectSuccess:^{
        
        NSString *type = [WLTools wlDictionaryToJson:@{@"sub":[NSString stringWithFormat:@"stock@%@",self.socketCodeString]}];
        
        [[ManagerSocket sharedManager] socketSendMsg:type];
        
    }];
    
}

- (void)socketDidReciveData:(id)data
{
    Market_Main_List_Model *socketModel=[Market_Main_List_Model mj_objectWithKeyValues:data];
    
    if (self.dataSource.count > 0) {
        
        NSMutableArray<Market_Main_List_Model *> *oldCoinArray=[self.dataSource copy];
        
        for (Market_Main_List_Model *coinModel in oldCoinArray) {
            
            if ([coinModel.code isEqualToString:socketModel.code])
            {
                NSInteger dataIndex = [self.dataSource indexOfObject:coinModel];
                
                coinModel.price=socketModel.price;
                
                coinModel.changeRate=socketModel.changeRate;
                
                coinModel.low=socketModel.low;
                
                coinModel.high=socketModel.high;
                
                coinModel.code=socketModel.code;
                
                coinModel.name = socketModel.name;
                
                coinModel.stockProductVO.price = socketModel.price;
                
                coinModel.stockProductVO.low = socketModel.low;
                
                coinModel.stockProductVO.high = socketModel.high;
                
                coinModel.stockProductVO.changeRate = socketModel.changeRate;
                
//                coinModel.stockProductVO.cnyPrice = socketModel.cnyPrice;
                
                [self.dataSource replaceObjectAtIndex:dataIndex withObject:coinModel];
                
                if ([self.tableView numberOfRowsInSection:1]>dataIndex)
                {
                    NSIndexPath *indexPath= [NSIndexPath indexPathForRow:dataIndex inSection:1];
                    
                    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                }
            }
        }
    }

}




#pragma mark - 表格视图
-(UITableView *)tableView
{
    if (_tableView==nil)
    {
        _tableView=[[UITableView alloc] init];
        
        _tableView.delegate=self;
        
        _tableView.dataSource=self;
        
        _tableView.backgroundColor=kMainBackgroundColor;
        
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[Market_Index_Title_Section_View class] forHeaderFooterViewReuseIdentifier:titleSectionID];
        
        [_tableView registerClass:[Market_Index_Top_Cell class] forCellReuseIdentifier:topCellID];
        
        [_tableView registerClass:[Market_Index_List_Cell class] forCellReuseIdentifier:listCellID];
        
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
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@0);
            
            make.top.equalTo(@(0));
            
            make.width.equalTo(@(ScreenWidth));
            
            make.height.equalTo(@(ScreenHeight-Height_TabBar));
        }];
        
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        
    }
    
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) //币种个数
    {
        return self.dataSource.count;
    }
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1)
    {
        Market_Index_List_Cell *listCell=[tableView dequeueReusableCellWithIdentifier:listCellID forIndexPath:indexPath];
        
        [listCell initWithCellModel:self.dataSource[indexPath.row]];
        
        return listCell;
    }
    else
    {
        Market_Index_Top_Cell *topCell=[tableView dequeueReusableCellWithIdentifier:topCellID forIndexPath:indexPath];
        
        topCell.bannerArray = self.bannerArray;
        
        topCell.noticeArray = self.noticeArray;
        
        WS(weakSelf);
        
        topCell.bannerClickBlock = ^(NSInteger index) {
            
            [weakSelf banner_Button_Event:index];
            
        };
        
        topCell.noticeClickBlock = ^(NSInteger index) {
            
            GE_Market_Notice_Model *model = weakSelf.noticeArray[index];
            
            GE_Market_NoticeDetail_VC *vc = [[GE_Market_NoticeDetail_VC alloc]init];
            
            vc.ID = model.ID;
            
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        };
        
        
        return topCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) //行情区域 cell高度
    {
        return 75.0;
    }
    else
    {
        return self.bannerHeight+40+5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) //行情标题 高度
    {
        return 40.0;
    }
    else
    {
        return 0.0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) //行情标题
    {
        Market_Index_Title_Section_View *title_Section_View=[tableView dequeueReusableHeaderFooterViewWithIdentifier:titleSectionID];
        
        return title_Section_View;
    }
    else
    {
        return [UIView new];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        Market_Main_List_Model *cellModel=self.dataSource[indexPath.row];

        Market_Chart_Detail_ViewController *chart_VC=[[Market_Chart_Detail_ViewController alloc] init];

        chart_VC.model=cellModel;

        chart_VC.hidesBottomBarWhenPushed=YES;

        [self.navigationController pushViewController:chart_VC animated:YES];
    }
    else
    {
        GE_ZiXun_PingTaiVC *vc = [[GE_ZiXun_PingTaiVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
   
}

//下拉刷新
- (void)loadData
{
    //banner网络请求
    [self httpRequestWithBanner];
    [self requestCreateOrdereUrl];
//    [self requestSysSetUrl];
}

//公告点击
- (void)gonggaoBtnAction
{
    CEWebVC *vc = [[CEWebVC alloc] initWithNibName:@"CEWebVC" bundle:nil];
    vc.type = 2;
    //    vc.detailID = self.dataSource[indexPath.section][@"id"];
    //    vc.titleStr = self.dataSource[indexPath.section][@"title"];
    //    vc.timeStr = self.dataSource[indexPath.section][@"createTime"];
    
    vc.urlStr = @"";
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

#pragma mark --- 行情列表 ---
- (void)requestCreateOrdereUrl
{
 
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_getpro_URL RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
//        NSLog(@"获取商品列表 :%@",responseObject);
        WL_Network_Model *networkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (networkModel.status.integerValue == 200) {
            
            if ([networkModel.data isKindOfClass:[NSArray class]]) {
                NSArray *array = networkModel.data;
                
                [self.dataSource removeAllObjects];
                
                for (NSDictionary *dic in array) {
                    Market_Main_List_Model *model = [Market_Main_List_Model mj_objectWithKeyValues:dic];
                    
                    model.stockProductVO = [Market_Main_List_SocketProduct_Model mj_objectWithKeyValues:dic];
                   
                    
                    [self.dataSource addObject:model];
                }
            }
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:networkModel.msg];
        }
        [hud hideAnimated:YES];
        [self.tableView.mj_header endRefreshing];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        NSLog(@"%@",error);
        [hud hideAnimated:YES];
        [self.tableView.mj_header endRefreshing];
    }];
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

#pragma mark - Banner 点击 事件
-(void)banner_Button_Event:(NSInteger)index
{
    if (self.bannerArray.count>0)
    {
        GE_Market_Banner_Model *bannerModel=self.bannerArray[index];

        if ([WLTools judgeString:bannerModel.url])
        {
            NSString *url=bannerModel.url;

            if (![url containsString:@"http"])
            {
                url=[NSString stringWithFormat:@"http://%@",url];
            }

            Market_Main_Slider_Web_ViewController *web_VC=[[Market_Main_Slider_Web_ViewController alloc] init];

            web_VC.title=bannerModel.name;

            web_VC.webUrl=url;

            web_VC.hidesBottomBarWhenPushed=YES;

            [self.navigationController pushViewController:web_VC animated:YES];

        }


    }
}

#pragma mark - 版本更新控制 立即更新 事件
-(void)upgrade_Button_Event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.versionModel.addr]];
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)bannerArray
{
    if (_bannerArray == nil) {
        
        _bannerArray = [NSMutableArray array];
    }
    return _bannerArray;
}

- (NSMutableArray *)noticeArray
{
    if (_noticeArray == nil) {
        
        _noticeArray = [NSMutableArray array];
    }
    return _noticeArray;
}

#pragma mark - banner网络请求
- (void)httpRequestWithBanner
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_getBanner_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
//        NSLog(@"banner网络请求%@",responseObject);
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            //轮播图
            if ([network_Model.data[@"banner"] isKindOfClass:[NSArray class]]) {
                
                NSArray *array = network_Model.data[@"banner"];
                
                [self.bannerArray removeAllObjects];
                
                if (array.count > 0) {
                    
                    for (NSDictionary *dic in array) {
                        GE_Market_Banner_Model *model = [GE_Market_Banner_Model mj_objectWithKeyValues:dic];
                        
                        [self.bannerArray addObject:model];
                    }
                }
            }
            //公告
            if ([network_Model.data[@"article"] isKindOfClass:[NSArray class]]) {
                
                NSArray *array = network_Model.data[@"article"];
                
                [self.noticeArray removeAllObjects];
                
                if (array.count > 0) {
                    
                    for (NSDictionary *dic in array) {
                        
                        GE_Market_Notice_Model *model = [GE_Market_Notice_Model mj_objectWithKeyValues:dic];
                        
                        [self.noticeArray addObject:model];
                    }
                }
            }
            
            
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        [self.tableView reloadData];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
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
