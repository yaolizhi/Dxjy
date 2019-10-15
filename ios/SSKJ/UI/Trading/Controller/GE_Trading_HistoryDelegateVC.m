//
//  GE_Trading_HistoryDelegateVC.m
//  SSKJ
//
//  Created by 张超 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Trading_HistoryDelegateVC.h"
#import "GE_Trading_CurrentDelegateCell.h"
#import "GE_Trading_HistoryDelegateCell.h"
#import "Transaction_HistoryTransactionInquiry_HeaderView.h"
#import "BRDatePickerView.h"
#import "NSDate+BRAdd.h"

#import "GE_Trading_HistioryOrder_Model.h"

#import "SSKJ_NoDataView.h"

#define KpageSize @"10"


@interface GE_Trading_HistoryDelegateVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
// 时间选择view
@property (nonatomic, strong) Transaction_HistoryTransactionInquiry_HeaderView *headerView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,assign) NSInteger page;


@end

@implementation GE_Trading_HistoryDelegateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self.typeStr isEqualToString:@"委托"]) {
        self.title = SSKJLocalized(@"历史委托", nil);
    }else{
        self.title = SSKJLocalized(@"历史成交", nil);
    }
    
    [self.view addSubview:self.headerView];
    
    [self.view addSubview:self.tableView];
    
    self.page = 1;
    
    [self requestHistoryChiCangUrl];
}

- (void)headerRefresh
{
    self.page = 1;
    
    [self.dataSource removeAllObjects];
    
    [self requestHistoryChiCangUrl];
}

- (void)footerRefresh
{
    self.page ++ ;
    
    [self requestHistoryChiCangUrl];
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
            make.top.equalTo(@(self.headerView.height));
            
            make.left.right.equalTo(@0);
            
            make.bottom.equalTo(@(0));
        }];
        
    }
    return _tableView;
}

- (Transaction_HistoryTransactionInquiry_HeaderView *)headerView {
    if (!_headerView) {
        CGRect frame = CGRectMake(0
                                  , 0
                                  , ScreenWidth
                                  , ScaleH(78));
        _headerView = [[Transaction_HistoryTransactionInquiry_HeaderView alloc]initWithFrame:frame];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.delegate = (id<Transaction_HistoryTransactionInquiry_HeaderViewDelegate>)self;
        _headerView.startDateLabel.text = [self getBeforeOfNDay:[NSDate date] withDay:7];
        _headerView.endDateLabel.text = [self getCurrentDate];
    }
    return _headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
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
    
    
//    GE_Trading_HistoryDelegateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//
//    if (cell == nil) {
//        cell = [[NSBundle mainBundle] loadNibNamed:@"GE_Trading_HistoryDelegateCell" owner:nil options:nil][0];
//    }
//
//    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//    [cell setDataWithModel:self.dataSource[indexPath.section] type:@""];
//
//    return cell;
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


#pragma mark -- 历史订单列表 --
- (void)requestHistoryChiCangUrl
{
    NSDictionary *params;
    
    if ([self.typeStr isEqualToString:@"委托"]) {
        params = @{@"account":[[SSKJ_User_Tool sharedUserTool] getAccount],
                   @"action":@"dealInfo",
                   @"entrust1":self.headerView.startDateLabel.text,
                   @"entrust2":self.headerView.endDateLabel.text,
                   @"page":@(self.page),
                   @"pageSize":KpageSize,
                   @"sessionId":[[SSKJ_User_Tool sharedUserTool] getToken]
                   };
    }
    else
    {
        params = @{@"account":[[SSKJ_User_Tool sharedUserTool] getAccount],
                   @"action":@"dealInfo",
                   @"entrust1":self.headerView.startDateLabel.text,
                   @"entrust2":self.headerView.endDateLabel.text,
                   @"billStatus":@(4),
                   @"page":@(self.page),
                   @"pageSize":KpageSize,
                   @"sessionId":[[SSKJ_User_Tool sharedUserTool] getToken]
                   };
    }
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_Pubilc_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
//        NSLog(@"历史订单列表:%@",responseObject);
        WL_Network_Model *networkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (networkModel.status.integerValue == 200) {
            if ([networkModel.data[@"list"] isKindOfClass:[NSArray class]]) {
                
                NSArray *array = networkModel.data[@"list"];
                
                if (array.count != KpageSize.integerValue) {
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


#pragma mark -- Transaction_HistoryTransactionInquiry_HeaderViewDelegate
- (void)selectedStartDate {
    __weak typeof(self)weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"起始日期" dateType:UIDatePickerModeDate defaultSelValue:[self getBeforeOfNDay:[NSDate date] withDay:7] minDateStr:@"" maxDateStr:@"" isAutoSelect:NO resultBlock:^(NSString *selectValue) {
        if ([weakSelf compareDate:selectValue withDate:self.headerView.endDateLabel.text] < 0) {//开始日期大于结束日期
            self.headerView.startDateLabel.text = self.headerView.endDateLabel.text;
        } else {
            self.headerView.startDateLabel.text = selectValue;
        }
        
        [weakSelf headerView];
    }];
}
- (void)selectedEndDate {
    __weak typeof(self)weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"截止日期" dateType:UIDatePickerModeDate defaultSelValue:@"" minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:NO resultBlock:^(NSString *selectValue) {
        if ([weakSelf compareDate:self.headerView.startDateLabel.text withDate:selectValue] < 0) {//结束日期大于开始日期
            self.headerView.endDateLabel.text = self.headerView.startDateLabel.text;
        } else {
            self.headerView.endDateLabel.text = selectValue;
        }
        [weakSelf headerRefresh];
    }];
}

-(int)compareDate:(NSString*)date01 withDate:(NSString*)date02{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending:
            ci=1;
            break;
            //date02比date01小
        case NSOrderedDescending:
            ci=-1;
            break;
            //date02=date01
        case NSOrderedSame:
            ci=0;
            break;
    }
    return ci;
}

//获取n天前的日期
- (NSString*)getBeforeOfNDay:(NSDate *)date withDay:(int)day{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:-day];
    NSDate *dateAfterday = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    NSString *strDate = [formatter stringFromDate:dateAfterday];
    return strDate;
    
}

//获取日期时间通过时间戳
- (NSString*)getDateWithTimestamp:(NSString*)timestamp {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    //    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

//获取当前日期
- (NSString*)getCurrentDate {
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}

-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray array];
    }
    return  _dataSource;
}

@end
