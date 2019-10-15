//
//  Mine_RealName_Card_View.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/5/17.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Mine_RealName_Card_View.h"



@implementation Mine_RealName_Card_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self titleLabel];
        
        [self zhengmianImg];
        
        [self zhengmianLabel];
        
        [self fanmianImg];
        
        [self fanmianLabel];
        
    }
    return self;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"上传身份证", nil) textColor:kMainBlackColor font:systemFont(ScaleW(15))];
        
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.height.equalTo(@(ScaleW(15)));
        }];
    }
    return _titleLabel;
}

- (UIImageView *)zhengmianImg{
    if (_zhengmianImg == nil) {
        UIImage *image = [UIImage imageNamed:@"GE_My_addBtn1"];
        _zhengmianImg = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@"GE_My_addBtn1"];
        _zhengmianImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zhengmianImgAction)];
        [_zhengmianImg addGestureRecognizer:tap];
        [self addSubview:_zhengmianImg];
        [_zhengmianImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(ScaleW(20));
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(@(ScaleW(image.size.height)));
            make.width.equalTo(@(ScaleW(image.size.width)));
        }];
    }
    return _zhengmianImg;
}

- (UILabel *)zhengmianLabel{
    if (_zhengmianLabel == nil) {
        _zhengmianLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"身份证正面", nil) textColor:kMainBlackColor font:systemFont(ScaleW(15))];
        _zhengmianLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_zhengmianLabel];
        [_zhengmianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.zhengmianImg.mas_bottom).offset(ScaleW(15));
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@(ScreenWidth));
            make.height.equalTo(@(ScaleW(15)));
        }];
    }
    return _zhengmianLabel;
}

- (UIImageView *)fanmianImg{
    if (_fanmianImg == nil) {
        UIImage *image = [UIImage imageNamed:@"GE_My_addBtn1"];
        _fanmianImg = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@"GE_My_addBtn1"];
        _fanmianImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fanmianImgAction)];
        [_fanmianImg addGestureRecognizer:tap];
        [self addSubview:_fanmianImg];
        [_fanmianImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.zhengmianLabel.mas_bottom).offset(ScaleW(20));
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(@(ScaleW(image.size.height)));
            make.width.equalTo(@(ScaleW(image.size.width)));
        }];
    }
    return _fanmianImg;
}

- (UILabel *)fanmianLabel{
    if (_fanmianLabel == nil) {
        _fanmianLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"身份证反面", nil) textColor:kMainBlackColor font:systemFont(ScaleW(15))];
        _fanmianLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_fanmianLabel];
        [_fanmianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fanmianImg.mas_bottom).offset(ScaleW(15));
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@(ScreenWidth));
            make.height.equalTo(@(ScaleW(15)));
        }];
    }
    return _fanmianLabel;
}

- (void)zhengmianImgAction{
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
    //正面
    self.index = 1;
}

- (void)fanmianImgAction{
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
    //反面
    self.index = 2;
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
    
    [self.vc presentViewController:imagePickerController animated:YES completion:^{}];
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
    switch (self.index) {
        case 1:
        {
            //正面
            self.zhengmianImg.image = image1;
            
            self.zhengImage = image1;
        }
            break;
        case 2:
        {
            //反面
            self.fanmianImg.image = image1;
            
            self.fanImage = image1;
        }
            break;
            
        default:
            break;
    }
    [picker dismissViewControllerAnimated:YES completion:^{}];
    //    [self showHud];
    //    [self httpRequestUploadImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.vc dismissViewControllerAnimated:YES completion:^{}];
}

@end
