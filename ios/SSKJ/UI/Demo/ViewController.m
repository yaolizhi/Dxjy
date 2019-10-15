//
//  ViewController.m
//  Test
//
//  Created by 刘小雨 on 2018/12/6.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import "ViewController.h"

#import "FirstViewController.h"

#import "LeftViewController.h"

#import "UIViewController+CWLateralSlide.h"


@interface ViewController ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) LeftViewController *leftVc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = SSKJLocalized(@"我的", nil);
    [self setTitleColor:[UIColor purpleColor]];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
//    
}

-(LeftViewController *)leftVc
{
    if (nil == _leftVc) {
        _leftVc = [[LeftViewController alloc]init];
    }
    return _leftVc;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title = SSKJLocalized(@"我的我的", nil);
    [self setTitleFont:WLFontSize(30)];
    
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)setUI
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 200, 100, 20)];
    label.text = SSKJLocalized(@"你好",nil);
    [self.view addSubview:label];
    _label = label;
    self.btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 250, 100, 50)];
    [self.btn setTitle:SSKJLocalized(@"切换",nil) forState:UIControlStateNormal];
    self.btn.backgroundColor = [UIColor redColor];
    [self.btn addTarget:self action:@selector(xxx) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    
    
    
//    [self addLeftNavItemWithTitle:SSKJLocalized(@"侧边栏",nil)];
//    
//    [self setNavgationBackgroundColor:[UIColor redColor]];
//    
}


-(void)leftBtnAction:(id)sender
{
    
    FirstViewController *vc = [[FirstViewController alloc]init];
    CWLateralSlideConfiguration *config = [[CWLateralSlideConfiguration alloc]initWithDistance:ScreenWidth * 0.8 maskAlpha:0.3 scaleY:1 direction:CWDrawerTransitionFromLeft backImage:nil];
    [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeDefault configuration:config];

}

-(void)xxx
{
    [[SSKJLocalized sharedInstance]setLanguage:@"zh-Hans"];
    self.title = SSKJLocalized(@"我的", nil);
    FirstViewController *vc = [[FirstViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
