//
//  DeviceDefine.h
//  SSKJ
//
//  Created by James on 2018/6/13.
//  Copyright © 2018年 James. All rights reserved.
//
//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

// 判断是否是iPhoneX系列
#define IS_IPHONE_X_ALL (IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES)

//iPhoneX系列
#define Height_StatusBar ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 44.0 : 20.0)
#define Height_NavBar ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 88.0 : 64.0)
#define Height_TabBar ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 83.0 : 49.0)


//判断是否为iPhone4
#define iPhone4s ([[UIScreen mainScreen] bounds].size.height == 480.0f)
//判断是否为iPhone5
#define iPhone5s ([[UIScreen mainScreen] bounds].size.height > 480.0f && [[UIScreen mainScreen] bounds].size.height <= 568.0f)
//判断是否为iPhone6
#define iPhone6s ([[UIScreen mainScreen] bounds].size.height > 568.0f && [[UIScreen mainScreen] bounds].size.height <= 667.0f)
//判断是否为iPhone6S
#define iPhone6s_plus ([[UIScreen mainScreen] bounds].size.height > 667.0f && [[UIScreen mainScreen] bounds].size.height <= 736.0f)
//判断是否为iPhoneX
//判断是否为iPhone6S
#define iPhoneX ([[UIScreen mainScreen] bounds].size.height > 736.0f && [[UIScreen mainScreen] bounds].size.height <= 812.0f)

#define IsiPad          (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define IsiPhone        (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IsRetain        ([[UIScreen mainScreen] scale] >= 2.0)

#define IsiPhone4       (IsiPhone && ScreenMaxLength < 568.0)

#define IsiPhone5       (IsiPhone && ScreenMaxLength == 568.0)

#define IsiPhone6       (IsiPhone && ScreenMaxLength == 667.0)

#define IsiPhone6P      (IsiPhone && ScreenMaxLength == 736.0)

#define IsiPhoneX       (IsiPhone && ScreenMaxLength == 812.0)

#define kBottomSpace   (IsiPhoneX ? 34:0)


//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif
