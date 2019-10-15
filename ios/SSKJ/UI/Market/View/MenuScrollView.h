//
//  WJBSM_SearchOrderController.h
//  WJCloudsLiveVideo
//
//  Created by GT on 2017/3/10.
//  Copyright © 2017年 tencent. All rights reserved.
//
/***************************************
 ClassName： MenuScrollView
 Created_Date： 20170310
 Created_People： GT
 Function_description： 自定义menuScrollView
 ***************************************/

#import <UIKit/UIKit.h>
@class MenuScrollView;
@protocol MenuScrollViewDelegate <NSObject>
- (void)menuScrollView:(MenuScrollView*)menuScrollView didSelectedMenuItemAtIndex:(NSInteger)index;
@end
@interface MenuScrollView : UIScrollView

@property(nonatomic ,unsafe_unretained)id<MenuScrollViewDelegate>menuScrollDelegate;
/**   外部改变菜单索引  */
@property(nonatomic) NSInteger selectIndex;
/**  菜单按钮背景颜色属性  */
@property (nonatomic, strong) UIColor *tabBackgroundColor;
@property (nonatomic, strong) UIColor *tabSelectedBackgroundColor;

/**  菜单按钮背景图片属性  */
@property (nonatomic, strong) UIImage *tabBackgroundImage;
@property (nonatomic, strong) UIImage *tabSelectedBackgroundImage;

/**  菜单按钮的标题颜色属性   */
@property (nonatomic, strong) UIColor *tabTitleColor;
@property (nonatomic, strong) UIColor *tabSelectedTitleColor;

/**  是否显示垂直分割线  默认显示 */
@property (nonatomic, assign) BOOL showVerticalLine;

/**  垂直分割线颜色  */
@property (nonatomic, assign) UIColor *verticalLineColor;

/**  垂直分割线背景图片  */
@property (nonatomic, assign) UIImage *verticalLineImage;

/**  是否显示底部横线  默认显示  */
@property (nonatomic, assign) BOOL showBottomLine;

/**  底部横线颜色  */
@property (nonatomic, assign) UIColor *bottomLineColor;

/**  底部横线背景图片  */
@property (nonatomic, assign) UIImage *bottomLineImage;

@property (nonatomic, copy) void (^klineAccessoryBlock)(void);


//初始化方法
- (id)initWithFrame:(CGRect)frame titles:(NSArray*)titles dataScrollView:(UIScrollView *)scrollView;
- (id)initWithFrame:(CGRect)frame attributes:(NSDictionary*)attributes dataScrollView:(UIScrollView *)scrollView;

@end
