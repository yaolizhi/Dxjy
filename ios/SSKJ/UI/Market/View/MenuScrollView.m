//
//  MenuScrollView.m
//  MIT-AffordSuperMarket
//
//  Created by GT on 2017/3/10.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import "MenuScrollView.h"
//untils
#import "UIColor+Hex.h"
#import "NSString+Conversion.h"
#import "UIImage+ColorToImage.h"
#define kverticalLineWidth 1.0f
#define kbottomLineHeight 2.0f
@interface MenuScrollView ()
{
    CGFloat _menuItemWidth;//单个menuItem的宽度
    NSInteger _numberOfItems;
    BOOL _isDragged;//滚动是否是有手动拖拽引起的
}
@property(nonatomic, strong)UIImageView *bottomLineView;//底部横线视图
@property(nonatomic, strong)NSMutableArray *verticalLines;//存放垂直分割线
@property(nonatomic, strong)NSMutableArray *menuItems;//存放menuItem视图
@property (nonatomic, strong) UIScrollView *dataScrollView;//!< 显示数据源的scrollView
@property(nonatomic) NSInteger selectCurrentIndex;//内部改变菜单索引
@property(nonatomic, strong)NSMutableArray *titleArray;//存放垂直分割线
@end
@implementation MenuScrollView
- (void)dealloc {
    [_dataScrollView removeObserver:self forKeyPath:@"contentOffset"];
}

//初始化方法
//- (id)initWithFrame:(CGRect)frame titles:(NSArray*)titles dataScrollView:(UIScrollView *)scrollView {
//    self = [super initWithFrame:frame];
//    if (self) {
//        _verticalLines = [[NSMutableArray alloc]init];
//        _menuItems = [[NSMutableArray alloc]init];
//        _titleArray = [[NSMutableArray alloc]init];
//        [_titleArray removeAllObjects];
//        [_titleArray addObjectsFromArray:titles];
//        _numberOfItems = [titles count];
//        _isDragged = NO;
//        //self.showBottomLine = YES;
//        _showVerticalLine = YES;
//        self.dataScrollView = scrollView;
//        [self setupSubViewWithTtitles:titles];
//    }
//    return self;
//}

- (id)initWithFrame:(CGRect)frame attributes:(NSDictionary*)attributes dataScrollView:(UIScrollView *)scrollView {
    self = [super initWithFrame:frame];
    if (self) {
        _verticalLines = [[NSMutableArray alloc]init];
        _menuItems = [[NSMutableArray alloc]init];
        _titleArray = [[NSMutableArray alloc]init];
        [_titleArray removeAllObjects];
        [_titleArray addObjectsFromArray:[attributes objectForKey:@"title"]];
        _numberOfItems = [[attributes objectForKey:@"title"] count];
        _isDragged = NO;
        //self.showBottomLine = YES;
        _showVerticalLine = YES;
        self.dataScrollView = scrollView;
        [self setupSubViewWithTtitles:attributes];
    }
    return self;
}

#pragma mark -- 初始化视图
- (void)setupSubViewWithTtitles:(NSDictionary*)attributes {
    _menuItemWidth = (CGRectGetWidth(self.bounds) - (_numberOfItems -1)*kverticalLineWidth)/_numberOfItems;
    NSArray *titles = [attributes objectForKey:@"title"];
    NSArray *normalImages = [attributes objectForKey:@"normalImage"];
    NSArray *selectedImages = [attributes objectForKey:@"selectedImage"];
    for (NSInteger i = 0; i < [titles count]; i++) {
        //menuItem
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i + 100;
        [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        if (normalImages.count != 0) {
            [btn setImage:[UIImage imageNamed:[NSString stringTransformObject:[normalImages objectAtIndex:i]]] forState:UIControlStateNormal];
        }
        if (selectedImages.count != 0) {
            [btn setImage:[UIImage imageNamed:[NSString stringTransformObject:[selectedImages objectAtIndex:i]]] forState:UIControlStateSelected];
        }
        btn.frame = CGRectMake(i*(_menuItemWidth + kverticalLineWidth)
                                     , 0, _menuItemWidth, CGRectGetHeight(self.bounds));
        btn.titleLabel.font = [UIFont systemFontOfSize:ScaleW(14)];
        [btn setBackgroundColor: [UIColor clearColor]];
        [btn addTarget:self action:@selector(selectedMenuItemEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.menuItems addObject:btn];
        //verticalLine
        if (i != _numberOfItems - 1) {
            UIImageView *verticalLineView = [[UIImageView alloc]init];
            verticalLineView.frame = CGRectMake(CGRectGetMaxX(btn.frame), CGRectGetMinY(btn.frame)
                                                , kverticalLineWidth, CGRectGetHeight(btn.frame));
            [self addSubview:verticalLineView];
            [self.verticalLines addObject:verticalLineView];
        }
        
        //底部视图
        if (self.showBottomLine) {
            [self changeBottomLineViewFrameAnimations:NO];
        }
        
    }
}
//改变底部横线frame
- (void)changeBottomLineViewFrameAnimations:(BOOL)isAnimations{
   UIButton *button = (UIButton*)[self.menuItems objectAtIndex:self.selectCurrentIndex];
    if (isAnimations) {
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomLineView.frame = CGRectMake(CGRectGetMinX(button.frame)+(CGRectGetWidth(button.frame)-CGRectGetWidth(button.titleLabel.frame))/2
                        , CGRectGetHeight(self.bounds) - kbottomLineHeight
                                                   ,CGRectGetWidth(button.titleLabel.frame)
                                                   , kbottomLineHeight);
        }];

    } else {
        CGSize titleSiz =[self setLabelWidthWithNSString:[_titleArray  objectAtIndex:self.selectCurrentIndex] Font:ScaleW(14)];
        self.bottomLineView.frame = CGRectMake(CGRectGetMinX(button.frame)+(CGRectGetWidth(button.frame)-titleSiz.width)/2
                                               , CGRectGetHeight(self.bounds) - kbottomLineHeight
                                               ,titleSiz.width
                                               , kbottomLineHeight);
    }
}

- (void)changeMenuItemFrameWithVerticalLineShowStatus:(BOOL)isShow {
    
    if (!isShow) {
        for (NSInteger i = 0; i < _numberOfItems; i++) {
            UIButton *button = (UIButton*)[self.menuItems objectAtIndex:i];
            CGRect frame = button.frame;
            frame.size.width = CGRectGetWidth(self.bounds)/_numberOfItems;
            frame.origin.x = i*(CGRectGetWidth(self.bounds)/_numberOfItems);
            button.frame = frame;
            
        }
        
        for (UIImageView *imageView in self.verticalLines) {
            imageView.hidden = YES;
        }
    }
}
-(CGSize)setLabelWidthWithNSString:(NSString*)lableText Font:(CGFloat)font
{
    CGSize maxSize = CGSizeMake(Screen_Width, ScaleH(53));
    CGSize curSize = [lableText boundingRectWithSize:maxSize
                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                          attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:font] }
                                             context:nil].size;
    return curSize;
    
}

#pragma mark -- button Action
- (void)selectedMenuItemEvent:(id)sender {
    UIButton *currentButton = (UIButton*)sender;
    
    if ([[currentButton titleForState:UIControlStateNormal]  isEqualToString:SSKJLocalized(@"指标", nil)]) {
        if (self.klineAccessoryBlock) {
            self.klineAccessoryBlock();
        }
        return;
    }
    
    
    NSInteger currentButtonTag = currentButton.tag - 100;
    if ([currentButton.titleLabel.text isEqualToString:@"买入"] || [currentButton.titleLabel.text isEqualToString:@"卖出"]) {
        
    } else {
        if (currentButtonTag == self.selectCurrentIndex) {
            return ;
        }
    }
    
    _isDragged = NO;
    UIButton *oldButton = (UIButton*)[self.menuItems objectAtIndex:self.selectCurrentIndex];
    currentButton.selected = YES;
    oldButton.selected = NO;
    
    self.selectCurrentIndex = currentButtonTag;
    //改变底部横线frame
    [self changeBottomLineViewFrameAnimations:YES];
    //改变scrollView可见区域
    [self.dataScrollView scrollRectToVisible:CGRectMake(currentButtonTag * _dataScrollView.frame.size.width, _dataScrollView.frame.origin.y, _dataScrollView.frame.size.width, _dataScrollView.frame.size.height) animated:YES];
    
    if (_menuScrollDelegate && [_menuScrollDelegate respondsToSelector:@selector(menuScrollView:didSelectedMenuItemAtIndex:)]) {
    [_menuScrollDelegate menuScrollView:self didSelectedMenuItemAtIndex:self.selectCurrentIndex];
    }
}

#pragma mark -- getter method
- (UIImageView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIImageView alloc]init];
        [self addSubview:_bottomLineView];
    }
    return _bottomLineView;
}
#pragma mark -- setter method
//设置是否显示垂直分割线
-(void)setShowVerticalLine:(BOOL)showVerticalLine {
    
    if (_showVerticalLine != showVerticalLine) {
        _showVerticalLine = showVerticalLine;
        [self changeMenuItemFrameWithVerticalLineShowStatus:_showVerticalLine];
    }
}
//设置是否显示底部横线
- (void)setShowBottomLine:(BOOL)showBottomLine {
    if (_showBottomLine != showBottomLine) {
        _showBottomLine = showBottomLine;
        self.bottomLineView.hidden = !showBottomLine;
    }
}
//设置垂直分割线颜色
- (void)setVerticalLineColor:(UIColor *)verticalLineColor {
    for (UIImageView *imageView in self.verticalLines) {
        UIImage *image = [UIImage createImageWithColor:verticalLineColor frame:imageView.bounds];
        imageView.image = image;
    }
}
//设置垂直分割线背景图片
- (void)setVerticalLineImage:(UIImage *)verticalLineImage {
    for (UIImageView *imageView in self.verticalLines) {
        
        imageView.image = verticalLineImage;
    }
}
//设置底部横线颜色
- (void)setBottomLineColor:(UIColor *)bottomLineColor {
     UIImage *image = [UIImage createImageWithColor:bottomLineColor frame:self.bottomLineView.bounds];
    self.bottomLineView.image = image;
}
//设置底部横线背景图片 
- (void)setBottomLineImage:(UIImage *)bottomLineImage {
    self.bottomLineView.image = bottomLineImage;
}

//
- (void)setTabTitleColor:(UIColor *)tabTitleColor {
    for (UIButton *item in self.menuItems) {
        [item setTitleColor:tabTitleColor forState:UIControlStateNormal];
    }
}

- (void)setTabSelectedTitleColor:(UIColor *)tabSelectedTitleColor {
    for (UIButton *item in self.menuItems) {
        [item setTitleColor:tabSelectedTitleColor forState:UIControlStateSelected];
    }
}

- (void)setTabBackgroundColor:(UIColor *)tabBackgroundColor {
    
    for (UIButton *item in self.menuItems) {
        UIImage *image = [UIImage createImageWithColor:tabBackgroundColor frame:item.bounds];
        [item setBackgroundImage:image forState:UIControlStateNormal];
    }
}


- (void)setTabSelectedBackgroundColor:(UIColor *)tabSelectedBackgroundColor {
    for (UIButton *item in self.menuItems) {
        UIImage *image = [UIImage createImageWithColor:tabSelectedBackgroundColor frame:item.bounds];
        [item setBackgroundImage:image forState:UIControlStateSelected];
    }
}
//设置选择item
- (void)setSelectIndex:(NSInteger)selectIndex {
        _isDragged = NO;
        UIButton *currentButton =  (UIButton*)[self.menuItems objectAtIndex:selectIndex];
//        if (selectIndex != 0) {
            UIButton *oldButton = (UIButton*)[self.menuItems objectAtIndex:self.selectCurrentIndex];
            oldButton.selected = NO;
//        }
        currentButton.selected = YES;
        self.selectCurrentIndex = selectIndex;
        //改变底部横线frame
        [self changeBottomLineViewFrameAnimations:NO];
        //改变scrollView可见区域
        [self.dataScrollView scrollRectToVisible:CGRectMake(selectIndex * _dataScrollView.frame.size.width, _dataScrollView.frame.origin.y, _dataScrollView.frame.size.width, _dataScrollView.frame.size.height) animated:NO];
        
        
        if (_menuScrollDelegate && [_menuScrollDelegate respondsToSelector:@selector(menuScrollView:didSelectedMenuItemAtIndex:)]) {
             [_menuScrollDelegate menuScrollView:self didSelectedMenuItemAtIndex:self.selectCurrentIndex];
        }
    
}

- (void)setSelectCurrentIndex:(NSInteger)selectCurrentIndex {
    if (_selectCurrentIndex != selectCurrentIndex) {
        _selectCurrentIndex = selectCurrentIndex;
        
    }
}

- (void)setDataScrollView:(UIScrollView *)dataScrollView {
    
    if (_dataScrollView != dataScrollView) {
        // 移除之前的监听器
        if (_dataScrollView) {
            [_dataScrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
        }
        
        _dataScrollView = dataScrollView;
        // 监听contentOffset
        [_dataScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        NSInteger page = (_dataScrollView.contentOffset.x + CGRectGetWidth(self.bounds)/2.0)/CGRectGetWidth(self.bounds);
        
        //手动拖拽
        if (self.dataScrollView.isDragging && page != self.selectCurrentIndex) {
            _isDragged = YES;
            UIButton *currentButton =  (UIButton*)[self.menuItems objectAtIndex:page];
            UIButton *oldButton = (UIButton*)[self.menuItems objectAtIndex:self.selectCurrentIndex];
            currentButton.selected = YES;
            oldButton.selected = NO;
            self.selectCurrentIndex = page;
            if (self.showBottomLine) {
                [self changeBottomLineViewFrameAnimations:YES];
                if (_menuScrollDelegate && [_menuScrollDelegate respondsToSelector:@selector(menuScrollView:didSelectedMenuItemAtIndex:)]) {
                     [_menuScrollDelegate menuScrollView:self didSelectedMenuItemAtIndex:self.selectCurrentIndex];
                }
            }
            return;
        }
    }
}
@end
