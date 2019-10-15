//
//  GE_Mine_OutPrice_VC.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_OutPrice_VC.h"

#import "GE_Mine_IntoPrice_Cell.h"

#import "GE_Mine_Into_SectionView.h"

#import "Transaction_HistoryTransactionInquiry_HeaderView.h"

#import "BRDatePickerView.h"

#import "SSKJ_NoDataView.h"

#define kPage_size @"10"

@interface GE_Mine_OutPrice_VC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) GE_Mine_Into_SectionView *headerView;

@property (nonatomic,strong) Transaction_HistoryTransactionInquiry_HeaderView *timeView;

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;

@end

@implementation GE_Mine_OutPrice_VC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.dataSource = [[NSMutableArray alloc] init];
    
    self.title = @"出金查询";
    self.page = 1;
    
    [self timeView];
    
    [self tableView];
    
    [self headerView];
    
    [self httpRequest];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GE_Mine_IntoPrice_Cell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"IntoPrice%ld",indexPath.row]];
    
    if (!cell)
    {
        cell = [[GE_Mine_IntoPrice_Cell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[NSString stringWithFormat:@"chicangView%ld",indexPath.row]];
    }
    
    
    [cell initModel:self.dataSource[indexPath.row] type:2];
    
    return cell;
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
            
            make.left.right.bottom.equalTo(@0);
            
            make.top.equalTo(@(ScaleH(85)));
            
        }];
        
    }
    return _tableView;
}

- (GE_Mine_Into_SectionView *)headerView
{
    if (_headerView == nil) {
        
        _headerView = [[GE_Mine_Into_SectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        
        _headerView.backgroundColor = kMainWihteColor;
        
        self.tableView.tableHeaderView = _headerView;
    }
    return _headerView;
}

- (Transaction_HistoryTransactionInquiry_HeaderView *)timeView
{
    if (_timeView == nil) {
        
        _timeView = [[Transaction_HistoryTransactionInquiry_HeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(78))];
        
        _timeView.backgroundColor = kMainWihteColor;
        
        _timeView.delegate = (id<Transaction_HistoryTransactionInquiry_HeaderViewDelegate>)self;
        
        _timeView.startDateLabel.text = [self getBeforeOfNDay:[NSDate date] withDay:7];
        
        _timeView.endDateLabel.text = [self getCurrentDate];
        
        [self.view addSubview:_timeView];
        
    }
    return _timeView;
}

#pragma mark -- Transaction_HistoryTransactionInquiry_HeaderViewDelegate
- (void)selectedStartDate {
    __weak typeof(self)weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"起始日期" dateType:UIDatePickerModeDate defaultSelValue:[self getBeforeOfNDay:[NSDate date] withDay:7] minDateStr:@"" maxDateStr:@"" isAutoSelect:NO resultBlock:^(NSString *selectValue) {
        if ([weakSelf compareDate:selectValue withDate:self.timeView.endDateLabel.text] < 0) {//开始日期大于结束日期
            self.timeView.startDateLabel.text = self.timeView.endDateLabel.text;
        } else {
            self.timeView.startDateLabel.text = selectValue;
        }
        
                [weakSelf headerRefresh];
    }];
}
- (void)selectedEndDate {
    __weak typeof(self)weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"截止日期" dateType:UIDatePickerModeDate defaultSelValue:@"" minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:NO resultBlock:^(NSString *selectValue) {
        if ([weakSelf compareDate:self.timeView.startDateLabel.text withDate:selectValue] < 0) {//结束日期大于开始日期
            self.timeView.endDateLabel.text = self.timeView.startDateLabel.text;
        } else {
            self.timeView.endDateLabel.text = selectValue;
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

//出金查询
- (void)httpRequest
{
    NSDictionary *params = @{@"account":[SSKJ_User_Tool sharedUserTool].getAccount,
                             @"type":@"cash",
                             @"starttime":self.timeView.startDateLabel.text,
                             @"endtime":self.timeView.endDateLabel.text,
                             @"p":@(self.page),
                             @"size":kPage_size,
                             @"token":[SSKJ_User_Tool sharedUserTool].getToken,
                             @"systemType":@"IOS"
                             };
    
    WS(weakSelf);
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:[NSString stringWithFormat:@"%@/home/Pay/recordList",ProductBaseServer] RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
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
    NSArray *array = net_model.data[@"res"];
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    if (array.count != kPage_size.integerValue) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
    
    [self endRefresh];
    
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:self.headerView.height];
    
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
