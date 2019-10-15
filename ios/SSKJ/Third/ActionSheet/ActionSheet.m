//
//  CCEJActionSheet.m
//  JiaTianXia
//
//  Created by 张超 on 16/5/18.
//  Copyright © 2016年 Earloye. All rights reserved.
//

#import "ActionSheet.h"

// 每个按钮的高度
#define BtnHeight 46
// 取消按钮上面的间隔高度
#define Margin 8+13.8

#define HJCColor(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
// 背景色
#define GlobelBgColor HJCColor(237, 240, 242)
// 分割线颜色
#define GlobelSeparatorColor HJCColor(226, 226, 226)
// 普通状态下的图片
#define normalImage [self createImageWithColor:HJCColor(255, 255, 255)]
// 高亮状态下的图片
#define highImage [self createImageWithColor:HJCColor(242, 242, 242)]

//#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//#define ScreenHeight [UIScreen mainScreen].bounds.size.height
// 字体
//#define HeitiLight(f) [UIFont fontWithName:@"STHeitiSC-Light" size:f]
#define HeitiLight(f)  [UIFont systemFontOfSize:f]

@interface ActionSheet ()
{
    int _tag;
    BOOL _titleLabel;
}


@property (nonatomic, weak) ActionSheet *actionSheet;
@property (nonatomic, weak) UIView *sheetView;

@end


@implementation ActionSheet

- (instancetype)initWithDelegate:(id<ActionSheetDelegate>)delegate CancelTitle:(NSString *)cancelTitle addTitleLabel:(BOOL)titleLabel OtherTitles:(NSString *)otherTitles, ...
{
    //是否加titleLabel
    _titleLabel = titleLabel;
    
    ActionSheet *actionSheet = [self init];
    self.actionSheet = actionSheet;
    
    
    actionSheet.delegate = delegate;
    
    // 黑色遮盖
    actionSheet.frame = [UIScreen mainScreen].bounds;
    actionSheet.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication].keyWindow addSubview:actionSheet];
    actionSheet.alpha = 0.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)];
    [actionSheet addGestureRecognizer:tap];
    
    // sheet
    UIView *sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    sheetView.backgroundColor = GlobelBgColor;
    sheetView.alpha = 1;
    [[UIApplication sharedApplication].keyWindow addSubview:sheetView];
    self.sheetView = sheetView;
    sheetView.hidden = YES;
    
    _tag = 1;
    
    NSString* curStr;
    va_list list;
    if(otherTitles)
    {
        [self setupBtnWithTitle:otherTitles];
        
        va_start(list, otherTitles);
        while ((curStr = va_arg(list, NSString*))) {
            [self setupBtnWithTitle:curStr];
            
        }
        va_end(list);
    }
    
    CGRect sheetViewF = sheetView.frame;
    sheetViewF.size.height = BtnHeight * _tag + Margin;
    sheetView.frame = sheetViewF;
    
    // 取消按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, sheetView.frame.size.height - BtnHeight, ScreenWidth, BtnHeight)];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn setTitle:cancelTitle forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = HeitiLight(15);
    btn.tag = 0;
    [btn addTarget:self action:@selector(sheetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.sheetView addSubview:btn];
    
    if (titleLabel) {
        //设置提示用语
        UIButton *button = [self.sheetView viewWithTag:1];
        [button setTitle:@"" forState:UIControlStateNormal];
        button.enabled = NO;
        UIButton *button2 = [self.sheetView viewWithTag:2];
        [button2 setTitleColor:HJCColor(222, 8, 10) forState:UIControlStateNormal];
        UILabel *titleLab = [[UILabel alloc] initWithFrame:button.frame];
        titleLab.frame = CGRectMake(0, 0, button.bounds.size.width, button.bounds.size.height);
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = HJCColor(157, 157, 157);
        titleLab.backgroundColor = [UIColor whiteColor];
        titleLab.numberOfLines = 0;
        titleLab.font = HeitiLight(13);
        titleLab.text = otherTitles;
        [button addSubview: titleLab];
    }
    
    return actionSheet;
}

- (void)show{
    
    self.sheetView.hidden = NO;
    
    CGRect sheetViewF = self.sheetView.frame;
    sheetViewF.origin.y = ScreenHeight;
    self.sheetView.frame = sheetViewF;
    
    CGRect newSheetViewF = self.sheetView.frame;
    newSheetViewF.origin.y = ScreenHeight - self.sheetView.frame.size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.sheetView.frame = newSheetViewF;
        
        self.actionSheet.alpha = 0.3;
    }];
    
}

- (void)setupBtnWithTitle:(NSString *)title{
    // 创建按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, BtnHeight * (_tag - 1) , ScreenWidth, BtnHeight)];
    if (_titleLabel) {
        if (_tag==1) {
            btn.frame = CGRectMake(0, 0, ScreenWidth, BtnHeight*1.3);
        }else{
            btn.frame = CGRectMake(0, (BtnHeight*1.3)+BtnHeight * (_tag - 2), ScreenWidth, BtnHeight);
        }
    }
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = HeitiLight(15);
    btn.tag = _tag;
    [btn addTarget:self action:@selector(sheetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.sheetView addSubview:btn];
    
    // 最上面画分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    line.backgroundColor = GlobelSeparatorColor;
    [btn addSubview:line];
    
    _tag ++;
}

- (void)coverClick{
    CGRect sheetViewF = self.sheetView.frame;
    sheetViewF.origin.y = ScreenHeight;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.sheetView.frame = sheetViewF;
        self.actionSheet.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.actionSheet removeFromSuperview];
        [self.sheetView removeFromSuperview];
    }];
}

- (void)sheetBtnClick:(UIButton *)btn{
    if (btn.tag == 0) {
        [self coverClick];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self.actionSheet clickedButtonAtIndex:btn.tag];
        [self coverClick];
    }
}

- (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
