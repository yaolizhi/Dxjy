//
//  Mine_RealName_Bank_View.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/5/17.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Mine_RealName_Bank_View.h"

@implementation Mine_RealName_Bank_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self titleLabel];
        
        [self bankImg];
        
        [self bankLabel];
        
    }
    return self;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"上传银行卡", nil) textColor:kMainBlackColor font:systemFont(ScaleW(15))];
        
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.height.equalTo(@(ScaleW(15)));
        }];
    }
    return _titleLabel;
}

- (UIImageView *)bankImg{
    if (_bankImg == nil) {
        UIImage *image = [UIImage imageNamed:@"GE_My_addBtn1"];
        _bankImg = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@"GE_My_addBtn1"];
        _bankImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bankImgAction)];
        [_bankImg addGestureRecognizer:tap];
        [self addSubview:_bankImg];
        [_bankImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(ScaleW(20));
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(@(ScaleW(image.size.height)));
            make.width.equalTo(@(ScaleW(image.size.width)));
        }];
    }
    return _bankImg;
}

- (UILabel *)bankLabel{
    if (_bankLabel == nil) {
        _bankLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"银行卡正面", nil) textColor:kMainBlackColor font:systemFont(ScaleW(15))];
        _bankLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_bankLabel];
        [_bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bankImg.mas_bottom).offset(ScaleW(15));
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@(ScreenWidth));
            make.height.equalTo(@(ScaleW(15)));
        }];
    }
    return _bankLabel;
}

- (void)bankImgAction{
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
    self.bankImg.image = image1;
    self.bankCardImage = image1;
    [picker dismissViewControllerAnimated:YES completion:^{}];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.vc dismissViewControllerAnimated:YES completion:^{}];
}
@end
