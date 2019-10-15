//
//  Market_Chart_Detail_KLine_Top_View.m
//  ZYW_MIT
//
//  Created by James on 2018/7/28.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Chart_Detail_KLine_Top_View.h"

@interface Market_Chart_Detail_KLine_Top_View()

@property(nonatomic,copy)NSArray *array;

@property(nonatomic,strong)UIView *lineView;

@property(nonatomic,strong)UIView *bottomView;

@property(nonatomic,assign)CGFloat spaceWidth;

@property(nonatomic,assign)CGFloat fontWidth;

@end


@implementation Market_Chart_Detail_KLine_Top_View

#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if (self)
    {
        [self array];
        
        NSString *str=@"30m";
        
        self.fontWidth=[WLTools getStringWidth:str fontSize:16.0]+5;
        
        self.spaceWidth=(ScreenWidth-self.array.count*self.fontWidth)/(self.array.count + 1);
        
        
        [self createUI];
    }
    
    return self;
}

#pragma mark - 创建UI
-(void)createUI
{
    
    CGFloat tempSpace=self.spaceWidth;
    
    for (int i=0; i<self.array.count; i++)
    {
        
        UIButton *buttonItem=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [buttonItem setTitle:self.array[i] forState:UIControlStateNormal];
        
        [buttonItem setTitleColor:UIColorFromRGB(0xeeeeee) forState:UIControlStateNormal];
        
        [buttonItem setTitleColor:UIColorFromRGB(0x87abfe) forState:UIControlStateSelected];
        
        buttonItem.selected=i==0?YES:NO;
        
        buttonItem.titleLabel.font=WLFontSize(16.0);
        
        buttonItem.tag=1000+i;
        
        [buttonItem addTarget:self action:@selector(item_Button_Event:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:buttonItem];
        
        [buttonItem mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@(tempSpace));
            
            make.centerY.equalTo(self.mas_centerY).offset(-6);
            
            make.width.equalTo(@(self.fontWidth));
        }];
        
        
        tempSpace+=self.spaceWidth+self.fontWidth;
    }
    
    //分割线
    [self lineView];
    
    //底部分割线
    [self bottomView];
}

#pragma mark - 底部分割线
-(UIView *)bottomView
{
    if (_bottomView==nil)
    {
        _bottomView=[[UIView alloc] init];
        
        _bottomView.backgroundColor=[WLTools stringToColor:@"#071827"];
        
        [self addSubview:_bottomView];
        
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@0);
            
            make.bottom.equalTo(self.mas_bottom);
            
            make.width.equalTo(@(ScreenWidth));
            
            make.height.equalTo(@4.0);
        }];
    }
    
    return _bottomView;
}



#pragma mark - 分割线
-(UIView *)lineView
{
    if (_lineView==nil)
    {
        _lineView=[[UIView alloc] init];
        
        _lineView.backgroundColor=UIColorFromRGB(0x87abfe);
        
        [self addSubview:_lineView];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@(self.spaceWidth+5));
            
            make.height.equalTo(@2.0);
            
            make.width.equalTo(@(self.fontWidth-10));
            
            make.bottom.equalTo(self.mas_bottom).offset(-4);
        }];
    }
    
    return _lineView;
}

#pragma mark - 数据源
-(NSArray *)array
{
    if (_array==nil)
    {
        _array=[[NSArray alloc] initWithObjects:SSKJLocalized(@"分时", nil),@"1M",@"5M",@"15M",@"30M",@"1H",SSKJLocalized(@"日线", nil), nil];
    }
    
    return _array;
}

#pragma mark - 点击事件
-(void)item_Button_Event:(UIButton *)sender
{
    NSInteger tag=sender.tag-1000;
    
    CGFloat tempSpace=self.spaceWidth+5;
    
    for (int i=0; i<self.array.count; i++)
    {
        UIButton *itemButton=[self viewWithTag:1000+i];
        
        if (tag==i)
        {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                [self.lineView setLeft:tempSpace];
                
            }];
            
            sender.selected=YES;
        }
        else
        {
            itemButton.selected=NO;
        }
        
        tempSpace+=self.spaceWidth+self.fontWidth;
        
    }
    
    if (self.itemBlock)
    {
        self.itemBlock(tag);
    }
}


@end
