//
//  BFEX_System_Version_View.m
//  ZYW_MIT
//
//  Created by James on 2018/7/5.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BFEX_System_Version_View.h"

@implementation BFEX_System_Version_View

#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        self.hidden=YES;
        
        [self setLayout];
        
    }
    
    return self;
}

#pragma mark - 创建UI
- (void)setLayout
{
    //弹出框
    [self mainView];
 
    //图标
    [self versionIMV];
    
    
    //取消
    [self cancelButton];
    
    //确认
    [self sureButton];
    
    //横线
    [self lineView];
    
    //标题
    [self titleLabel];
    
    //信息
    [self msgTextView];
    
   
    
    
}
#pragma mark - 主视图
-(UIView *)mainView
{
    if (_mainView==nil)
    {
        UIImage *image=[UIImage imageNamed:@"bfex_version_bg1"];
        
        CGFloat leftSpace=(ScreenWidth-image.size.width)/2;
        
        _mainView=[[UIView alloc] init];
        
        _mainView.backgroundColor=[UIColor whiteColor];
        
        _mainView.layer.masksToBounds=YES;
        
        _mainView.layer.cornerRadius=5.0;
        
        [self addSubview:_mainView];
        
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@(leftSpace));
            
            make.centerY.equalTo(self.mas_centerY);
            
            make.width.equalTo(@(image.size.width));
            
            make.height.equalTo(@380);
        }];
    }
    
    return _mainView;
}


#pragma mark - 横线
-(UIView *)lineView
{
    if (_lineView==nil)
    {
        _lineView=[[UIView alloc] init];
        
        _lineView.backgroundColor=[WLTools stringToColor:@"#a4a4a4"];
        
        [self.mainView addSubview:_lineView];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.sureButton.mas_top);
            
            make.height.equalTo(@0.5);
            
            make.left.equalTo(self.mainView.mas_left);
            
            make.right.equalTo(self.mainView.mas_right);
        }];
    }
    
    return _lineView;
}

#pragma mark - 图标
-(UIImageView *)versionIMV
{
    if (_versionIMV==nil)
    {
        UIImage *image=[UIImage imageNamed:@"bfex_version_bg1"];
        
        _versionIMV=[[UIImageView alloc] initWithImage:image];
        
        [self.mainView addSubview:_versionIMV];
        
        [_versionIMV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@0);
            
            make.top.equalTo(@0);
            
            make.width.equalTo(@(image.size.width));
            
            make.height.equalTo(@(image.size.height));
        }];
    }
    
    return _versionIMV;
}

#pragma mark - 标题
-(UILabel *)titleLabel
{
    if (_titleLabel==nil)
    {
        _titleLabel=[[UILabel alloc] init];
        
        _titleLabel.font=WLFontSize(18.0);
        
        _titleLabel.text=@"";
        
        _titleLabel.textColor=[WLTools stringToColor:@"#303030"];
        
        [self.mainView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mainView.mas_left).offset(25);
            
            make.top.equalTo(self.versionIMV.mas_bottom).offset(15);
            
        }];
    }
    
    return _titleLabel;
}

#pragma mark - 版本号

-(UILabel *)versionNumLabel{
    if (!_versionNumLabel) {
        
        _versionNumLabel=[[UILabel alloc] init];
        
        _versionNumLabel.font=WLFontSize(18.0);
        
        _versionNumLabel.text=@"";
        
        _versionNumLabel.textColor=[WLTools stringToColor:@"#303030"];
        
        [self.mainView addSubview:_versionNumLabel];
        
        [_versionNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.mainView.mas_right).offset(-15);
            
            make.top.equalTo(self.versionIMV.mas_bottom).offset(15);
            
        }];
        _versionNumLabel.hidden = YES;
      
    }
    return _versionNumLabel;
}

#pragma mark - 提示语
-(UITextView *)msgTextView
{
    if (_msgTextView==nil)
    {
        _msgTextView=[[UITextView alloc] init];
        
        _msgTextView.text=@"";
        
        _msgTextView.font=WLFontSize(15.0);
        
        _msgTextView.textColor=[WLTools stringToColor:@"#656565"];
        
        _msgTextView.editable=NO;
        
        [self.mainView addSubview:_msgTextView];
        
        [_msgTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.titleLabel.mas_left).offset(-3);
            
            make.right.equalTo(self.mainView.mas_right).offset(-25);
            
            make.top.equalTo(self.titleLabel.mas_bottom).offset(18);
            
            make.bottom.equalTo(self.lineView.mas_top);
        }];
    }
    
    return _msgTextView;
}

#pragma mark - 取消按钮
-(UIButton *)cancelButton
{
    if (_cancelButton==nil)
    {
        UIImage *image=[UIImage imageNamed:@"bfex_version_bg1"];
        
        _cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_cancelButton setTitle:SSKJLocalized(@"跳过更新", nil) forState:UIControlStateNormal];
        
        [_cancelButton setTitleColor:[WLTools stringToColor:@"#a4a4a4"] forState:UIControlStateNormal];
        
        _cancelButton.titleLabel.font=WLFontSize(14.0);
        
        [_cancelButton setBackgroundColor:[UIColor whiteColor]];
        
        [_cancelButton addTarget:self action:@selector(cancelButton_Event:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.mainView addSubview:_cancelButton];
        
        [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mainView.mas_left);
            
            make.bottom.equalTo(self.mainView.mas_bottom);
            
            make.width.equalTo(@((image.size.width)/2));
            
            make.height.equalTo(@50);
        }];
    }
    
    return _cancelButton;
}

#pragma mark - 确认
-(UIButton *)sureButton
{
    if (_sureButton==nil)
    {
        _sureButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_sureButton setTitle:SSKJLocalized(@"立即升级", nil) forState:UIControlStateNormal];
        
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _sureButton.titleLabel.font=WLFontSize(14.0);
        
        [_sureButton setBackgroundColor:[WLTools stringToColor:@"#e83030"]];
        
        [_sureButton addTarget:self action:@selector(sureButton_Event:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.mainView addSubview:_sureButton];
        
        [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.cancelButton.mas_right);
            
            make.right.equalTo(self.mainView.mas_right);
            
            make.top.equalTo(self.cancelButton.mas_top);
            
            make.width.equalTo(self.cancelButton.mas_width);
            
            make.bottom.equalTo(self.cancelButton.mas_bottom);
        }];
        
    }
    
    return _sureButton;
}




#pragma mark - 设置显示/隐藏
- (void)hide:(BOOL)hidden
{
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.3;
    
    animation.type = kCATransitionFade;
    
    [self.layer addAnimation:animation forKey:nil];
    
    self.hidden = hidden;
}

#pragma mark - 取消按钮 点击事件
-(void)cancelButton_Event:(UIButton *)sender
{
    [self hide:YES];
}

#pragma mark - 确认按钮 点击事件
-(void)sureButton_Event:(UIButton *)sender
{
    if (self.sureButtonBlock)
    {
        self.sureButtonBlock();
    }
}

#pragma mark - 标题和内容复制
-(void)initWithTitle:(NSString *)title andMessage:(NSString *)message version:(NSString *)version
{
    self.titleLabel.text=title;
    
    self.versionNumLabel.text = version;
    self.msgTextView.text=message;
    
}
@end
