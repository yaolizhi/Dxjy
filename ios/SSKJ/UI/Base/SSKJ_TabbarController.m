//
//  SSKJ_TabbarController.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/6.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import "SSKJ_TabbarController.h"

#import "UIImage+RoundedRectImage.h"

#import "SSKJ_BaseNavigationController.h"

#import "GE_Market_ViewController.h"

#import "GE_Trading_ViewController.h"

#import "ZiXuan_ViewController.h"

#import "GE_Mine_ViewController.h"

#import "RZ_Mine_ViewController.h"

#define kControllerNameArray @[@"GE_Market_ViewController",@"ZiXuan_ViewController",@"GE_Trading_ViewController",@"RZ_Mine_ViewController"]

#define kControllerTitleArray @[@"行情",@"自选",@"交易",@"我的"]
#define kImageNameArray @[@"GE_Market",@"GE_Zixun",@"GE_Trading",@"GE_Mine"]
#define kSelectedImageNameArray @[@"GE_Market_hover",@"GE_Zixun_hover",@"GE_Trading_Hover",@"GE_Mine_hover"]

@interface SSKJ_TabbarController ()
@end

@implementation SSKJ_TabbarController
/**
 *  当第一次使用这个类或者子类的时候调用，作用：初始化
 */
#pragma mark - 改变 tabbar 选中状态下的文字颜色
+ (void)initialize
{
    //获取当前这个类下面的所有 tabBarItem
    //    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    //
    //    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    //    //改变选中 tabbar 字体的颜色
    //    [mutDic setObject:kMainTextColor forKey:NSForegroundColorAttributeName];
    //    [item setTitleTextAttributes:mutDic forState:UIControlStateSelected];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x666666), NSForegroundColorAttributeName, systemFont(11), NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName, systemFont(11), NSFontAttributeName,nil] forState:UIControlStateSelected];
    
    UITabBar *tabBar = [UITabBar appearance];
    
    [tabBar setBarTintColor:[UIColor whiteColor]];
    
    tabBar.translucent = NO;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加所有子控制器
    [self addAllChildViewController];
}

#pragma mark - 加载所有的子控制器
- (void)addAllChildViewController
{
    for (int i = 0; i < kControllerNameArray.count; i++)
    {
        NSString *controllerStr = kControllerNameArray[i];
        NSString *title = kControllerTitleArray[i];
        NSString *image = kImageNameArray[i];
        NSString *selectedImage = kSelectedImageNameArray[i];
        id controller = [[NSClassFromString(controllerStr) alloc] init] ;
        [self addChildVC:controller title:title image:image selectedImage:selectedImage];
    }
    
}

/**
 *  添加子控制器
 *
 *  @param childVC      子控制器
 *  @param title        标题
 *  @param image        正常状态图片
 *  @param seletedImage 选中时的图片
 */
- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)seletedImage
{
    if ([childVC isKindOfClass:[RZ_Mine_ViewController class]]) {
        //我的界面单独处理 storyboard
        RZ_Mine_ViewController * vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RZ_Mine_ViewController"];
        vc.title = title;
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageWithOriginalName:seletedImage];
        SSKJ_BaseNavigationController *naviVC = [[SSKJ_BaseNavigationController alloc] initWithRootViewController:vc];
        
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x666666), NSForegroundColorAttributeName, systemFont(11), NSFontAttributeName,nil] forState:UIControlStateNormal];
        
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kMainColor, NSForegroundColorAttributeName, systemFont(11), NSFontAttributeName,nil] forState:UIControlStateSelected];
        
        
        [self addChildViewController:naviVC];
    }else{
        SSKJ_BaseNavigationController *naviVC = [[SSKJ_BaseNavigationController alloc] initWithRootViewController:childVC];
        
        childVC.tabBarItem.image = [UIImage imageNamed:image];
        
        childVC.tabBarItem.selectedImage = [UIImage imageWithOriginalName:seletedImage];
        
        naviVC.tabBarItem.title = title;
        
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x666666), NSForegroundColorAttributeName, systemFont(11), NSFontAttributeName,nil] forState:UIControlStateNormal];
        
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kMainColor, NSForegroundColorAttributeName, systemFont(11), NSFontAttributeName,nil] forState:UIControlStateSelected];
        
        [self addChildViewController:naviVC];
    }
    
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
