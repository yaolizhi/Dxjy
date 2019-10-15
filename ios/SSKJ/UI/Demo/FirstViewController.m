//
//  FirstViewController.m
//  Test
//
//  Created by 刘小雨 on 2018/12/6.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"第一";
    self.hidesBottomBarWhenPushed = NO;
    self.view.backgroundColor = [UIColor greenColor];
    
    [self setTitleFont:systemFont(30)];

    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
