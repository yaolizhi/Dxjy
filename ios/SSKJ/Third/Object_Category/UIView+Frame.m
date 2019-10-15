//
//  UIView+Frame.m
//  
//
//  Created by 朴文一 on 15/9/4.
//  Copyright © 2015年 朴文一. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setX:(CGFloat)x{
    CGFloat y = self.frame.origin.y;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.frame = CGRectMake(x, y, width, height);
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGFloat x = self.frame.origin.x;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.frame = CGRectMake(x, y, width, height);
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    CGFloat height = self.frame.size.height;
    self.frame = CGRectMake(x, y, width, height);
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGFloat x = self.frame.origin.x;
    CGFloat width = self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    self.frame = CGRectMake(x, y, width, height);
}

- (CGFloat)height{
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size
{
    return self.frame.size;
}

-(CGFloat)centerx
{
    return self.center.x;
}

-(void)setCenterx:(CGFloat)centerx
{
    CGPoint center = self.center;
    center.x = centerx;
    self.center = center;
}

-(CGFloat)centery
{
    return self.center.y;
}

-(void)setCentery:(CGFloat)centery
{
    CGPoint center = self.center;
    center.y = centery;
    self.center = center;
}

-(void)setBottom:(CGFloat)bottom
{
    self.y = bottom - self.height;
}

-(CGFloat)bottom
{
    return self.y + self.height;
}

-(CGFloat)right
{
    return self.x + self.width;
}
@end
