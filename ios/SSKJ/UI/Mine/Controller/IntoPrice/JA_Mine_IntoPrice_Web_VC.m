//
//  JA_Mine_IntoPrice_Web_VC.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/5/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "JA_Mine_IntoPrice_Web_VC.h"

#import <WebKit/WebKit.h>

@interface JA_Mine_IntoPrice_Web_VC ()<UIWebViewDelegate,NSURLSessionDelegate,UIGestureRecognizerDelegate,WKUIDelegate,WKNavigationDelegate,UIWebViewDelegate>

//@property(nonatomic,strong)WKWebView *webView;
@property (nonatomic,strong) UIWebView *webView;

@end

@implementation JA_Mine_IntoPrice_Web_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = SSKJLocalized(@"入金", nil);
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.webView.backgroundColor=kMainBackgroundColor;
    [self.webView setScalesPageToFit:YES];
    self.webView.delegate = self;
    [self.webView loadHTMLString:self.urlStr baseURL:[NSURL URLWithString:ProductBaseServer]];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
//    [self webView];
    
//    [self htmlStringWithString:self.urlStr];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *js1=@"var script = document.createElement('script');"
    "script.type = 'text/javascript';"
    "script.text = \"function ResizeImages() { "
    "var myimg,oldwidth;"
    "var maxwidth = %f;"
    "for(i=0;i <document.images.length;i++){"
    "myimg = document.images[i];"
    "if(myimg.width > maxwidth){"
    "oldwidth = myimg.width;"
    "myimg.width = %f;"
    "}"
    "}"
    "}\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    js1=[NSString stringWithFormat:js1,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width-15];
    [webView stringByEvaluatingJavaScriptFromString:js1];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    //    //字体大小
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"];
    //    //字体颜色
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#999999'"];//white gray
    //    //页面背景色
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#141724'"];
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(ScaleH(15)));
        make.left.equalTo(@(ScaleW(15)));
        make.right.equalTo(@(ScaleW(-15)));
        make.bottom.equalTo(@(ScaleH(-15)));
    }];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

//-(WKWebView *)webView
//{
//    if (nil == _webView) {
//
//        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//        [wkUController addUserScript:wkUScript];
//        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//        wkWebConfig.userContentController = wkUController;
//
//
//        _webView = [[WKWebView alloc]initWithFrame:CGRectZero];
//        _webView.UIDelegate = self;
//        _webView.navigationDelegate = self;
////        [_webView setOpaque:FALSE];
//        _webView.backgroundColor=kMainBackgroundColor;
//        if (@available(iOS 11.0, *))
//        {
//            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//            _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//            _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
//        }else{
//            self.automaticallyAdjustsScrollViewInsets=NO;
//        }
//        [self.view addSubview:_webView];
//        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@(ScaleH(15)));
//            make.left.equalTo(@(ScaleW(15)));
//            make.right.equalTo(@(ScaleW(-15)));
//            make.bottom.equalTo(@(ScaleH(-15)));
//
//        }];
//
//    }
//    return _webView;
//}

-(void)htmlStringWithString:(NSString *)htmlString
{
//    NSString *newHtmlString = [NSString stringWithFormat:@"<html> \n"
//                               "<head> \n"
//                               "<style type=\"text/css\"> \n"
//                               "body {font-size:15px;}\n"
//                               "</style> \n"
//                               "</head> \n"
//                               "<body style=\"background:#ffffff\">"
//                               "<script type='text/javascript'>"
//                               "window.onload = function(){\n"
//                               "var $img = document.getElementsByTagName('img');\n"
//                               "for(var p in  $img){\n"
//                               "$img[p].style.width = '100%%';\n"
//                               "$img[p].style.height ='auto'\n"
//                               "}\n"
//                               "}"
//                               "</script>%@"
//                               "</body>"
//                               "</html>",htmlString];
    
    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:ProductBaseServer]];
    
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"completionHandler:nil];
    
    //修改字体颜色  #9098b8
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#000000'"completionHandler:nil];
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
//    NSString *string = [NSString stringWithFormat:@"var script = document.createElement('script');"
//                        "script.type = 'text/javascript';"
//                        "script.text = \"function ResizeImages() { "
//                        "var myimg,oldwidth;"
//                        "var maxwidth = 1000.0;" // WKWebView中显示的图片宽度
//                        "for(i=0;i <document.images.length;i++){"
//                        "myimg = document.images[i];"
//                        "oldwidth = myimg.width;"
//                        "myimg.width = maxwidth;"
//                        "}"
//                        "}\";"
//                        "document.getElementsByTagName('head')[0].appendChild(script);ResizeImages();"];
//
//    [webView evaluateJavaScript:string completionHandler:nil];
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [MBProgressHUD showError:@"加载失败"];
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
