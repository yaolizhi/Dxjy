//
//  GE_Market_NoticeDetail_VC.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/26.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Market_NoticeDetail_VC.h"

#import "GE_Market_Notice_Model.h"


@interface GE_Market_NoticeDetail_VC ()<UIWebViewDelegate>

/**contentView*/
@property (nonatomic , strong) UIScrollView *contentView;
/**头信息*/
@property (nonatomic , strong) UIView *headerView;
/**标题视图*/
@property (nonatomic , strong) UILabel *titleLabel;
/**来源视图*/
@property (nonatomic , strong)  UILabel *srcLabel;
/**发布时间视图*/
@property (nonatomic , strong) UILabel *publicTimeLabel;
/**内容视图*/
@property (nonatomic , strong) UIWebView *webView;

@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, strong) GE_Market_Notice_Model *gongGaoDetailModel;

@end

@implementation GE_Market_NoticeDetail_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  = @"公告详情";
    
    self.view.backgroundColor = kMainBackgroundColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self setupUI];
    
    [self requestGongGaoDetail];
}

/**
 初始化视图
 */
- (void)setupUI {
    CGFloat margin = 10;
    
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, margin, ScreenWidth, ScreenHeight - Height_NavBar - margin)];
    
    contentView.backgroundColor = LineGrayColor;
    
    //contentView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    [self.view addSubview:contentView];
    
    _contentView = contentView;
    

    // header view
    UIView *headerView = [[UIView alloc] init];
    
    headerView.frame = CGRectMake(0,0, ScreenWidth, ScaleW(80));
    
//    [contentView addSubview:headerView];
    
    _headerView = headerView;
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    
    titleLabel.frame = CGRectMake(margin, margin, ScreenWidth - margin * 2, ScaleH(30));
    
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    titleLabel.numberOfLines = 0;
    
    titleLabel.textColor = UIColorFromRGB(0x333333);
    
    [headerView addSubview:titleLabel];
    
    _titleLabel = titleLabel;
    
    
    
    UILabel *srcLabel = [[UILabel alloc] init];
    
    srcLabel.frame = CGRectMake(margin, CGRectGetMaxY(titleLabel.frame) + margin, 150, ScaleH(20));
    
    srcLabel.textColor = UIColorFromRGB(0x333333);
    
    srcLabel.font = [UIFont systemFontOfSize:12];
    
    [headerView addSubview:srcLabel];
    
    _srcLabel = srcLabel;
    
    
    UILabel *publicTimeLabel = [[UILabel alloc] init];
    
    publicTimeLabel.frame = CGRectMake(margin, CGRectGetMaxY(srcLabel.frame) + margin, 200, ScaleH(20));
    
    publicTimeLabel.textColor = UIColorFromRGB(0x333333);
    
    publicTimeLabel.font = [UIFont systemFontOfSize:12];
    
    [headerView addSubview:publicTimeLabel];
    
    _publicTimeLabel = publicTimeLabel;
    
    
    // 正文
    UIWebView *webView = [[UIWebView alloc] init];
    
    webView.frame = CGRectMake(0, 0, ScreenWidth,contentView.height -  margin);
    
    webView.delegate = self;
    
    webView.scrollView.scrollEnabled = YES;
    
    [contentView addSubview:webView];
    
    _webView = webView;
    
    [_webView stringByEvaluatingJavaScriptFromString:@"document.body.style.backgroundColor = '#F5F5F5'"];
    
    [_webView setOpaque:FALSE];
    
    if (@available(iOS 11.0, *)) {
        
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
        
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
}

- (void)requestGongGaoDetail {
    
    NSDictionary *params = @{
                           
                             @"id":@([self.ID integerValue])
                             };
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:GE_NoticeDetail_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            self.gongGaoDetailModel = [GE_Market_Notice_Model mj_objectWithKeyValues:network_Model.data];
            
            [self reloadUI];
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
//        [self.hud hideAnimated:YES];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];

}

- (void)reloadUI {
    CGFloat margin = 5;
    // 根据内容 计算实时高度
    NSString *title = _gongGaoDetailModel.title;
    
    _titleLabel.text = title;
    
    [_titleLabel sizeToFit];
    
    //    _titleLabel.y = 64;
//    _srcLabel.hidden = YES;
    
//    _publicTimeLabel.y = CGRectGetMaxY(_titleLabel.frame) + margin;
//
//    _publicTimeLabel.text = _gongGaoDetailModel.time;
//    [NSString stringWithFormat:@"%@",[WLTools convertTimestamp:_gongGaoDetailModel.createTime.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"]];
    
//    _headerView.height = CGRectGetMaxY(_publicTimeLabel.frame) + margin;
    
    _webView.y = 0;
    
    [_webView loadHTMLString:_gongGaoDetailModel.content baseURL:[NSURL URLWithString:ProductBaseServer]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
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
    
    
    //改变背景颜色
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.backgroundColor = '#F5F5F5'"];
    //改变字体颜色
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#070A10'"];
    
    NSString *js = @"function imgAutoFit() { var imgs = document.getElementsByTagName('img');for (var i = 0; i < imgs.length; i++) {var img = imgs[i];img.style.width = %f;}}";
    
    js = [NSString stringWithFormat:js, ScreenWidth - 20];
    
    [webView stringByEvaluatingJavaScriptFromString:js];
    
    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        self.webView.height = self.webView.scrollView.contentSize.height - self.headerView.height;
        
        if (self.webView.bottom >= ScreenHeight) {
            
            self.contentView.contentSize = CGSizeMake(ScreenWidth, self.webView.bottom);
        }
       
        [self.hud hideAnimated:YES];
    });
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
