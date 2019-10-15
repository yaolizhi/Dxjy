//
//  CCEJActionSheet.h
//  JiaTianXia
//
//  Created by 张超 on 16/5/18.
//  Copyright © 2016年 Earloye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActionSheet;

@protocol ActionSheetDelegate <NSObject>

@optional

/**
 *  点击按钮
 */
- (void)actionSheet:(ActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface ActionSheet : UIView

/**
 *  代理
 */
@property (nonatomic, weak) id <ActionSheetDelegate> delegate;

/**
 *  创建对象方法
 */
- (instancetype)initWithDelegate:(id<ActionSheetDelegate>)delegate CancelTitle:(NSString *)cancelTitle addTitleLabel:(BOOL)titleLabel  OtherTitles:(NSString*)otherTitles,... NS_REQUIRES_NIL_TERMINATION;

- (void)show;

@end
