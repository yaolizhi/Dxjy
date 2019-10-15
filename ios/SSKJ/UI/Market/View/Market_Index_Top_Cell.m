//
//  Market_Index_Top_Cell.m
//  ZYW_MIT
//
//  Created by James on 2018/8/22.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Index_Top_Cell.h"

@interface Market_Index_Top_Cell()

@end

@implementation Market_Index_Top_Cell

#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.contentView.backgroundColor=kMainWihteColor;
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [self createUI];
    }
    
    return self;
}

#pragma mark - 创建UI
-(void)createUI
{
    
    [self headerView];
    
    [self noticeView];
    
    [self logoIMV];
    
    [self gonggaoBtn];
    
    [self verLineView];
    
    [self scrollTextView];
//    [self gonggaoDetailBtn];
    
    [self gonggaomoreBtn];
    
    [self spaceView];
    
    [self topLineView];
    
    
    //[self bottomLineView];
    
}


#pragma mark - 头部轮播视图
-(SDCycleScrollView *)headerView
{
    if (_headerView==nil)
    {
        UIImage *imageHeight=[UIImage imageNamed:@"Market_banner"];
        
        _headerView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, ScreenWidth, imageHeight.size.height) delegate:self placeholderImage:[UIImage imageNamed:@"Market_DefailtBanner"]];
        _headerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _headerView.delegate = self;
        _headerView.backgroundColor = kMainBackgroundColor;
        _headerView.autoScrollTimeInterval = 3.0;
        _headerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _headerView.currentPageDotColor = kMainColor;
        _headerView.pageDotColor = [WLTools stringToColor:@"#eeeeee"];
        _headerView.currentPageDotImage = [UIImage imageNamed:@"banner_SeletedImg"];
        _headerView.pageDotImage = [UIImage imageNamed:@"banner_normalImg"];
        [self.contentView addSubview:_headerView];
        
        [_noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.top.equalTo(@0);
            
            make.height.equalTo(@(imageHeight.size.height));
            
            
        }];
    }
    
    return _headerView;
}

#pragma mark - 公告背景视图
-(UIView *)noticeView
{
    if (_noticeView==nil)
    {
        _noticeView=[[UIView alloc] init];
        
        _noticeView.backgroundColor=kMainWihteColor;
        
        [self.contentView addSubview:_noticeView];
        
        [_noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@0);
            
            make.width.equalTo(@(ScreenWidth));
            
            make.height.equalTo(@40);
            
            make.top.equalTo(self.headerView.mas_bottom);
            
        }];
    }
    
    return _noticeView;
}

-(UIButton *)gonggaoBtn
{
    if (_gonggaoBtn==nil)
    {
        UIImage *image=[UIImage imageNamed:@"market_gg"];
        
        _gonggaoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        _gonggaoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_gonggaoBtn setImage:image forState:0];
        
        [self.noticeView addSubview:_gonggaoBtn];
        
        [_gonggaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@15);
            
            make.centerY.equalTo(self.noticeView.mas_centerY);
            
            make.width.equalTo(@(image.size.width));
            
            make.height.equalTo(@(image.size.height));
        }];
    }
    
    return _gonggaoBtn;
}

-(UIButton *)gonggaomoreBtn
{

    if (_gonggaomoreBtn==nil)
    {
        UIImage *image=[UIImage imageNamed:@"market_gg"];

        _gonggaomoreBtn=[UIButton buttonWithType:UIButtonTypeCustom];

        _gonggaomoreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

        _gonggaomoreBtn.userInteractionEnabled = NO;

        [_gonggaomoreBtn setTitle:SSKJLocalized(@"更多>", nil) forState:0];

        _gonggaomoreBtn.titleLabel.font = [UIFont systemFontOfSize:14];

        [_gonggaomoreBtn setTitleColor:kMainColor forState:0];

        [self.contentView addSubview:_gonggaomoreBtn];

        [_gonggaomoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.right.equalTo(self.contentView.mas_right).offset(-15);

            make.centerY.equalTo(self.noticeView.mas_centerY);

            make.width.equalTo(@(50));

            make.height.equalTo(@(image.size.height));
        }];
    }

    return _gonggaomoreBtn;
}




#pragma mark - 滚动文本视图
-(LMJScrollTextView2 *)scrollTextView
{
    if (_scrollTextView==nil)
    {
        _scrollTextView=[[LMJScrollTextView2 alloc] init];

        _scrollTextView.delegate=self;

        _scrollTextView.backgroundColor=[UIColor whiteColor];

        _scrollTextView.textColor=[WLTools stringToColor:@"#333333"];

        _scrollTextView.textAlignment=NSTextAlignmentLeft;

        _scrollTextView.touchEnable=YES;

        [self.noticeView addSubview:_scrollTextView];

        [_scrollTextView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self.gonggaoBtn.mas_right).offset(15);

            make.right.equalTo(self.contentView.mas_right).offset(-60);

            make.top.equalTo(self.noticeView.mas_top).offset(0);

            make.bottom.equalTo(self.noticeView.mas_bottom).offset(0);
        }];


    }

    return _scrollTextView;
}


//-(UIButton *)gonggaoDetailBtn
//{
//    if (_gonggaoDetailBtn==nil)
//    {
//        _gonggaoDetailBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//
//        [_gonggaoDetailBtn setTitle:SSKJLocalized(@"公告", nil) forState:0];
//
//        _gonggaoDetailBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//
//        _gonggaoDetailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//
//        [_gonggaoDetailBtn setTitleColor:kMainBlackColor forState:0];
//
//        [_gonggaoDetailBtn addTarget:self action:@selector(gonggaoDetailBtnAction) forControlEvents:UIControlEventTouchUpInside];
//
//        [self.noticeView addSubview:_gonggaoDetailBtn];
//
//        [_gonggaoDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(self.gonggaoBtn.mas_right).offset(15);
//
//            make.right.equalTo(self.contentView.mas_right).offset(-60);
//
//            make.top.equalTo(self.noticeView.mas_top).offset(10);
//
//            make.bottom.equalTo(self.noticeView.mas_bottom).offset(-10);
//        }];
//    }
//
//    return _gonggaoDetailBtn;
//}


#pragma mark - 分割区域
-(UIView *)spaceView
{
    if (_spaceView==nil)
    {
        _spaceView=[[UIView alloc] init];
        
        _spaceView.backgroundColor=LineGrayColor;

        [self.contentView addSubview:_spaceView];
        
        [_spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.noticeView.mas_bottom);
            
            make.left.equalTo(@0);
            
            make.width.equalTo(@(ScreenWidth));
            
            make.height.equalTo(@5);
        }];
    }
    
    return _spaceView;
}

#pragma mark - 头部分割线
-(UIView *)topLineView
{
    if (_topLineView==nil)
    {
        _topLineView=[[UIView alloc] init];
        
        _topLineView.backgroundColor=LineGrayColor;
        
        [self.contentView addSubview:_topLineView];
        
        [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.top.equalTo(@0);
            
            make.width.equalTo(@(ScreenWidth));
            
            make.height.equalTo(@0.5);
            
            make.left.equalTo(@0);
        }];
    }
    
    return _topLineView;
}

#pragma mark - 底部分割线
-(UIView *)bottomLineView
{
    if (_bottomLineView==nil)
    {
        _bottomLineView=[[UIView alloc] init];
        
        _bottomLineView.backgroundColor=kMainBackgroundColor;
        
        [self.noticeView addSubview:_bottomLineView];
        
        [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.noticeView.mas_top);
            
            make.width.equalTo(@(ScreenWidth));
            
            make.height.equalTo(@0.5);
            
            make.left.equalTo(@0);
        }];
    }
    
    return _bottomLineView;
}

- (void)setBannerArray:(NSMutableArray *)bannerArray
{
    [self.sliderArray removeAllObjects];
    
    for (GE_Market_Banner_Model *bannerModel in bannerArray) {
        
        [self.sliderArray addObject:[NSString stringWithFormat:@"%@",bannerModel.banner_url]];
    }
    
    self.headerView.imageURLStringsGroup = self.sliderArray;
}

- (void)setNoticeArray:(NSMutableArray *)noticeArray
{
    [self.gonggaoArray removeAllObjects];
    
    for (GE_Market_Notice_Model *bannerModel in noticeArray) {
        
        [self.gonggaoArray addObject: bannerModel.title];
    }
    self.scrollTextView.textDataArr = self.gonggaoArray;
    
    [self.scrollTextView startScrollBottomToTopWithNoSpace];
//    NSLog(@"self.scrollTextView.textDataArr ====%@",self.scrollTextView.textDataArr);
}



#pragma mark -  点击图片回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.sliderArray.count>0)
    {
        if (self.bannerClickBlock)
        {
            self.bannerClickBlock(index);
        }
    }
}

#pragma mark - LMJScrollTextView2 Delegate
- (void)scrollTextView2:(LMJScrollTextView2 *)scrollTextView clickIndex:(NSInteger)index content:(NSString *)content
{
    if (self.gonggaoArray.count>0)
    {
        if (self.noticeClickBlock)
        {
            self.noticeClickBlock(index);
        }
    }
    
}

- (void)gonggaoDetailBtnAction{
//    if (self.noticeArray.count>0)
//    {
//        if (self.noticeClickBlock)
//        {
//            self.noticeClickBlock(0);
//        }
//    }
}


//#pragma mark - 轮播动态数组
//-(NSMutableArray<Market_Index_Banner_Model *> *)bannerArray
//{
//    if (_bannerArray==nil)
//    {
//        _bannerArray=[NSMutableArray array];
//    }
//
//    return _bannerArray;
//}
//

#pragma mark - 动态轮播图
-(NSMutableArray *)sliderArray
{
    if (_sliderArray==nil)
    {
        _sliderArray=[NSMutableArray array];
    }
    
    return _sliderArray;
}

#pragma mark - 动态公告数组

-(NSMutableArray *)gonggaoArray
{
    if (_gonggaoArray==nil)
    {
        _gonggaoArray=[NSMutableArray array];
    }
    
    return _gonggaoArray;
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
