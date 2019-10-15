//
//  UITextField+Space.m
//  MIT_Integrated
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UITextField+Space.h"
#import "UIColor+Hex.h"
#import "NSString+TextSize.h"
#define kHspace 10
@implementation UITextField (Space)
-(void)setDirection:(ShowDirection)direction edgeSpace:(CGFloat)space {
    UILabel *paddingView = [[UILabel alloc]init];
    paddingView.backgroundColor = [UIColor clearColor];
    switch (direction) {
        case 0:
        {
            [paddingView setFrame:CGRectMake(0, 0, space, self.bounds.size.height)];
            self.leftView = paddingView;
            self.leftViewMode = UITextFieldViewModeAlways;
        }
            break;
        case 1:
        {
            [paddingView setFrame:CGRectMake(self.bounds.size.width - space, 0, space
                                             , self.bounds.size.height)];
            self.rightView = paddingView;
            self.rightViewMode = UITextFieldViewModeAlways;
        }
            break;
        case 2:
            
            break;
        default:
            break;
    }
}
-(void)setDirection:(ShowDirection)direction placeImage:(UIImage*)image {
    UIButton *paddingView = [UIButton buttonWithType:UIButtonTypeCustom];
    paddingView.backgroundColor = [UIColor clearColor];
    paddingView.enabled = NO;
    [paddingView setImage:image forState:UIControlStateNormal];
    switch (direction) {
        case 0:
        {
            [paddingView setFrame:CGRectMake(0
                                             , 0
                                             ,2*kHspace + image.size.width
                                             , self.bounds.size.height)];
            self.leftView = paddingView;
            self.leftViewMode = UITextFieldViewModeAlways;
        }
            break;
        case 1:
        {
            [paddingView setFrame:CGRectMake(self.bounds.size.width - 2*kHspace - image.size.width
                                             , 0
                                             , 2*kHspace + image.size.width
                                             , self.bounds.size.height)];
            self.rightView = paddingView;
            self.rightViewMode = UITextFieldViewModeAlways;
        }
            break;
        case 2:
            
            break;
        default:
            break;
    }
}

-(void)setDirection:(ShowDirection)direction placeTitle:(NSString*)title {
    UILabel *paddingView = [[UILabel alloc]init];
    paddingView.backgroundColor = [UIColor clearColor];
    paddingView.text = title;
    paddingView.textColor = [UIColor colorWithHexString:@"#555555"];
    CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(300, 80)];
    switch (direction) {
        case 0:
        {
            [paddingView setFrame:CGRectMake(0, 0, titleSize.width, self.bounds.size.height)];
            self.leftView = paddingView;
            self.leftViewMode = UITextFieldViewModeAlways;
        }
            break;
        case 1:
        {
            [paddingView setFrame:CGRectMake(self.bounds.size.width - titleSize.width, 0, titleSize.width
                                             , self.bounds.size.height)];
            self.rightView = paddingView;
            self.rightViewMode = UITextFieldViewModeAlways;
        }
            break;
        case 2:
            
            break;
        default:
            break;
    }

}
-(void)setTextFieldSelectedBackGroundImage
{
    self.background = [UIImage imageNamed:@"ButAndSell_textFieldSelected"];
}
-(void)setTextFieldUnselectedBackGroundImage
{
    self.background = [UIImage imageNamed:@"BuyAndSell_textFieldUnSelected"];
}


@end
