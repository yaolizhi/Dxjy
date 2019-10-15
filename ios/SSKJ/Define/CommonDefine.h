//
//  CommonDefine.h
//  SSKJ
//
//  Created by James on 2018/6/13.
//  Copyright © 2018年 James. All rights reserved.
//

//weakSelf
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self


//写
#define SSKJUserDefaultsSET(object,key) [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]

// 取
#define SSKJUserDefaultsGET(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

// 删
#define SSKJUserDefaultsRemove(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]

// 存
#define SSKJUserDefaultsSynchronize [[NSUserDefaults standardUserDefaults] synchronize]



