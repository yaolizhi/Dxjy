//
//  SSKJ_BaseViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/6.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
#import "SSKJ_TitleView.h"
#import "UIImage+RoundedRectImage.h"


@interface SSKJ_BaseViewController ()
@property (nonatomic, strong) SSKJ_TitleView *titleView;

@end

@implementation SSKJ_BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = self.titleView;
    
    self.view.backgroundColor = kMainBackgroundColor;
    
    [self.titleView setTintColor:kNavigationTitleColor];
    
    [self setTitleFont:[UIFont boldSystemFontOfSize:ScaleW(18)]];
    
    if (self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"public_back"]style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction:)];
        item.tintColor = kMainWihteColor;
        self.navigationItem.leftBarButtonItem = item;
        
    }
    
    
    
    
    //    else if(self.isPush == YES){
    //        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fanhui-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnAction:)];
    //
    //        self.navigationItem.leftBarButtonItem = item;
    //    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 去除navigationbar下面的线
    //    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}


-(SSKJ_TitleView *)titleView
{
    if (nil == _titleView) {
        
        _titleView = [[SSKJ_TitleView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - ScaleW(250), 40)];
        
    }
    return _titleView;
}

#pragma mark - 基本功能
/*
 * 修改导航栏字体颜色
 */
-(void)setTitleColor:(UIColor *)titleColor
{
    [self.titleView changeTitleColor:titleColor];
}

/*
 * 修改导航栏字体
 */
-(void)setTitleFont:(UIFont *)font
{
    [self.titleView changeTitleFont:font];
}

/*
 * 修改导航栏背景色
 */
-(void)setNavgationBackgroundColor:(UIColor *)navigationBackgroundColor alpha:(CGFloat)alpha
{
    self.navigationController.navigationBar.translucent = YES;
    UIImageView *barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = alpha;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:navigationBackgroundColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init] ];
    
    self.navigationController.navigationBar.barTintColor = navigationBackgroundColor;
}



/*
 * 修改导航栏左侧按钮
 */
- (void)addLeftNavItemWithImage:(UIImage*)image
{
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction:)];
    self.navigationItem.leftBarButtonItem = item;
}
/*
 * 修改导航栏左侧按钮
 */
- (void)addLeftNavItemWithTitle:(NSString*)title color:(UIColor *)color
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction:)];
    item.tintColor = color;
    self.navigationItem.leftBarButtonItem = item;
    
}
/*
 * 返回按钮点击事件
 */
- (void)leftBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 * 添加导航栏右侧按钮
 */
- (void)addRightNavItemWithTitle:(NSString*)title color:(UIColor *)color font:(UIFont *)font
{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rigthBtnAction:)];
    //    item.tintColor = color;
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,
                                  color, NSForegroundColorAttributeName,
                                  nil]
                        forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = item;
    
}

/*
 * 添加导航栏右侧按钮
 */
- (void)addRightNavgationItemWithImage:(UIImage*)image
{
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(rigthBtnAction:)];
    self.navigationItem.rightBarButtonItem = item;
}

/*
 * 导航栏右侧按钮点击事件
 */
- (void)rigthBtnAction:(id)sender
{
    
}

//-(void)changeTitle:(NSString *)title
//{
//
//    self.title = title;
//    [self.titleView changeTitle:title];
//
//
//}



-(void)setTitle:(NSString *)title
{
    CGSize sizeToFit = [title sizeWithFont:[UIFont systemFontOfSize:ScaleW(18)] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 40) lineBreakMode:NSLineBreakByWordWrapping];
    self.titleView.frame=CGRectMake(0, 0, sizeToFit.width+40, 40);
    [self.titleView changeTitle:title];
    
}

-(void)setNavigationBarHidden:(BOOL)isHidden
{
    
    [self.navigationController setNavigationBarHidden:isHidden];
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
