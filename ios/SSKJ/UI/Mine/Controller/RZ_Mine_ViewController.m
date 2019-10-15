//
//  RZ_Mine_ViewController.m
//  SSKJ
//
//  Created by 张超 on 2019/5/9.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "RZ_Mine_ViewController.h"
#import "GE_Mine_Setting_VC.h"
#import "GE_Login_ViewController.h"
#import "GE_Mine_waitAuditVC.h"
#import "GE_Mine_RiskBooksVC.h"
#import "GE_Mine_Account_RecodeVC.h"
#import "GE_Mine_IntoPrice_VC.h"
#import "GE_Mine_OutPrice_VC.h"
#import "GE_Mine_IntoPriceVC.h"
#import "GE_Mine_Withdrawal_VC.h"
#import "ActionSheet.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

@interface RZ_Mine_ViewController ()<ActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headBgViewHeightCons;

@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDLabel;
@property (weak, nonatomic) IBOutlet UIButton *chongzhiBtn;
@property (weak, nonatomic) IBOutlet UIButton *tixianBtn;

@property (weak, nonatomic) IBOutlet UILabel *zhengquanLabel;
@property (weak, nonatomic) IBOutlet UILabel *goRenZhengLabel;

@property (weak, nonatomic) IBOutlet UILabel *zhanghuLabel;
@property (weak, nonatomic) IBOutlet UILabel *rujinLabel;
@property (weak, nonatomic) IBOutlet UILabel *chujinLabel;
@property (weak, nonatomic) IBOutlet UILabel *shezhiLabel;
@property (weak, nonatomic) IBOutlet UILabel *kefuLabel;

@property (weak, nonatomic) IBOutlet UIButton *outLoginBtn;

@property (nonatomic,strong) SSKJ_UserInfo_Model *userModel;
@property (nonatomic,strong) NSMutableDictionary *dataSource;

@property (nonatomic,copy) NSString * qqCodeStr;

@end

@implementation RZ_Mine_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = SSKJLocalized(@"我的", nil);
    
    self.dataSource = [[NSMutableDictionary alloc] init];
//    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = kMainBackgroundColor;
    
    
    self.headBgViewHeightCons.constant = ScaleW(60);
    self.picImageView.layer.cornerRadius = self.picImageView.height/2;
    self.picImageView.layer.masksToBounds = YES;
//    self.picImageView.layer.borderColor = UIColorFromRGB(0xF18386).CGColor;
//    self.picImageView.layer.borderWidth = ScaleW(5);

    
    self.nameLabel.font = [UIFont boldSystemFontOfSize:ScaleW(16)];
    self.IDLabel.font = [UIFont boldSystemFontOfSize:ScaleW(16)];
    
    self.zhengquanLabel.font = [UIFont systemFontOfSize:ScaleW(16)];
    self.zhengquanLabel.text = SSKJLocalized(@"证券账户", nil);
    self.goRenZhengLabel.font = [UIFont systemFontOfSize:ScaleW(10)];
    
    self.zhanghuLabel.font = [UIFont systemFontOfSize:ScaleW(16)];
    self.zhanghuLabel.text = SSKJLocalized(@"账户明细", nil);
    self.rujinLabel.font = [UIFont systemFontOfSize:ScaleW(16)];
    self.rujinLabel.text = SSKJLocalized(@"入金查询", nil);
    self.chujinLabel.font = [UIFont systemFontOfSize:ScaleW(16)];
    self.chujinLabel.text = SSKJLocalized(@"出金查询", nil);
    self.shezhiLabel.font = [UIFont systemFontOfSize:ScaleW(16)];
    self.shezhiLabel.text = SSKJLocalized(@"设置", nil);
    self.kefuLabel.font = [UIFont systemFontOfSize:ScaleW(16)];
    self.kefuLabel.text = SSKJLocalized(@"联系客服", nil);
    
    self.outLoginBtn.layer.cornerRadius = 8.f;
    self.outLoginBtn.layer.masksToBounds = YES;
    [self.outLoginBtn setTitle:SSKJLocalized(@"退出账户", nil) forState:UIControlStateNormal];
    self.outLoginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:ScaleW(16)];
    
    if (@available(iOS 11.0, *))
    {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
}

- (void)refreshHeader{
    [self requestGetQQCodeUrl];
    if ([SSKJ_User_Tool sharedUserTool].getLogin.integerValue == 1) {
        [self requestGE_getuserinfo_URL];
        [self httpRequestWithKaiHuState];
    }else{
        [self.tableView.mj_header endRefreshing];
    }
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self requestGetQQCodeUrl];
    
    if ([SSKJ_User_Tool sharedUserTool].getLogin.integerValue == 1) {
        [self refreshHeader];
    }
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    if ([SSKJ_User_Tool sharedUserTool].getLogin.integerValue == 0) {
        //没有登录
        self.nameLabel.text = @"请先登录";
        self.IDLabel.text = @"请先登录";
        self.outLoginBtn.hidden = YES;
        self.goRenZhengLabel.text = @"去认证";
    }else{
        NSString *numberString = [[SSKJ_User_Tool sharedUserTool].getMobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.IDLabel.text = numberString;
        self.outLoginBtn.hidden = NO;
    }
    
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{
//                                                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
//                                                                      NSForegroundColorAttributeName:kMainBlackColor}];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//
//    self.navigationController.navigationBar.barTintColor = kMainColor;
//
//    NSMutableDictionary * attributes = [NSMutableDictionary dictionary];
//    attributes[NSFontAttributeName] =  [UIFont boldSystemFontOfSize:20];
//    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(50);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleW(15);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        
        if ([SSKJ_User_Tool sharedUserTool].getAccount.length == 0) {
            BLAlertView *alertView = [[BLAlertView alloc] initWithTitle:SSKJLocalized(@"未登录", nil) message:SSKJLocalized(@"请先登录账号", nil) sureBtn:SSKJLocalized(@"登录", nil) cancleBtn:SSKJLocalized(@"取消", nil)];
            
//            WS(weakSelf);
            
            alertView.cancelBlock = ^(NSString *message)
            {
                //LSLog(Localized(@"取消登录", nil));
            };
            
            alertView.sureBlock = ^(NSString *message)
            {
                GE_Login_ViewController *vc = [[GE_Login_ViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            };
            
            [alertView showBLAlertView];
            return;
        }
        
        
        switch (indexPath.row)
        {
            case 0:
            {
                //证券账户
                switch ([self.userModel.auth_status intValue]) {
                    case 4:
                    {
                        //已拒绝
                        GE_Mine_waitAuditVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GE_Mine_waitAuditVC"];
                        vc.dataSource = self.dataSource;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    case -1:
                    {
                        //删除
                        GE_Mine_RiskBooksVC *vc = [[GE_Mine_RiskBooksVC alloc] initWithNibName:@"GE_Mine_RiskBooksVC" bundle:nil];
                        vc.dataSource = self.dataSource;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    case 3:
                    {
                        [MBProgressHUD showSuccess:@"认证已通过"];
                    }
                        break;
                    case 2:
                    {
                        //审核中
//                        GE_Mine_waitAuditVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GE_Mine_waitAuditVC"];
//                        vc.dataSource = self.dataSource;
//                        [self.navigationController pushViewController:vc animated:YES];

                        [MBProgressHUD showSuccess:@"正在审核中"];
                    }
                        break;
                    case 1:
                    {
                        //已注册未开户
                        GE_Mine_RiskBooksVC *vc = [[GE_Mine_RiskBooksVC alloc] initWithNibName:@"GE_Mine_RiskBooksVC" bundle:nil];
                        vc.dataSource = self.dataSource;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
                break;
            case 1:
            {
                //账户明细
                GE_Mine_Account_RecodeVC *vc = [[GE_Mine_Account_RecodeVC alloc]init];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                //入金查询
                GE_Mine_IntoPrice_VC *vc = [[GE_Mine_IntoPrice_VC alloc]init];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                //出金查询
                GE_Mine_OutPrice_VC *vc = [[GE_Mine_OutPrice_VC alloc]init];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
        
    }else if (indexPath.section == 1)
    {
        
        switch (indexPath.row)
        {
            case 1000:
            {
                /**
                 {
                     //联系客服
                     if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
                         
                         UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
                         // 提供uin, 你所要联系人的QQ号码
                         NSString *qqstr = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",self.qqCodeStr];
                         NSURL *url = [NSURL URLWithString:qqstr];
                         NSURLRequest *request = [NSURLRequest requestWithURL:url];
                         [webView loadRequest:request];
                         [self.view addSubview:webView];
                         
                     }
                     else
                     {
                         
                         [MBProgressHUD showError:SSKJLocalized(@"本机未安装QQ应用", nil)];
                         
                     }
                 }
                 */
            }
                break;
            case 0:
            {
                //设置
                GE_Mine_Setting_VC *vc = [[GE_Mine_Setting_VC alloc]init];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
        
        
    }
    
}




//充值
- (IBAction)chongzhiBtnClick:(UIButton *)sender {
    if ([SSKJ_User_Tool sharedUserTool].getAccount.length == 0) {
        BLAlertView *alertView = [[BLAlertView alloc] initWithTitle:SSKJLocalized(@"未登录", nil) message:SSKJLocalized(@"请先登录账号", nil) sureBtn:SSKJLocalized(@"登录", nil) cancleBtn:SSKJLocalized(@"取消", nil)];
        
//        WS(weakSelf);
        
        alertView.cancelBlock = ^(NSString *message)
        {
            //LSLog(Localized(@"取消登录", nil));
        };
        
        alertView.sureBlock = ^(NSString *message)
        {
            GE_Login_ViewController *vc = [[GE_Login_ViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        [alertView showBLAlertView];
        return;
    }
    
    switch ([self.userModel.auth_status intValue]) {
        case 4:
        {
            //已拒绝
            [MBProgressHUD showSuccess:@"请先进行账户认证"];
        }
            break;
        case -1:
        {
            //删除
            [MBProgressHUD showSuccess:@"请先进行账户认证"];
        }
            break;
        case 3:
        {
//            [MBProgressHUD showSuccess:@"暂未开放"];
//
//            return;
            //审核成功
            GE_Mine_IntoPriceVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GE_Mine_IntoPriceVC"];
            vc.dataSource = self.dataSource;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 2:
        {
            //审核中
            [MBProgressHUD showSuccess:@"账户认证审核中，请耐心等待"];
        }
            break;
        case 1:
        {
            //已注册未开户
            [MBProgressHUD showSuccess:@"请先进行账户认证"];
        }
            break;
            
        default:
            break;
    }
    
}

//提现
- (IBAction)tixianBtnClick:(UIButton *)sender {
    if ([SSKJ_User_Tool sharedUserTool].getAccount.length == 0) {
        BLAlertView *alertView = [[BLAlertView alloc] initWithTitle:SSKJLocalized(@"未登录", nil) message:SSKJLocalized(@"请先登录账号", nil) sureBtn:SSKJLocalized(@"登录", nil) cancleBtn:SSKJLocalized(@"取消", nil)];
        
//        WS(weakSelf);
        
        alertView.cancelBlock = ^(NSString *message)
        {
            //LSLog(Localized(@"取消登录", nil));
        };
        
        alertView.sureBlock = ^(NSString *message)
        {
            GE_Login_ViewController *vc = [[GE_Login_ViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        [alertView showBLAlertView];
        return;
    }
    
    switch ([self.userModel.auth_status intValue]) {
        case 4:
        {
            //已拒绝
            [MBProgressHUD showSuccess:@"请先进行账户认证"];
        }
            break;
        case -1:
        {
            //删除
            [MBProgressHUD showSuccess:@"请先进行账户认证"];
        }
            break;
        case 3:
        {
//            [MBProgressHUD showSuccess:@"暂未开放"];
//            
//            return;
            //审核成功
            GE_Mine_Withdrawal_VC *vc = [[GE_Mine_Withdrawal_VC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 2:
        {
            //审核中
            [MBProgressHUD showSuccess:@"账户认证审核中，请耐心等待"];
        }
            break;
        case 1:
        {
            //已注册未开户
            [MBProgressHUD showSuccess:@"请先进行账户认证"];
        }
            break;
            
        default:
            break;
    }
    
}

//上传头像
- (IBAction)uploadImageBtnClick:(UIButton *)sender {
    
    if ([SSKJ_User_Tool sharedUserTool].getAccount.length == 0) {
        BLAlertView *alertView = [[BLAlertView alloc] initWithTitle:SSKJLocalized(@"未登录", nil) message:SSKJLocalized(@"请先登录账号", nil) sureBtn:SSKJLocalized(@"登录", nil) cancleBtn:SSKJLocalized(@"取消", nil)];
        
        //        WS(weakSelf);
        
        alertView.cancelBlock = ^(NSString *message)
        {
            //LSLog(Localized(@"取消登录", nil));
        };
        
        alertView.sureBlock = ^(NSString *message)
        {
            GE_Login_ViewController *vc = [[GE_Login_ViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        [alertView showBLAlertView];
        return;
    }
    
    //更改照片
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        ActionSheet *actionSheet = [[ActionSheet alloc] initWithDelegate:self CancelTitle:SSKJLocalized(@"取消", nil) addTitleLabel:NO OtherTitles:SSKJLocalized(@"从相册选择", nil),SSKJLocalized(@"拍照",nil),nil];
        [actionSheet show];
    }
    else {
        ActionSheet *actionSheet = [[ActionSheet alloc] initWithDelegate:self CancelTitle:SSKJLocalized(@"取消",nil) addTitleLabel:NO OtherTitles:SSKJLocalized(@"从相册选择",nil),nil];
        [actionSheet show];
        
    }
    
    
}

//请登录
- (IBAction)gotoLoginBtnClick:(UIButton *)sender {
    
    if ([SSKJ_User_Tool sharedUserTool].getAccount.length == 0) {
        //没有登录
        GE_Login_ViewController *vc = [[GE_Login_ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //已经登录
    }
    
    
}

//退出账户
- (IBAction)outLoginBtnClick:(UIButton *)sender {
    
    BLAlertView *alertView = [[BLAlertView alloc] initWithTitle:SSKJLocalized(@"提醒", nil) message:SSKJLocalized(@"是否要退出该账号", nil) sureBtn:SSKJLocalized(@"确定", nil) cancleBtn:SSKJLocalized(@"取消", nil)];
    
    alertView.sureBlock = ^(NSString *message)
    {
        //清理
        [SSKJ_User_Tool clearUserInfo];
        GE_Login_ViewController *vc = [[GE_Login_ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    alertView.cancelBlock = ^(NSString *message) {};
    
    [alertView showBLAlertView];
    
    
}

- (void)actionSheet:(ActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.view.backgroundColor = kMainColor;
    if ([imagePickerController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [imagePickerController.navigationBar setBarTintColor:kMainColor];
        [imagePickerController.navigationBar setTranslucent:NO];
        [imagePickerController.navigationBar setTintColor:[UIColor whiteColor]];
    }else{
        [imagePickerController.navigationBar setBackgroundColor:kMainWihteColor];
    }
    //    更改titieview的字体颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = kMainWihteColor;
    [imagePickerController.navigationBar setTitleTextAttributes:attrs];
    
    switch (buttonIndex) {
        case 1:
        {
            
            //相册选择
            imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        }
            break;
        case 2:
        {
            //拍照选择
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
            break;
            
        default:
            break;
    }
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}

- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}

- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image1 = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    //头像上传

    NSArray *photosArr = @[image1];
    
    // 基于AFN3.0+ 封装的HTPPSession句柄
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //[manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"systemType"];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    // 在parameters里存放照片以外的对象
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:[NSString stringWithFormat:@"%@",GE_Upload_pic_URL] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
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
            if(i==0) //银行卡正面
            {
                fileName = @"file.jpg";
                [formData appendPartWithFileData:imageData name:@"file_pic" fileName:fileName mimeType:@"image/jpeg"];
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
                
                [self uploadHeadPicHttpRequest:responseObject[@"data"][@"url"]];
            });
        } else {
            [MBProgressHUD showError:netwok_model.msg];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"上传失败", nil)];
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark -- 获取个人信息接口 --
- (void)requestGE_getuserinfo_URL
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_getuserinfo_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == 200)
        {
            
            
            SSKJ_UserInfo_Model *model = [SSKJ_UserInfo_Model mj_objectWithKeyValues:netModel.data];
            
            [self.dataSource setObject:model.auth_status forKey:@"auth_status"];
            [self.dataSource setObject:model.wallone forKey:@"wallone"];
            
            weakSelf.userModel = model;
            
            [[SSKJ_User_Tool sharedUserTool] saveUserInfoWithUserInfoModel:model];
            
            weakSelf.nameLabel.text = model.realname;
            
            [self.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ProductBaseServer,model.headimg]] placeholderImage:[UIImage imageNamed:@"RZ_My_ures"]];
            
            switch ([netModel.data[@"auth_status"] intValue]) {
                case 1:
                {
                    //未认证
                    self.goRenZhengLabel.text = @"去认证";
                }
                    break;
                case 2:
                {
                    //待审核
                    self.goRenZhengLabel.text = @"审核中";
                }
                    break;
                case 3:
                {
                    //已通过
                    self.goRenZhengLabel.text = @"已通过";
                }
                    break;
                case 4:
                {
                    //已拒绝
                    self.goRenZhengLabel.text = @"已拒绝";
                    
                }
                    break;
                    
                default:
                    break;
            }
            
            
            
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        [self.tableView.mj_header endRefreshing];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        [self.tableView.mj_header endRefreshing];
    }];
}

//头像上传
- (void)uploadHeadPicHttpRequest:(NSString *)headPickURLStr
{
    NSDictionary *params = @{@"account":[SSKJ_User_Tool sharedUserTool].getAccount,
                             @"headimg":headPickURLStr
                             };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:[NSString stringWithFormat:@"%@/home/Users/update_headimg",ProductBaseServer] RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            [self.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ProductBaseServer,headPickURLStr]] placeholderImage:[UIImage imageNamed:@"RZ_My_ures"]];
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
    }];
    
}

//实名开户状态
- (void)httpRequestWithKaiHuState
{
    NSDictionary *params = @{@"account":[SSKJ_User_Tool sharedUserTool].getAccount};
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:[NSString stringWithFormat:@"%@/home/Users/backRemark",ProductBaseServer] RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            NSString *shenHeDic = responseObject[@"data"];
            
            [self.dataSource setObject:shenHeDic forKey:@"checkReason"];
            
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
    }];
    
}

#pragma mark -- 获取联系QQ --
- (void)requestGetQQCodeUrl{
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:[NSString stringWithFormat:@"%@/home/ajax/get_connect",ProductBaseServer] RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (network_Model.status.integerValue == 200){
            self.qqCodeStr = network_Model.data[@"qq"];
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
}

@end
