//
//  PublicDefine.h
//  SSKJ
//
//  Created by James on 2018/6/14.
//  Copyright © 2018年 James. All rights reserved.
//

static NSString * const AppLanguage = @"appLanguage";

// 语言国际化
#define SSKJLocalized(key, comment) [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:AppLanguage]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:nil]


