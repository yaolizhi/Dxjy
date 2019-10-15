//
//  WL_Launch_ViewController.m
//  ZYW_MIT
//
//  Created by James on 2018/8/9.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "WL_Launch_ViewController.h"

#import "UIImage+GIFS.h"

#import "AppDelegate.h"

#import "LLGifImageView.h"
#import "LLGifView.h"


@interface WL_Launch_ViewController ()
@property (nonatomic, strong) UIImageView *backImageView;

@property (nonatomic, strong) LLGifView *gifView;

@property (nonatomic, strong) LLGifImageView *gifImageView;

@end

@implementation WL_Launch_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSData *localData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"launch_home" ofType:@"gif"]];
    
    [self.view addSubview:self.backImageView];
    self.backImageView.image = [self cdi_imagesWithGif:@"launch_home"];
    
    _gifView = [[LLGifView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight) data:localData];
    
    [self.view addSubview:_gifView];
    
    [_gifView startGif];
    
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [appDelegate performSelector:@selector(gotoMain) withObject:nil afterDelay:3.5];
}



- (UIImage *)cdi_imagesWithGif:(NSString *)gifNameInBoundle {
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:gifNameInBoundle withExtension:@"gif"];
    
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);
    size_t gifCount = CGImageSourceGetCount(gifSource);
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, 0, NULL);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return image;
}


-(UIImageView *)backImageView
{
    if (nil == _backImageView) {
        _backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    }
    return _backImageView;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
