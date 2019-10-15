//
//  ColorDefine.h
//  SSKJ
//
//  Created by James on 2018/6/13.
//  Copyright © 2018年 James. All rights reserved.
//

//#import "UIColor+Hex.h"

//颜色
#define WLColor(r,g,b,a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:a]

//由十六进制转换成是十进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define RGBCOLOR16(rgbValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]



// 导航栏title颜色
#define kNavigationTitleColor  UIColorFromRGB(0xffffff)

// 主背景色
#define kMainBackgroundColor UIColorFromRGB(0xF5F5F5)

// 纯白色
#define kMainWihteColor UIColorFromRGB(0xffffff)

// 灰色分割线色
#define LineGrayColor  UIColorFromRGB(0xF5F5F5)

// 纯黑色
#define kMainBlackColor UIColorFromRGB(0x333333)

// 半黑色
#define kMainDarkBlackColor UIColorFromRGB(0x666666)

// 灰色字体
#define kMainGrayColor UIColorFromRGB(0x999999)

// 主题色
#define kMainColor UIColorFromRGB(0xe83030)


#define CharBlueColor RGBCOLOR(83,107,142)

// K线图颜色
// 红色
//#define RED_HEX_COLOR UIColorFromRGB(0xe96d42)
#define RED_HEX_COLOR UIColorFromRGB(0xe83030)

// 黄色
#define YELLOW_HEX_COLOR UIColorFromRGB(0xffff00)

// 绿色
#define GREEN_HEX_COLOR UIColorFromRGB(0x08be88)



#define ChartBColor UIColorFromRGB(0x141724)
