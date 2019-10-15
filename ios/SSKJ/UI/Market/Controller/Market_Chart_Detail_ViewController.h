//
//  Market_Chart_Detail_ViewController.h
//  ZYW_MIT
//
//  Created by James on 2018/7/26.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Market_Main_List_Model.h"

@interface Market_Chart_Detail_ViewController : UIViewController

@property(nonatomic,strong)Market_Main_List_Model *model;

@property(nonatomic,assign)BOOL isHidden;

@end
