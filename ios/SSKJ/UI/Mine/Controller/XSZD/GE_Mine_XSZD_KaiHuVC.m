//
//  GE_Mine_XSZD_KaiHuVC.m
//  SSKJ
//
//  Created by 张超 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_XSZD_KaiHuVC.h"

@interface GE_Mine_XSZD_KaiHuVC ()

@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation GE_Mine_XSZD_KaiHuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kMainBackgroundColor;
    
    [self bgImageView];
    
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height_NavBar-50) imageName:@"GE_My_yindao"];
        _bgImageView.contentMode = UIViewContentModeCenter;
        [self.view addSubview:_bgImageView];
    }
    
    return _bgImageView;
}

@end
