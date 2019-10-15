//
//  Mine_RealName_Card_View.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/5/17.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ActionSheet.h"

NS_ASSUME_NONNULL_BEGIN

@interface Mine_RealName_Card_View : UIView<ActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIViewController *vc;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIImageView * zhengmianImg;

@property (nonatomic,strong) UILabel *zhengmianLabel;

@property (nonatomic,strong) UIImageView * fanmianImg;

@property (nonatomic,strong) UILabel *fanmianLabel;

@property (nonatomic, copy) UIImage *zhengImage;

@property (nonatomic, copy) UIImage *fanImage;

@property (nonatomic,assign) NSInteger index;//1正面 2反面
@end

NS_ASSUME_NONNULL_END
