//
//  GE_Trading_ChooseGoods_View.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Trading_ChooseGoods_View.h"



@interface GE_Trading_ChooseGoods_View()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *goodsArray;

@end

@implementation GE_Trading_ChooseGoods_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self tableView];
        
        
    }
    return self;
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
        
        [self addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.right.equalTo(@0);
            
            make.bottom.equalTo(@(0));
        }];
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    GE_Trading_goodsModel *model = self.goodsArray[indexPath.row];
    cell.backgroundColor = UIColorFromRGB(0xF5F5F5);
    cell.textLabel.text = model.name;
    cell.textLabel.textColor = kMainBlackColor;
    cell.textLabel.font = systemFont(13);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.ChooseGoodsBlock)
    {
        self.ChooseGoodsBlock(self.goodsArray[indexPath.row]);
    }
}


-(void)setDataSource:(NSArray *)dataSource
{
    self.goodsArray = dataSource;
    
    [self.tableView reloadData];
}


@end
