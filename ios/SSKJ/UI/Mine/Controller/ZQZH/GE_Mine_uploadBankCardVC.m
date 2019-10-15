//
//  GE_Mine_uploadBankCardVC.m
//  SSKJ
//
//  Created by 张超 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_uploadBankCardVC.h"
#import "GE_Mine_waitAuditVC.h"
#import "ActionSheet.h"
#import <AFNetworking.h>

@interface GE_Mine_uploadBankCardVC ()<ActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (weak, nonatomic) IBOutlet UILabel *ziliaoLabel;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UIView *yuanView1;
@property (weak, nonatomic) IBOutlet UIView *yuanView2;
@property (weak, nonatomic) IBOutlet UIView *yuanView3;
@property (weak, nonatomic) IBOutlet UIView *yuanView4;

@property (weak, nonatomic) IBOutlet UIButton *bankCardBtn;
@property (weak, nonatomic) IBOutlet UILabel *bankCardLabel;

@property (nonatomic, strong) UIImage *bankCardImage;

@end

@implementation GE_Mine_uploadBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"实名开户";
    
    self.btn1.titleLabel.font = [UIFont systemFontOfSize:ScaleW(13)];
    [self.btn1 setTitleEdgeInsets:UIEdgeInsetsMake(ScaleW(45), 0, 0, 0)];
    self.btn2.titleLabel.font = [UIFont systemFontOfSize:ScaleW(13)];
    [self.btn2 setTitleEdgeInsets:UIEdgeInsetsMake(ScaleW(45), 0, 0, 0)];
    self.btn3.titleLabel.font = [UIFont systemFontOfSize:ScaleW(13)];
    [self.btn3 setTitleEdgeInsets:UIEdgeInsetsMake(ScaleW(45), 0, 0, 0)];
    self.btn4.titleLabel.font = [UIFont systemFontOfSize:ScaleW(13)];
    [self.btn4 setTitleEdgeInsets:UIEdgeInsetsMake(ScaleW(45), 0, 0, 0)];
    
    self.ziliaoLabel.font = [UIFont systemFontOfSize:ScaleW(15)];
    self.nextBtn.titleLabel.font = [UIFont systemFontOfSize:ScaleW(16)];
    self.bankCardLabel.font = [UIFont systemFontOfSize:ScaleW(15)];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            return ScaleW(100);
        }
            break;
        case 1:
        {
            return ScaleW(50);
        }
            break;
        case 2:
        {
            return ScaleW(180);
        }
            break;
        case 3:
        {
            return 150;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

//银行卡正面
- (IBAction)bankCardBtnClick:(UIButton *)sender {
    
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
    [_bankCardBtn setImage:image1 forState:UIControlStateNormal];
    _bankCardImage = image1;
    [picker dismissViewControllerAnimated:YES completion:^{}];
    //    [self showHud];
    //    [self httpRequestUploadImage];
}

//下一步
- (IBAction)nextBtnClick:(UIButton *)sender {
    
    if (!_bankCardImage) {
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
                             @"cardType":self.cardType,
                             @"cardAccount":self.cardAccount,
                             @"cardAddress":self.cardAddress
                             };
    
    NSArray *photosArr = @[self.cardimg1,self.cardimg2,self.bankCardImage];
    
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
                
                GE_Mine_waitAuditVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GE_Mine_waitAuditVC"];
                [self.navigationController pushViewController:vc animated:YES];
            });
        } else {
            [MBProgressHUD showError:netwok_model.msg];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"上传失败", nil)];
    }];
}


@end
