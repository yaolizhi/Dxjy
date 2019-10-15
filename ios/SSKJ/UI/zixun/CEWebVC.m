//
//  CEWebVC.m
//  ZYW_MIT
//
//  Created by 张超 on 2018/11/15.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "CEWebVC.h"

@interface CEWebVC ()<UIWebViewDelegate>
{
    
    __weak IBOutlet UIView *_headView;
}


@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) MBProgressHUD *hud;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation CEWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = _type == 1?SSKJLocalized(@"资讯详情", nil):SSKJLocalized(@"公告详情", nil);
    self.titleLabel.text = self.titleStr;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.timeLabel.text = self.timeStr;
    
    CGFloat width = ScreenWidth;
//    CGFloat height = ScreenHeight - Height_NavBar - _headView.bounds.size.height;
    CGFloat height = ScreenHeight - Height_NavBar;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _webView.backgroundColor = [UIColor clearColor];
    _webView.delegate = self;
    

    [self httpRequest];

    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

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
        make.top.equalTo(self->_headView.mas_bottom);
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

//资讯请求
- (void)httpRequest
{
    NSDictionary *params = @{@"id":self.detailID};
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_NoticeDetail_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            if ([[responseObject objectForKey:@"news"] isKindOfClass:[NSDictionary class]]) {
                NSString *htmlBody = [[responseObject objectForKey:@"news"] objectForKey:@"body"];
                [self.webView loadHTMLString:htmlBody baseURL:[NSURL URLWithString:@"http://newsapi.eastmoney.com"]];
            }
            
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];

}

@end
