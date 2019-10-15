//
//  GE_Mine_ViewController.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_ViewController.h"

#import "GE_Mine_realNameVC.h"

#import "GE_Mine_IntoPrice_VC.h"

#import "GE_Mine_OutPrice_VC.h"

#import "GE_Mine_XSZD_VC.h"

#import "GE_Mine_Setting_VC.h"

#import "GE_Mine_Account_RecodeVC.h"

#import "GE_Mine_RiskBooksVC.h"

#import "GE_Login_ViewController.h"

#import "GE_Mine_waitAuditVC.h"
#import "GE_Mine_IntoPriceVC.h"

#import "GE_Mine_Withdrawal_VC.h"

#import <AFNetworking.h>

#import <UIButton+WebCache.h>
#import "ActionSheet.h"

@interface GE_Mine_ViewController ()<ActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *goRenZhengLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *chongzhiBtn;
@property (weak, nonatomic) IBOutlet UIButton *tixianBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhangquanBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhanghuBtn;
@property (weak, nonatomic) IBOutlet UIButton *rujinBtn;
@property (weak, nonatomic) IBOutlet UIButton *chunjinBtn;
@property (weak, nonatomic) IBOutlet UIButton *xinshouBtn;
@property (weak, nonatomic) IBOutlet UIButton *shezhiBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *defaultPicConsHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *defaultPicConsWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewConsHeight;

@property (nonatomic, copy) NSString *headPicURLStr;
@property (nonatomic,strong) NSDictionary *dataSource;


@end

@implementation GE_Mine_ViewController


- (instancetype)init{
    if (self = [super init]) {
        
        self = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GE_Mine_ViewController"];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kMainBackgroundColor;
    
    self.dataSource = [[NSDictionary alloc] init];
    
    //去掉上边留有的 状态栏 距离
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//    _defaultPicConsHeight.constant = ScaleW(65);
//    _defaultPicConsWidth.constant = ScaleW(65);
    _uploadBtn.layer.cornerRadius = _uploadBtn.height/2;
    _uploadBtn.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = _bgView.height/2;
    _bgView.layer.masksToBounds = YES;
    _phoneLabel.font = [UIFont systemFontOfSize:ScaleW(15)];
    _goRenZhengLabel.font = [UIFont systemFontOfSize:ScaleW(10)];
    [_chongzhiBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    _chongzhiBtn.titleLabel.font = [UIFont systemFontOfSize:ScaleW(15)];
    [_tixianBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    _tixianBtn.titleLabel.font = [UIFont systemFontOfSize:ScaleW(15)];
    
    [_zhangquanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    _zhangquanBtn.titleLabel.font = [UIFont systemFontOfSize:ScaleW(14)];
    [_zhanghuBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    _zhanghuBtn.titleLabel.font = [UIFont systemFontOfSize:ScaleW(14)];
    [_rujinBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    _rujinBtn.titleLabel.font = [UIFont systemFontOfSize:ScaleW(14)];
    [_chunjinBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    _chunjinBtn.titleLabel.font = [UIFont systemFontOfSize:ScaleW(14)];
    [_xinshouBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    _xinshouBtn.titleLabel.font = [UIFont systemFontOfSize:ScaleW(14)];
    [_shezhiBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -50, 0, 0)];
    [_shezhiBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    _shezhiBtn.titleLabel.font = [UIFont systemFontOfSize:ScaleW(14)];
    self.bgViewConsHeight.constant = ScaleW(70);
    
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    if (IsiPhone5 || IsiPhone4) {
        _goRenZhengLabel.font = [UIFont systemFontOfSize:7];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    [self requestSysSetUrl];
    
    if ([SSKJ_User_Tool sharedUserTool].getAccount.length == 0) {
        //没有登录
        self.phoneLabel.text = @"请先登录";
        [self.uploadBtn setImage:[UIImage imageNamed:@"GE_My_defaulitPic"] forState:UIControlStateNormal];
        self.goRenZhengLabel.text = @"去认证>";
    }else{
        NSString *numberString = [[SSKJ_User_Tool sharedUserTool].getMobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.phoneLabel.text = numberString;
        [self httpRequest];
    }
//    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _bgView.layer.cornerRadius = _bgView.height/2;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            return ScaleW(280);
        }
            break;
        case 1:
        {
            return ScaleW(20);
        }
            break;
        case 2:
        {
            return ScaleW(70);
        }
            break;
        case 3:
        {
            return ScaleW(70);
        }
            break;
        case 4:
        {
            return ScaleW(70);
        }
            break;
        case 5:
        {
            if ([SSKJ_User_Tool sharedUserTool].getAccount.length == 0) {
                //没有登录
                return ScaleW(0);
            }else{
                //已经登录
                return ScaleW(70);
            }
        }
            break;
            
        default:
            break;
    }
    return 0.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            // 登录
            if ([SSKJ_User_Tool sharedUserTool].getAccount.length == 0) {
                //没有登录
                GE_Login_ViewController *vc = [[GE_Login_ViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                //已经登录
            }
            
        }
            break;
        case 5:
        {
            // 退出登录
            
            
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
            break;
            
        default:
            break;
    }
}

//更换头像按钮
- (IBAction)upLoadImageBtn:(UIButton *)sender {
    
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
//    [_uploadBtn setImage:image1 forState:UIControlStateNormal];
    
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    //头像上传
    NSDictionary *params = @{@"account":[SSKJ_User_Tool sharedUserTool].getAccount,
                             @"app":@"app",
                             @"action":@"upImg",
                             @"sessionId":[SSKJ_User_Tool sharedUserTool].getToken,
                             @"systemType":@"IOS"
                             };
    NSArray *photosArr = @[image1];
    
    // 基于AFN3.0+ 封装的HTPPSession句柄
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //[manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"systemType"];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    // 在parameters里存放照片以外的对象
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:[NSString stringWithFormat:@"%@",ProductBaseURL] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
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
                [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
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
                
                [self uploadHeadPicHttpRequest:responseObject[@"data"]];
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


- (IBAction)btnClick:(UIButton *)sender {
    
    if ([SSKJ_User_Tool sharedUserTool].getAccount.length == 0) {
        BLAlertView *alertView = [[BLAlertView alloc] initWithTitle:SSKJLocalized(@"未登录", nil) message:SSKJLocalized(@"请先登录账号", nil) sureBtn:SSKJLocalized(@"登录", nil) cancleBtn:SSKJLocalized(@"取消", nil)];
        
        WS(weakSelf);
        
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
    
    switch (sender.tag) {
        case 11:
        {
            //充值(入金)
            
            switch ([self.dataSource[@"status"] intValue]) {
                case -2:
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
                case 0:
                {
                    //审核成功
                    GE_Mine_IntoPriceVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GE_Mine_IntoPriceVC"];
                    vc.dataSource = self.dataSource;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                case 1:
                {
                    //审核中
                    [MBProgressHUD showSuccess:@"账户认证审核中，请耐心等待"];
                }
                    break;
                case 2:
                {
                    //已注册未开户
                    [MBProgressHUD showSuccess:@"请先进行账户认证"];
                }
                    break;
                    
                default:
                    break;
            }
            
            
            
        }
            break;
        case 12:
        {
            //提现（出金）
            
            switch ([self.dataSource[@"status"] intValue]) {
                case -2:
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
                case 0:
                {
                    //审核成功
                    GE_Mine_Withdrawal_VC *vc = [[GE_Mine_Withdrawal_VC alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                case 1:
                {
                    //审核中
                    [MBProgressHUD showSuccess:@"账户认证审核中，请耐心等待"];
                }
                    break;
                case 2:
                {
                    //已注册未开户
                    [MBProgressHUD showSuccess:@"请先进行账户认证"];
                }
                    break;
                    
                default:
                    break;
            }
            
            
            
        }
            break;
        case 13:
        {
            //证券账户
            
            switch ([self.dataSource[@"status"] intValue]) {
                case -2:
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
                case 0:
                {
                    //审核成功
//                    GE_Mine_waitAuditVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GE_Mine_waitAuditVC"];
//                    vc.dataSource = self.dataSource;
//                    [self.navigationController pushViewController:vc animated:YES];
                    [MBProgressHUD showSuccess:@"认证已通过"];
                }
                    break;
                case 1:
                {
                    //审核中
                    GE_Mine_waitAuditVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GE_Mine_waitAuditVC"];
                    vc.dataSource = self.dataSource;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                case 2:
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
        case 14:
        {
            //账户明细
            
            GE_Mine_Account_RecodeVC *vc = [[GE_Mine_Account_RecodeVC alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 15:
        {
            //入金查询
            GE_Mine_IntoPrice_VC *vc = [[GE_Mine_IntoPrice_VC alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 16:
        {
            //出金查询
            
            GE_Mine_OutPrice_VC *vc = [[GE_Mine_OutPrice_VC alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 17:
        {
            //新手引导
            GE_Mine_XSZD_VC *vc = [[GE_Mine_XSZD_VC alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 18:
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

//头像上传
- (void)uploadHeadPicHttpRequest:(NSString *)headPickURLStr
{
    NSDictionary *params = @{@"account":[SSKJ_User_Tool sharedUserTool].getAccount,
                             @"app":@"app",
                             @"action":@"headImgUrl",
                             @"sessionId":[SSKJ_User_Tool sharedUserTool].getToken,
                             @"systemType":@"IOS",
                             @"headImgUrl":headPickURLStr
                             };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:[NSString stringWithFormat:@"%@",ProductBaseURL] RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            [self.uploadBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ProductBaseServer,headPickURLStr]] forState:UIControlStateNormal];
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
    }];
    
}


//个人信息
- (void)httpRequest
{
    NSDictionary *params = @{@"account":[SSKJ_User_Tool sharedUserTool].getAccount,
                             @"app":@"app",
                             @"action":@"accountInfo",
                             @"sessionId":[SSKJ_User_Tool sharedUserTool].getToken,
                             @"systemType":@"IOS"
                             };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:[NSString stringWithFormat:@"%@",ProductBaseURL] RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            self.dataSource = responseObject[@"data"];
            
            NSString *numberString = [self.dataSource[@"account"] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            self.phoneLabel.text = numberString;
            if (self.dataSource[@"headImgUrl"] == [NSNull null]) {
                [self.uploadBtn setImage:[UIImage imageNamed:@"GE_My_defaulitPic"] forState:UIControlStateNormal];
            }else{
                [self.uploadBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ProductBaseServer,self.dataSource[@"headImgUrl"]]] forState:UIControlStateNormal];
            }
            
            switch ([self.dataSource[@"status"] intValue]) {
                case -2:
                {
                    //已拒绝
                    self.goRenZhengLabel.text = @"已拒绝>";
                }
                    break;
                case -1:
                {
                    //删除
                    self.goRenZhengLabel.text = @"已删除>";
                }
                    break;
                case 0:
                {
                    //删除
                    self.goRenZhengLabel.text = @"已通过>";
                }
                    break;
                case 1:
                {
                    //审核中
                    self.goRenZhengLabel.text = @"审核中>";
                }
                    break;
                case 2:
                {
                    //已注册未开户
                    self.goRenZhengLabel.text = @"去认证>";
                }
                    break;
                    
                default:
                    break;
            }
            
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
        [self.tableView reloadData];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
    }];
    
}


#pragma mark --- 交易设置信息 ---
- (void)requestSysSetUrl
{
    NSDictionary *params = @{@"action":@"sysSet",
                             @"account":[[SSKJ_User_Tool sharedUserTool] getAccount],
                             @"sessionId":[[SSKJ_User_Tool sharedUserTool] getToken]
                             };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:GE_Pubilc_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        //        NSLog(@"%@",responseObject);
        
        WL_Network_Model * network_Model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            GE_Mine_SysSet_Model *model = [GE_Mine_SysSet_Model mj_objectWithKeyValues:network_Model.data];
            
            [[SSKJ_User_Tool sharedUserTool] saveSysSetInfoModel:model];
        }
        else
        {
            [MBProgressHUD showError:network_Model.msg];
        }
        
        [hud hideAnimated:YES];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
}


@end
