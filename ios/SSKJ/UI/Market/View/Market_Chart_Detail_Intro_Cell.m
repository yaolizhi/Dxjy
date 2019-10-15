//
//  Market_Chart_Detail_Intro_Cell.m
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Chart_Detail_Intro_Cell.h"

#import "Market_Chart_Detail_Intro_List_Cell.h"

#import "Market_Chart_Detail_Intro_detail_Cell.h"

static NSString *list_CellID=@"list_CellID";

static NSString *detail_CellID=@"detail_CellID";

@implementation Market_Chart_Detail_Intro_Cell

#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle=UITableViewCellAccessoryNone;
        
        self.contentView.backgroundColor=[WLTools stringToColor:@"#151824"];
        
        [self array];
        
        [self createUI];
    }
    
    return self;
}

#pragma mark - 数组
-(NSArray *)array
{
    if (_array==nil)
    {
        _array=[[NSArray alloc] initWithObjects:@"",SSKJLocalized(@"发行时间", nil),SSKJLocalized(@"发行总量", nil),SSKJLocalized(@"流通总量", nil),SSKJLocalized(@"众筹价格", nil),SSKJLocalized(@"白皮书", nil),SSKJLocalized(@"官网", nil),@"",nil];
    }
    
    return _array;
}

#pragma mark - 创建UI
-(void)createUI
{
    [self introTableView];
}

#pragma mark - 表格视图
-(UITableView *)introTableView
{
    if (_introTableView==nil)
    {
        _introTableView=[[UITableView alloc] init];
        
        _introTableView.delegate=self;
        
        _introTableView.dataSource=self;
        
        _introTableView.backgroundColor=[WLTools stringToColor:@"#151824"];
        
        _introTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        [_introTableView registerClass:[Market_Chart_Detail_Intro_List_Cell class] forCellReuseIdentifier:list_CellID];
        
        [_introTableView registerClass:[Market_Chart_Detail_Intro_detail_Cell class] forCellReuseIdentifier:detail_CellID];
        
        if (@available(iOS 11.0, *))
        {
            _introTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _introTableView.estimatedRowHeight = 0;
            _introTableView.estimatedSectionHeaderHeight = 0;
            _introTableView.estimatedSectionFooterHeight = 0;
        }
        
        
        [self.contentView addSubview:_introTableView];
        
        [_introTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@0);
            
            make.width.equalTo(@(ScreenWidth));
            
            make.top.equalTo(@0);
            
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
    
    return _introTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==7)
    {
        Market_Chart_Detail_Intro_detail_Cell *detail_Cell=[tableView dequeueReusableCellWithIdentifier:detail_CellID forIndexPath:indexPath];
        
        [detail_Cell initWitCellModel:self.model];
        
        return detail_Cell;
    }
    else
    {
        Market_Chart_Detail_Intro_List_Cell *list_Cell=[tableView dequeueReusableCellWithIdentifier:list_CellID forIndexPath:indexPath];
        
        [list_Cell initWithCellModel:self.model andTitle:self.array[indexPath.row] andIndexPath:indexPath];
        
        return list_Cell;
    }
    
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==7)
    {
        CGFloat webHeight=[WLTools getStringWidth:self.model.info fontSize:14.0];
        
        return webHeight;
    }
    else
    {
       return 50.0;
    }
    
}

-(void)initWithCellModel:(Market_Chart_Detail_Intro_Model *)model
{
    self.model=model;
    
    [self.introTableView reloadData];
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
