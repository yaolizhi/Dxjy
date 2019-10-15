//
//  NSString+TextSize.m
//  CollectionViewTest
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NSString+TextSize.h"

@implementation NSString (TextSize)
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
        NSDictionary *attrs = @{NSFontAttributeName : font};
        return [self boundingRectWithSize:maxSize
                                  options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                               attributes:attrs
                                  context:nil].size;
    
}
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize paragraphStyle:(NSMutableParagraphStyle*)paragraphStyle {
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    return [self boundingRectWithSize:maxSize
                              options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                           attributes:dic
                              context:nil].size;
}
@end
