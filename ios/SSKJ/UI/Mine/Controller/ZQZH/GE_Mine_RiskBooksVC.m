//
//  GE_Mine_RiskBooksVC.m
//  SSKJ
//
//  Created by 张超 on 2019/3/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_RiskBooksVC.h"
#import "GE_Mine_realNameVC.h"

#import "Mine_RealName_ViewController.h"
@interface GE_Mine_RiskBooksVC ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *yueduBtn;
@property (weak, nonatomic) IBOutlet UIButton *confimBtn;

@end

@implementation GE_Mine_RiskBooksVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"风险书";
    
    _yueduBtn.titleLabel.font = [UIFont systemFontOfSize:ScaleW(13)];
    [_yueduBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [_yueduBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    _confimBtn.titleLabel.font = [UIFont systemFontOfSize:ScaleW(16)];
    
    [self requestWithFengXianShu];
    
    //风险率网页
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/app/interface?app=app&action=agreeRisk",ProductBaseServer]]]];
    
}

//阅读按钮
- (IBAction)yueDuBtnClick:(UIButton *)sender {
    
    self.yueduBtn.selected = !self.yueduBtn.selected;
    
}


//确定
- (IBAction)confirmBtnClick:(UIButton *)sender {
    
    if (_yueduBtn.selected == 1) {
//        GE_Mine_realNameVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GE_Mine_realNameVC"];
//        [self.navigationController pushViewController:vc animated:YES];

        Mine_RealName_ViewController *vc = [[Mine_RealName_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [MBProgressHUD showError:@"请阅读条款，同意并点击勾选"];
    }
}

//网络请求
- (void)requestWithFengXianShu
{
    NSDictionary *params = @{@"type":@"risk_agree"};
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_FengXianShu_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netWorkmodel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netWorkmodel.status.integerValue == 200) {
            
            [self.webView loadHTMLString:netWorkmodel.data baseURL:nil];
        }
        else
        {
            [MBProgressHUD showError:netWorkmodel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
    }];
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //改变背景颜色
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.backgroundColor = '#ffffff'"];
    //改变字体颜色
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#ffffff'"];
    
    NSString *js = @"function imgAutoFit() { var imgs = document.getElementsByTagName('img');for (var i = 0; i < imgs.length; i++) {var img = imgs[i];img.style.width = %f;}}";
    
    js = [NSString stringWithFormat:js, ScreenWidth - 20];
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.webView.height = self.webView.scrollView.contentSize.height;
//
//        self.warningLabel1.top = self.webView.bottom + ScaleW(16);
//
//        self.warningLabel2.top = self.warningLabel1.bottom + ScaleW(20);
//
//        if (self.warningLabel2.bottom >= kScreenHeight)
//        {
//            self.scrollView.contentSize = CGSizeMake(kScreenWidth, self.warningLabel2.bottom + 20);
//        }
//
//
//    });
}

@end
