//
//  GE_Mine_XSZD_WenTiVC.m
//  SSKJ
//
//  Created by 张超 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_XSZD_WenTiVC.h"

@interface GE_Mine_XSZD_WenTiVC ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) MBProgressHUD *hud;

@end

@implementation GE_Mine_XSZD_WenTiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kMainBackgroundColor;
    
    CGFloat width = ScreenWidth;
    CGFloat height = ScreenHeight - Height_NavBar - 50;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _webView.backgroundColor = [UIColor clearColor];
    _webView.delegate = self;
    
    //    [self.webView loadHTMLString:json[@"data"][@"details"] baseURL:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [self.webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //字体大小
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"];
    //字体颜色
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#999999'"];//white gray
    //页面背景色
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#141724'"];
    
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@0);
        make.width.mas_equalTo(ScreenWidth);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

@end
