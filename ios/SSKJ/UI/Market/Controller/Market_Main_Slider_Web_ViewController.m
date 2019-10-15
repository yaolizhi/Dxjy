//
//  Market_Main_Slider_Web_ViewController.m
//  ZYW_MIT
//
//  Created by James on 2018/8/8.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Market_Main_Slider_Web_ViewController.h"

#import<WebKit/WebKit.h>


@interface Market_Main_Slider_Web_ViewController ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic,strong)WKWebView *webView;

@property(nonatomic,strong)NSString *tempUrl;

@property(nonatomic,strong)UIView *navView;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation Market_Main_Slider_Web_ViewController

#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //使用方法，在开启webview的时候开启监听，，销毁weibview的时候取消监听，否则监听还在继续。将会监听所有的网络请求
    //[JWCacheURLProtocol startListeningNetWorking];
    
    self.tempUrl=@"";
    
    [self webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    
    [self navView];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}



#pragma mark - 返回 事件
-(void)NavigationLeftEvent
{
    if ([self.webView canGoBack])
    {
        if ([self.tempUrl containsString:@"WT.mc_id"])
        {
            [self.webView goToBackForwardListItem:[self.webView.backForwardList.backList firstObject]];
        }
        else
        {
            [self.webView goBack];
        }
    }
    else
    {
        [self.view resignFirstResponder];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(WKWebView *)webView
{
    if (_webView==nil)
    {
        _webView=[[WKWebView alloc] init];
        
        _webView.UIDelegate=self;
        
        _webView.navigationDelegate=self;
        
        [_webView setOpaque:FALSE];
        
        _webView.backgroundColor=kMainBackgroundColor;
        
        if (@available(iOS 11.0, *))
        {
            
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            
            _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
            _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
            
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets=NO;
        }
        
        [self.view addSubview:_webView];
        
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@0);
            
            make.top.equalTo(@(0));
            
            make.width.equalTo(@(ScreenWidth));
            
            make.height.equalTo(@(ScreenHeight-Height_NavBar-kBottomSpace));
        }];
    }
    
    return _webView;
}


#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [self.hud showAnimated:YES];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self.hud hideAnimated:YES];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    [self.hud hideAnimated:YES];
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
//    SsLog(@"接收到服务器跳转请求之后调用");
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    
    
//    SsLog(@"在收到响应后，决定是否跳转: %@",navigationResponse.response.URL.absoluteString);
    
    self.tempUrl=navigationResponse.response.URL.absoluteString;
    
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    
//    SsLog(@"在发送请求之前，决定是否跳转: %@",navigationAction.request.URL.absoluteString);
    
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}
#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    return [[WKWebView alloc]init];
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler
{
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    completionHandler(YES);
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
//    SsLog(@"警告：%@",message);
    //completionHandler();
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}



#pragma mark -  内存警告
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    //[JWCacheURLProtocol cancelListeningNetWorking];//在不需要用到webview的时候即使的取消监听
}

@end
