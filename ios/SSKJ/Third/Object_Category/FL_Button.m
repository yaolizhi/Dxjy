//
//  FL_Button.m
//
//  Created by 孔凡列 on 15/12/10.
//  Copyright © 2015年 czebd. All rights reserved.
//

#import "FL_Button.h"

@implementation FL_Button

+ (instancetype)fl_shareButton{
    return [[self alloc] init];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.titleLabel.text && self.imageView.image)
    {
        CGFloat marginH = (self.frame.size.height - self.imageView.frame.size.height - self.titleLabel.frame.size.height)/3;
        
        //图片
        CGPoint imageCenter = self.imageView.center;
        imageCenter.x = self.frame.size.width/2;
        imageCenter.y = self.imageView.frame.size.height/2 + marginH;
        self.imageView.center = imageCenter;
        //文字
        CGRect newFrame = self.titleLabel.frame;
        newFrame.origin.x = 0;
        newFrame.origin.y = self.frame.size.height - newFrame.size.height - marginH;
        newFrame.size.width = self.frame.size.width;
        self.titleLabel.frame = newFrame;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}




@end
