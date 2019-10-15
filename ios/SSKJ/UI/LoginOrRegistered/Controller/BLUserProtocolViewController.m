//
//  BLUserProtocolViewController.m
//  ZYW_MIT
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BLUserProtocolViewController.h"

@interface BLUserProtocolViewController () <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation BLUserProtocolViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self setupUI];
    
    [self requestProtocolContent];
    
    self.title = SSKJLocalized(@"注册协议", nil);
    

}

- (void)setupUI {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    webView.delegate = self;
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.backgroundColor = '#1c1f22'"];
    
    webView.backgroundColor=kMainWihteColor;
    
    [self.view addSubview:webView];
    _webView = webView;
}

- (void)requestProtocolContent {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"type"] = @"reg_agree";
    
    if ([[[SSKJLocalized sharedInstance] currentLanguage] isEqualToString:@"en"]) {
        params[@"type"] = @"reg_agree1";
    }
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_FengXianShu_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *netmodel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netmodel.status.integerValue == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.webView loadHTMLString:netmodel.data baseURL:nil];
            });
        } else {
            [MBProgressHUD showError:netmodel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [weakSelf.hud hideAnimated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网错出错", nil)];
    }];
    

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //改变背景颜色
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.backgroundColor = '#ffffff'"];
    //改变字体颜色
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#000000'"];
    
    NSString *js = @"function imgAutoFit() { var imgs = document.getElementsByTagName('img');for (var i = 0; i < imgs.length; i++) {var img = imgs[i];img.style.width = %f;}}";
    
    js = [NSString stringWithFormat:js, ScreenWidth - ScaleW(20)];
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
