//
//  Mine_RealName_ViewController.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/5/17.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Mine_RealName_ViewController.h"

#import "Mine_RealName_Info_View.h"

#import "Mine_RealName_Card_View.h"

#import "Mine_RealName_Bank_View.h"

#import "GE_Mine_waitAuditVC.h"

#import <AFNetworking.h>

@interface Mine_RealName_ViewController ()

@property (nonatomic,strong) UIScrollView * scrollView;

@property (nonatomic,strong) Mine_RealName_Info_View * infoView;

@property (nonatomic,strong) Mine_RealName_Card_View * cardView;

@property (nonatomic,strong) Mine_RealName_Bank_View * bankView;

@property (nonatomic,strong) UIButton * sureBtn;

@end

@implementation Mine_RealName_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = SSKJLocalized(@"实名开户", nil);
    
    [self scrollView];
    
    [self infoView];
    
    [self cardView];
    
    [self bankView];
    
    [self sureBtn];
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.sureBtn.bottom + 40);
}

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height_NavBar)];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (Mine_RealName_Info_View *)infoView{
    if (_infoView == nil) {
        _infoView = [[Mine_RealName_Info_View alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(250))];
        [self.scrollView addSubview:_infoView];
    }
    return _infoView;
}

- (Mine_RealName_Card_View *)cardView{
    if (_cardView == nil) {
        UIImage *image = [UIImage imageNamed:@"GE_My_addBtn1"];
        CGFloat cardHeight = ScaleW(150) + ScaleW(image.size.height) * 2;
        _cardView = [[Mine_RealName_Card_View alloc]initWithFrame:CGRectMake(0, self.infoView.bottom, ScreenWidth, cardHeight)];
        _cardView.vc = self;
        [self.scrollView addSubview:_cardView];
    }
    return _cardView;
}

- (Mine_RealName_Bank_View *)bankView{
    if (_bankView == nil) {
        UIImage *image = [UIImage imageNamed:@"GE_My_addBtn1"];
        CGFloat cardHeight = ScaleW(100) + ScaleW(image.size.height);
        _bankView = [[Mine_RealName_Bank_View alloc]initWithFrame:CGRectMake(0, self.cardView.bottom, ScreenWidth, cardHeight)];
        _bankView.vc = self;
        [self.scrollView addSubview:_bankView];
    }
    return _bankView;
}

- (UIButton *)sureBtn{
    if (_sureBtn == nil) {
        _sureBtn = [FactoryUI createButtonWithFrame:CGRectMake(ScaleW(15), self.bankView.bottom + ScaleW(20), ScreenWidth - ScaleW(30), ScaleW(45)) title:SSKJLocalized(@"提交", nil) titleColor:kMainWihteColor imageName:nil backgroundImageName:nil target:self selector:@selector(sureBtnAction) font:systemFont(ScaleW(15))];
        _sureBtn.backgroundColor = kMainColor;
        _sureBtn.layer.cornerRadius = ScaleW(5);
        [self.scrollView addSubview:_sureBtn];
    }
    return _sureBtn;
}

- (void)sureBtnAction{
    
    if (self.self.infoView.nameTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入姓名"];
        return;
    }
    
    if (self.self.infoView.cardNameTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入银行卡类型，例如中国银行"];
        return;
    }
    
    if (self.self.infoView.cardAddressTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入开户行地址"];
        return;
    }
    
    if (self.self.infoView.cardNumTextField.text.length < 14) {
        [MBProgressHUD showError:@"请输入您要出入金的银行卡号"];
        return;
    }
    
    if (!self.cardView.zhengImage) {
        [MBProgressHUD showError:@"请选择身份证正面照片"];
        return;
    }
    
    if (!self.cardView.fanImage){
        [MBProgressHUD showError:@"请选择身份证反面照片"];
        return;
    }
    
    if (!self.bankView.bankCardImage) {
        [MBProgressHUD showError:@"请选择银行卡照片"];
        return;
    }
    
    [self upLoadImgImge];
    
}

//上传图片
-(void)upLoadImgImge
{
    //    WS(weakSelf);
    
    NSDictionary *params = @{
                             @"cardType":self.self.infoView.cardNameTextField.text,
                             @"cardAccount":self.infoView.cardNumTextField.text,
                             @"cardAddress":self.infoView.cardAddressTextField.text,
                             
                                @"realname":self.infoView.nameTextField.text
                             };
    
    NSArray *photosArr = @[self.cardView.zhengImage,self.cardView.fanImage,self.bankView.bankCardImage];
    
    // 基于AFN3.0+ 封装的HTPPSession句柄
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //[manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"systemType"];
    manager.requestSerializer.timeoutInterval = 20;
    
    NSString *Token=[[SSKJ_User_Tool sharedUserTool] getToken];
    if ([Token isEqual:[NSNull null]] || Token == nil) {
        Token = @"";
    }
    
    //    //获取用户的UID
    NSString *Account=[[SSKJ_User_Tool sharedUserTool] getAccount];
    if ([Account isEqual:[NSNull null]] || Account == nil) {
        Account = @"";
    }
    
    //模拟头部参数数据
    //获取当前处理后的时间戳
    [manager.requestSerializer setValue:Token forHTTPHeaderField:@"token"];
    
    [manager.requestSerializer setValue:Account forHTTPHeaderField:@"account"];
    
    [manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"systemType"];
    
    [manager.requestSerializer setValue:AppVersion forHTTPHeaderField:@"version"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    // 在parameters里存放照片以外的对象
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WS(weakSelf);
    
    [manager POST:GE_set_renzheng_URL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //         formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        //         这里的photoArr是你存放图片的数组
        
        for (int i = 0; i < photosArr.count; i++)
        {
            
            UIImage *image = photosArr[i];
            
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            
            NSString *fileName = [NSString  stringWithFormat:@"%@_%d.jpg", dateString,i];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            
            //            if (i==0) //手持身份证号
            //            {
            //                [formData appendPartWithFileData:imageData name:@"selfPortraitUrl" fileName:fileName mimeType:@"image/jpeg"];
            //            }
            
            if(i==0) //身份证正面
            {
                fileName = @"cardimg1.jpg";
                [formData appendPartWithFileData:imageData name:@"cardimg1" fileName:fileName mimeType:@"image/jpeg"];
            }
            else if(i==1) //身份证反面
            {
                fileName = @"cardimg2.jpg";
                [formData appendPartWithFileData:imageData name:@"cardimg2" fileName:fileName mimeType:@"image/jpeg"];
            }else if(i==2) //银行卡正面
            {
                fileName = @"cardimg3.jpg";
                [formData appendPartWithFileData:imageData name:@"cardimg3" fileName:fileName mimeType:@"image/jpeg"];
            }
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //             //LSLog(Localized(@"---上传进度--- %@", nil),uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //LSLog(Localized(@"```上传成功``` %@", nil),responseObject);
        WL_Network_Model *netwok_model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [hud hideAnimated:YES];
        
        if (netwok_model.status.integerValue == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            });
        } else {
            [MBProgressHUD showError:netwok_model.msg];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"上传失败", nil)];
    }];
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
