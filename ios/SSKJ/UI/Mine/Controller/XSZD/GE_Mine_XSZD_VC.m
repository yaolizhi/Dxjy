//
//  GE_Mine_XSZD_VC.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_XSZD_VC.h"
#import "GE_Mine_XSZD_KaiHuVC.h"
#import "GE_Mine_XSZD_WenTiVC.h"

@interface GE_Mine_XSZD_VC ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic, strong) NinaPagerView *ninaPagerView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation GE_Mine_XSZD_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = SSKJLocalized(@"新手指导", nil);
    
    self.view.backgroundColor = kMainBackgroundColor;
    
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
    _webView.backgroundColor = kMainBackgroundColor;
    //风险率网页
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@app=app&action=newShow",ProductBaseURL]]]];
    _webView.delegate = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
//    [self httpRequest];
    
//    [self ninaPagerView];
//    [self lineView];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //字体大小
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"];
    //字体颜色
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#999999'"];//white gray
    //页面背景色
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#F5F5F5'"];
    
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
//        make.left.equalTo(@0);
        make.width.mas_equalTo(ScreenWidth);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

//网络请求
- (void)httpRequest
{
    NSDictionary *params = @{@"account":[SSKJ_User_Tool sharedUserTool].getAccount,
                             @"app":@"app",
                             @"action":@"newShow",
                             @"sessionId":[SSKJ_User_Tool sharedUserTool].getToken,
                             @"systemType":@"IOS"
                             };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:[NSString stringWithFormat:@"%@",ProductBaseURL] RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
    }];
    
}

- (NinaPagerView *) ninaPagerView
{
    
    if (!_ninaPagerView)
    {
        //开户流程
        GE_Mine_XSZD_KaiHuVC *kaiHuVC = [[GE_Mine_XSZD_KaiHuVC alloc]init];
        
        //常见问题
        GE_Mine_XSZD_WenTiVC *wenTiVC = [[GE_Mine_XSZD_WenTiVC alloc]init];
        
        NSArray *controllers=@[kaiHuVC,
                               wenTiVC
                               ];
        
        NSArray *titleArray =@[@"开户流程",
                               @"常见问题"
                               ];
        _ninaPagerView = [[NinaPagerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar) WithTitles:titleArray WithObjects:controllers];
        
        _ninaPagerView.topTabBackGroundColor = kMainBackgroundColor;
        
        _ninaPagerView.topTabHeight = 50;
        
        _ninaPagerView.titleFont = 15;
        
        _ninaPagerView.sliderBlockColor = UIColorFromRGB(0xbbbbbb);
        
        _ninaPagerView.underlineColor = kMainColor;
        
        _ninaPagerView.selectTitleColor = kMainColor;
        
        _ninaPagerView.nina_autoBottomLineEnable = YES;
        
        _ninaPagerView.nina_scrollEnabled = NO;
        
        [self.view addSubview:_ninaPagerView];
        
    }
    return _ninaPagerView;
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [FactoryUI createViewWithFrame:CGRectMake(ScreenWidth/2-ScaleH(10)/2, (self.ninaPagerView.topTabHeight-ScaleH(10))/2, 1, ScaleH(15)) Color:kMainDarkBlackColor];
        [self.view addSubview:_lineView];
    }
    return _lineView;
}


@end
