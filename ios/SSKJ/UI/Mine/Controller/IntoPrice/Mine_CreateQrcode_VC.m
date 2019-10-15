//
//  Mine_CreateQrcode_VC.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Mine_CreateQrcode_VC.h"

@interface Mine_CreateQrcode_VC()

@property (nonatomic,strong) UIImageView *qrImg;

@property (nonatomic,strong) UILabel * tipLabel;

@end

@implementation Mine_CreateQrcode_VC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = kMainWihteColor;
    
    self.title = @"银联扫码";
    
    [self qrImg];
    
    [self tipLabel];
    
    [self creatCIQRCodeImage:self.urlStr];
}

- (UIImageView *)qrImg{
    if (_qrImg == nil) {
        _qrImg = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@""];
        [self.view addSubview:_qrImg];
        [_qrImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(ScaleW(80)));
            make.centerX.equalTo(self.view.mas_centerX);
            make.width.height.equalTo(@(ScaleW(150)));
        }];
    }
    return _qrImg;
}

- (UILabel *)tipLabel{
    if (_tipLabel == nil) {
        _tipLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"请使用云闪付扫码支付" textColor:kMainBlackColor font:systemFont(ScaleW(14))];
        _tipLabel.numberOfLines = 0;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_tipLabel];
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.qrImg.mas_bottom).offset(ScaleW(30));
            make.left.equalTo(@(ScaleW(20)));
            make.right.equalTo(@(ScaleW(-20)));
        }];
    }
    return _tipLabel;
}


/**
 *  生成二维码
 */
- (void)creatCIQRCodeImage:(NSString *)eamilStr
{
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认设置
    [filter setDefaults];
    // 3. 给过滤器添加数据
    NSString *dataString = eamilStr;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    // 注意，这里的value必须是NSData类型
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 4. 生成二维码
    CIImage *outputImage = [filter outputImage];
    // 5. 显示二维码
    // 该方法生成的图片较模糊
    //    self.codeImg.image = [UIImage imageWithCIImage:outputImage];
    // 使用该方法生成高清图
    self.qrImg.image = [self creatNonInterpolatedUIImageFormCIImage:outputImage withSize:ScaleW(150)];
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 *
 *  @return 生成高清的UIImage
 */
- (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1. 创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

@end
