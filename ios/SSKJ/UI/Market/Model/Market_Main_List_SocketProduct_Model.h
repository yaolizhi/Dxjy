//
//  Market_Main_List_SocketProduct_Model.h
//  ZYW_MIT
//
//  Created by James on 2018/8/1.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Market_Main_List_SocketProduct_Model : NSObject

@property(nonatomic,copy)NSString *code;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *price;

@property(nonatomic,copy)NSString *openPrice;

@property(nonatomic,copy)NSString *closePrice;

@property(nonatomic,copy)NSString *high;

@property(nonatomic,copy)NSString *low;

@property(nonatomic,copy)NSString *prevClose;

@property(nonatomic,copy)NSString *change;

@property(nonatomic,copy)NSString *changeRate;

@property(nonatomic,copy)NSString *buy;

@property(nonatomic,copy)NSString *sell;

@property(nonatomic,copy)NSString *cnyPrice;

@property (nonatomic, strong) NSString *isSocket;



@end
