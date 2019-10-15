//
//  Market_Chart_Detail_Order_Cell.m
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Chart_Detail_Order_Cell.h"

#import "Market_Chart_Detail_Order_List_Cell.h"

#import "Market_Chart_Detail_Order_Section_View.h"

static NSString *orderList_CellID=@"orderList_CellID";

static NSString *orderSectionID=@"orderSectionID";

@implementation Market_Chart_Detail_Order_Cell

#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle=UITableViewCellAccessoryNone;
        
        self.contentView.backgroundColor=[WLTools stringToColor:@"#151824"];
        
        [self createUI];
    }
    
    return self;
}

#pragma mark - 创建UI
-(void)createUI
{
    [self orderTableView];
}

#pragma mark - 表格视图
-(UITableView *)orderTableView
{
    if (_orderTableView==nil)
    {
        _orderTableView=[[UITableView alloc] init]; //initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)
        
        _orderTableView.delegate=self;
        
        _orderTableView.dataSource=self;
        
        _orderTableView.backgroundColor=[WLTools stringToColor:@"#151824"];
        
        _orderTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        [_orderTableView registerClass:[Market_Chart_Detail_Order_List_Cell class] forCellReuseIdentifier:orderList_CellID];
        
        [_orderTableView registerClass:[Market_Chart_Detail_Order_Section_View class] forHeaderFooterViewReuseIdentifier:orderSectionID];
        
        if (@available(iOS 11.0, *))
        {
            _orderTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _orderTableView.estimatedRowHeight = 0;
            _orderTableView.estimatedSectionHeaderHeight = 0;
            _orderTableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.autoresizesSubviews=NO;
        }
        
        [self.contentView addSubview:_orderTableView];
        
        [_orderTableView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self.contentView.mas_left);

            make.width.equalTo(@(ScreenWidth));

            make.top.equalTo(self.contentView.mas_top);
            
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
    
    return _orderTableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dealArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Market_Chart_Detail_Order_List_Cell *order_Cell=[tableView dequeueReusableCellWithIdentifier:orderList_CellID forIndexPath:indexPath];
    
    Market_Chart_Detail_Deal_Model *detial_Model=self.dealArray[indexPath.row];
    
    [order_Cell initWithCellModel:detial_Model];
    
    return order_Cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    Market_Chart_Detail_Order_Section_View *section_View=[tableView dequeueReusableHeaderFooterViewWithIdentifier:orderSectionID];
    
    [section_View initWithSection:self.code];
    
    return section_View;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

-(void)initWithCellArrayModel:(NSMutableArray<Market_Chart_Detail_Deal_Model *> *)dealArray andCode:(NSString *)code;
{
    self.dealArray=dealArray;
    
    self.code=code;
    
    if (self.dealArray.count>0)
    {
       [self.orderTableView reloadData];
    }
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
