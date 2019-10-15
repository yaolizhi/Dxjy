//
//  Martet_Search_ViewController.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/5/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Martet_Search_ViewController.h"
#import "Market_Search_Cell.h"
#import "Market_Main_List_Model.h"
#import "Market_Search_Model.h"
@interface Martet_Search_ViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UISearchBar * searchBar ;

@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation Martet_Search_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self tableView];
    
    [self requestSearchURl];
    
}

#pragma mark - 页面即将显示
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - 页面即将消失
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    
}

- (void)setNav{
   
    UIView *navView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, ScreenWidth, Height_NavBar) Color:kMainColor];
    [self.view addSubview:navView];
    
    UIView*titleView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15),Height_NavBar - ScaleW(35),ScreenWidth-ScaleW(70),ScaleW(30))];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth -ScaleW(70), ScaleW(30))];
    self.searchBar.placeholder = SSKJLocalized(@"请输入股票名称或代码搜索", nil);
    self.searchBar.text = self.searchStr;
    self.searchBar.layer.cornerRadius = ScaleW(15);
    self.searchBar.layer.masksToBounds = YES;
    self.searchBar.delegate = self;
    //设置背景图是为了去掉上下黑线
    self.searchBar.backgroundImage = [[UIImage alloc] init];
   
    //设置背景色
    self.searchBar.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
    self.searchBar.showsSearchResultsButton=NO;
    [self.searchBar setImage:[UIImage imageNamed:@"Search_Icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    UITextField*searchField = [_searchBar valueForKey:@"_searchField"];
    if(searchField) {
        [searchField setBackgroundColor:[UIColor clearColor]];
        [searchField setValue:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    }
    // 输入文本颜色
    searchField.textColor= [UIColor blackColor];
    searchField.font= [UIFont systemFontOfSize:15];
    // 默认文本大小
    [searchField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    //只有编辑时出现出现那个叉叉
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [titleView addSubview:self.searchBar];
    //Set to titleView
    [navView addSubview:titleView];
    
    UIButton *backBtn = [FactoryUI createButtonWithFrame:CGRectMake(ScreenWidth - ScaleW(55), 0, ScaleW(55), ScaleW(40)) title:SSKJLocalized(@"取消", nil) titleColor:kMainWihteColor imageName:nil backgroundImageName:nil target:self selector:@selector(backBtnActoin) font:systemFont(15)];
    backBtn.centerY = titleView.centerY;
    [navView addSubview:backBtn];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.searchStr = searchBar.text;
    [self requestSearchURl];
}

- (void)backBtnActoin{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 表格视图
-(UITableView *)tableView{
    if (_tableView==nil){
        _tableView=[[UITableView alloc] init];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kMainBackgroundColor;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)){
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(@(Height_NavBar));
            make.width.equalTo(@(ScreenWidth));
            make.bottom.equalTo(@(0));
        }];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScaleW(50);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Market_Search_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    if (cell == nil) {
        cell = [[Market_Search_Cell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SearchCell"];
    }
    
    [cell initDataWithModel:self.dataSource[indexPath.row] index:self.index];
    
    WS(weakSelf);
    
    cell.AddZiXuanBlock = ^(Market_Search_Model * _Nonnull model) {
        [weakSelf requestGE_add_optional_URL:model];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Market_Search_Model *model = self.dataSource[indexPath.row];
    if (self.index == 2) {
        self.SearchCodeBlock(model.code);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark  -- 搜索数据 --
- (void)requestSearchURl{
    
    [self.dataSource removeAllObjects];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = @{@"code":self.searchStr};
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_search_all_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200) {
            weakSelf.dataSource = [Market_Search_Model mj_objectArrayWithKeyValuesArray:netModel.data];
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        [hud hideAnimated:YES];
        [self.tableView reloadData];
        [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        
    }];
}

#pragma mark  -- 添加自选 --
- (void)requestGE_add_optional_URL:(Market_Search_Model *)model{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = @{@"code":model.code};
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_add_optional_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200) {
            [MBProgressHUD showError:@"添加成功"];
//            [weakSelf requestSearchURl];
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        [hud hideAnimated:YES];
        [self.tableView reloadData];
        [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        
    }];
}

-(NSMutableArray *)dataSource{
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
