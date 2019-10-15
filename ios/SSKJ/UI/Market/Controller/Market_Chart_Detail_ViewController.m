//
//  Market_Chart_Detail_ViewController.m
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Chart_Detail_ViewController.h"

#import "Market_Chart_Nav_View.h"

#import "Market_Chart_Bottom_View.h"

#import "Market_Chart_Detail_Price_Section_View.h"

#import "Market_Chart_Detail_Type_Section_View.h"

#import "Market_Chart_Detail_KLine_Cell.h"

#import "Market_Chart_Detail_Order_Cell.h"

#import "Market_Chart_Detail_Intro_Cell.h"

#import "Market_Chart_Detail_Order_List_Cell.h"

#import "Market_Chart_Detail_Order_ListTop_Cell.h"

#import "Market_Chart_Detail_Intro_List_Cell.h"

#import "Market_Chart_Detail_Intro_detail_Cell.h"

#import "ManagerSocket.h"

#import "Market_Chart_Detail_KLine_Model.h"

#import "Market_Chart_Detail_Deal_Model.h"

#import "Market_Chart_Detail_Intro_Model.h"

#import "Market_Chart_Detail_Deal_Index_Model.h"

#import "QBWShowNoDataView.h"

static NSString *price_SectionID=@"price_SectionID";

static NSString *type_SectionID=@"type_SectionID";

static NSString *order_CellID=@"order_CellID";

static NSString *intro_CellID=@"intro_CellID";

static NSString *kline_CellID=@"kline_CellID";

static NSString *order_ListTop_CellID=@"order_ListTop_CellID";

static NSString *order_List_CellID=@"order_List_CellID";

static NSString *intro_List_CellID=@"intro_List_CellID";

static NSString *intro_Detail_CellID=@"intro_Detail_CellID";

#define kNotificationName_MarketList_BB @"kNotificationName_MarketList_BB"


#define kNotificationName_MarketList_ContractTrade @"kNotificationName_MarketList_ContractTrade"


#define kNotificationName_MarketList_UserKey @"MarketList_name"

#define kNotificationName_BuyOrSell @"kNotificationName_BuyOrSell"

@interface Market_Chart_Detail_ViewController ()<UITableViewDataSource,UITableViewDelegate,ManagerSocketDelegate>

{
    Market_Chart_Detail_KLine_Cell *kline_Cell;
    
    Market_Chart_Detail_Price_Section_View *price_SectionView;
}

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)Market_Chart_Nav_View *navView;

@property(nonatomic,strong)Market_Chart_Bottom_View *bottomView;

@property(nonatomic,assign)NSInteger type;

@property(nonatomic,copy)NSArray *array;

@property(nonatomic,copy)NSString *kType;

@property(nonatomic,copy)NSString *lastTime;
//1 分是分时 1分kline
@property (nonatomic, assign) LXY_KLINETYPE lxy_klineType;

//K线数组
@property(nonatomic,strong)NSMutableArray<Market_Chart_Detail_KLine_Model *> *klineArray;

//成交数组
@property(nonatomic,strong)NSMutableArray<Market_Chart_Detail_Deal_Model *> *dealArray;

//简介数组
@property(nonatomic,strong)NSMutableArray<Market_Chart_Detail_Intro_Model *> *introArray;

//简介实体类
@property(nonatomic,strong)Market_Chart_Detail_Deal_Index_Model *dealIndexModel;

@property (nonatomic, assign) NSInteger currentDealPage;

@end

static NSInteger const pageSize = 100;

@implementation Market_Chart_Detail_ViewController

#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[WLTools stringToColor:@"#ffffff"];
    
    self.type=1; //默认 成交 类型
    
    self.kType=@"minute"; //默认 分时
    
    self.lastTime=@"";
    
    [self navView];
    
    [self bottomView];
    
    [self tableView];
    
    [self requestNetWork_Coin_Data:self.kType];
    
//    [self requestNetWork_Deal];
    
    //self.bottomView.hidden=NO;
  
    self.currentDealPage = 1;
    
    self.lxy_klineType = LXY_KLINETYPETIME;
    
    
}



#pragma mark -  当前币种详情数据 K线
-(void)requestNetWork_Coin_Data:(NSString *)kType
{
    NSString *pagesize = [NSString stringWithFormat:@"%ld",pageSize];
    NSDictionary *dict=@{@"code":self.model.code,
                         @"pageSize":pagesize,
                         @"goodsType":kType
                         };
    
    WS(weakSelf);
    
//   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:[NSString stringWithFormat:@"%@",GE_index_URL] RequestType:RequestTypeGet Parameters:dict Success:^(NSInteger statusCode, id responseObject) {
        
//        [hud hideAnimated:YES];
        
        NSLog(@"k线------%@",responseObject);
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            weakSelf.klineArray=[Market_Chart_Detail_KLine_Model mj_objectArrayWithKeyValuesArray:network_Model.data];
            
            if (weakSelf.klineArray.count>0)
            {
                if (![weakSelf.lastTime isEqualToString:weakSelf.klineArray[0].date])
                {
                    
                    weakSelf.lastTime=weakSelf.klineArray[0].date;
                    
//                    [weakSelf.tableView reloadData];
                    [self->kline_Cell initWithCellArray:self.klineArray andCurrentPrice:self.model.price andKtype:self.kType andIsTime:self.lxy_klineType];
                }
            }
            
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
//        [hud hideAnimated:YES];
    }];
    
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
        
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        //K线cell
        [_tableView registerClass:[Market_Chart_Detail_KLine_Cell class] forCellReuseIdentifier:kline_CellID];
        
        //成交行cell
        [_tableView registerClass:[Market_Chart_Detail_Order_List_Cell class] forCellReuseIdentifier:order_List_CellID];
        
        //成交 标题行cellorder_ListTop_CellID
        [_tableView registerClass:[Market_Chart_Detail_Order_ListTop_Cell class] forCellReuseIdentifier:order_ListTop_CellID];
        
        //头部价格 分区
        [_tableView registerClass:[Market_Chart_Detail_Price_Section_View class] forHeaderFooterViewReuseIdentifier:price_SectionID];
        
        //成交、简介 分区
        [_tableView registerClass:[Market_Chart_Detail_Type_Section_View class] forHeaderFooterViewReuseIdentifier:type_SectionID];
        
        //简介-币种公共cell
        [_tableView registerClass:[Market_Chart_Detail_Intro_List_Cell class] forCellReuseIdentifier:intro_List_CellID];
        
        //简介-币种简介
        [_tableView registerClass:[Market_Chart_Detail_Intro_detail_Cell class] forCellReuseIdentifier:intro_Detail_CellID];
        
 
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
        
        CGFloat tableViewH=70+kBottomSpace;
        
        if (self.isHidden)
        {
           // tableViewH=0;
        }
        
        
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@0);
            
            make.width.equalTo(@(ScreenWidth));
            
            make.top.equalTo(self.navView.mas_bottom);
            
            make.height.equalTo(@(ScreenHeight-Height_NavBar-tableViewH));
            
        }];
       /* WS(weakSelf);
        _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
            [weakSelf requestNetWork_DealAddApi];
        }];*/
    }
    
    return _tableView;
}

#pragma mark  -  分区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1.0;
}

#pragma mark - 各个分区对应的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) //成交、简介 分区 行数
    {
        if([WLTools judgeString:self.model.name])
        {
            return 5+1;
        }
        else
        {
            return 0.0;
        }
    
    }
    else  //头部 价格 分区 行数
    {
        return 1.0;
    }

}

#pragma mark - 遍历cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) //K线视图
    {
        kline_Cell=[tableView dequeueReusableCellWithIdentifier:kline_CellID forIndexPath:indexPath];
        
        kline_Cell.tag=3000;
        
        if (self.klineArray.count>0)
        {
            
            [kline_Cell initWithCellArray:self.klineArray andCurrentPrice:self.model.price andKtype:self.kType andIsTime:self.lxy_klineType];
        }
        
        WS(weakSelf);
        
        kline_Cell.itemBlock = ^(NSInteger type) {
          
            [weakSelf item_Btn_Event:type];
        };
       
        
        return kline_Cell;
    }
    else
    {

        if(indexPath.row==5)//简介详情
        {
            Market_Chart_Detail_Intro_detail_Cell *intro_Detal_Cell=[tableView dequeueReusableCellWithIdentifier:intro_Detail_CellID forIndexPath:indexPath];
            
            [intro_Detal_Cell initWitCellModel:self.model];
            
            return intro_Detal_Cell;
        }
        else
        {
            Market_Chart_Detail_Intro_List_Cell *intro_Cell=[tableView dequeueReusableCellWithIdentifier:intro_List_CellID forIndexPath:indexPath];
            
            [intro_Cell initWithCellModel:self.model andTitle:self.array[indexPath.row] andIndexPath:indexPath];
            
            return intro_Cell;
        }
            
    }
}

#pragma mark - 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) //K线视图
    {
        return ScaleH(400);
    }
    else if(indexPath.section==1)
    {

        if([WLTools judgeString:self.model.name])
        {
            if (indexPath.row==5) //简介详情
            {
                CGFloat webHeight=[WLTools getStringWidth:self.model.name fontSize:14.0];
                
                return webHeight;
            }
            else //简介 数据行
            {
                return 50.0;
            }
        
        }
        else
        {
            return 0.0;
        }
  
    }
    else
    {
        return 0.0;
    }
}

#pragma mark - 分区高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) //头部 价格分区
    {
        return 120.0;
    }
    else //成交、简介分区
    {
        return 46.0;
    }
}

#pragma mark - 遍历分区视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) //价格分区视图
    {
        price_SectionView=[tableView dequeueReusableHeaderFooterViewWithIdentifier:price_SectionID];
        
        [price_SectionView initWithSectionModel:self.model];
        
        return price_SectionView;
    }
    else //成交、 简介分区视图
    {
        Market_Chart_Detail_Type_Section_View *type_SectionView=[tableView dequeueReusableHeaderFooterViewWithIdentifier:type_SectionID];
        
        WS(weakSelf);
        
        type_SectionView.itemBlock = ^(NSInteger type) {
          
            weakSelf.type=type;
            
            weakSelf.tableView.mj_footer.hidden = weakSelf.type == 2;
            [weakSelf.tableView reloadData];
        };
        
        return type_SectionView;
    }
}


#pragma mark - 每个按钮点击
-(void)item_Btn_Event:(NSInteger)type
{
    if (type==0)
    {
        self.kType=@"minute";
        self.lxy_klineType = LXY_KLINETYPETIME;
    }
    if (type==1)
    {
        self.kType=@"minute5";
        self.lxy_klineType = LXY_KLINETYPEKLINE;
    }
    else if(type == 2)
    {
        self.kType = @"minute30";
        self.lxy_klineType = LXY_KLINETYPEKLINE;
    }
    else if(type==3)
    {
        self.kType=@"minute60";
        self.lxy_klineType = LXY_KLINETYPEKLINE;
    }
    else if(type==4)
    {
        self.kType=@"day";
        self.lxy_klineType = LXY_KLINETYPEKLINE;
    }
//    else if(type==5)
//    {
//        self.kType=@"day";
//        self.lxy_klineType = LXY_KLINETYPEKLINE;
//    }
//    else if(type==6)
//    {
//        self.kType=@"day";
//    }
    
    self.lastTime=@"";
    
    [self requestNetWork_Coin_Data:self.kType];
    
}


#pragma mark - 导航栏
-(Market_Chart_Nav_View *)navView
{
    if (_navView==nil)
    {
        _navView=[[Market_Chart_Nav_View alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Height_NavBar)];
        
        _navView.titleLabel.text=self.model.name;
        
        [self.view addSubview:_navView];
        
        WS(weakSelf);
        
        _navView.backBtnBlock = ^{
          
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    
    return _navView;
}

#pragma mark - 页面即将呈现
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=YES;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //判断是否开启socket链接
    if ([[ManagerSocket sharedManager] socketIsConnected] == NO)
    {
        [self loadSocketMarketListData];
    }
}

#pragma mark - 页面即将消失
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden=NO;
        
    [[ManagerSocket sharedManager] closeConnectSocket];
}

#pragma mark - 请求单个币种详情  WebSocket
-(void)loadSocketMarketListData
{
    [[ManagerSocket sharedManager] openConnectSocketWithConnectSuccess:^{
        
        NSString *type = [WLTools wlDictionaryToJson:@{@"sub":[NSString stringWithFormat:@"stock@%@",self.model.code]}];
        [[ManagerSocket sharedManager] socketSendMsg:type];
        
    }];
    
    [ManagerSocket sharedManager].delegate =self;
}

#pragma mark -- ManagerSocketDelegate
-(void)socketDidReciveData:(id)data
{
    
    Market_Main_List_Model *socketModel=[Market_Main_List_Model mj_objectWithKeyValues:data];
    
    LXY_KLine_DataModel *klineModel = [LXY_KLine_DataModel mj_objectWithKeyValues:data];
    
    if ([self.model.code isEqualToString:socketModel.code])
    {
        self.model=socketModel;
        
        [price_SectionView initWithSectionModel:self.model];
        
        NSInteger time;
        
        if ([self.kType isEqualToString:@"minute"]) {
            time = 1;
        }else if ([self.kType isEqualToString:@"minute30"]){
            time = 30;
        }else if ([self.kType isEqualToString:@"minute60"]){
            time = 60;
        }else if ([self.kType isEqualToString:@"minute120"]){
            time = 120;
        }else{
            time = 24 * 60;
        }
        
        [kline_Cell.klineView refreshWithSocketData:klineModel minuteInvital:time];
        
//        if (self.klineArray.count > 0) {
//            [self.klineArray replaceObjectAtIndex:0 withObject:klineModel];
//
//            [kline_Cell initWithCellArray:self.klineArray andCurrentPrice:self.model.price andKtype:self.kType andIsTime:self.lxy_klineType];
//        }
//        [self requestNetWork_Coin_Data:self.kType];
        
    }

}


#pragma mark - 底部视图
-(Market_Chart_Bottom_View *)bottomView
{
    if (_bottomView==nil)
    {
        _bottomView=[[Market_Chart_Bottom_View alloc] initWithFrame:CGRectMake(0,ScreenHeight-70-kBottomSpace, ScreenWidth,70+kBottomSpace)];
        
        [self.view addSubview:_bottomView];
        
        
        if (self.isHidden)
        {
            [_bottomView oneSingleClicked];
        }
        
        WS(weakSelf);
        
        _bottomView.itmeBlock = ^(NSInteger type) {
            
            if (type ==2) {//买入
                //改变数据
                [ManagerGlobeUntil sharedManager].goodsCode = weakSelf.model.code;
                
                [ManagerGlobeUntil sharedManager].DefalutSeleted = NO;
                
            }else{//卖出
                
                [ManagerGlobeUntil sharedManager].goodsCode = weakSelf.model.code;
                
                [ManagerGlobeUntil sharedManager].DefalutSeleted = YES;
            }
            
            [weakSelf.tabBarController setSelectedIndex:2];
            
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
        
    }
    
    return _bottomView;
}

#pragma mark - K线 数据源数组
-(NSMutableArray<Market_Chart_Detail_KLine_Model *> *)klineArray
{
    if (_klineArray==nil)
    {
        _klineArray=[NSMutableArray array];
    }
    
    return _klineArray;
}

#pragma mark - 成交数组
-(NSMutableArray<Market_Chart_Detail_Deal_Model *> *)dealArray
{
    if (_dealArray==nil)
    {
        _dealArray=[NSMutableArray array];
    }
    
    return _dealArray;
}

#pragma mark - 简介数组
-(NSMutableArray<Market_Chart_Detail_Intro_Model *> *)introArray
{
    if (_introArray==nil)
    {
        _introArray=[NSMutableArray array];
    }
    
    return _introArray;
}

#pragma mark - 数组
-(NSArray *)array
{
    if (_array==nil)
    {
        _array=[[NSArray alloc] initWithObjects:@"",SSKJLocalized(@"发行时间", nil),SSKJLocalized(@"发行总量", nil),SSKJLocalized(@"白皮书", nil),SSKJLocalized(@"官网", nil),@"",nil];
    }
    
    return _array;
}


#pragma mark - 初始化
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //[ManagerSocket sharedManager].delegate = nil;
}

@end
