//
//  Market_Index_Top_Cell.h
//  ZYW_MIT
//
//  Created by James on 2018/8/22.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDCycleScrollView.h"

#import "LMJScrollTextView2.h"


#import "GE_Market_Banner_Model.h"

#import "GE_Market_Notice_Model.h"

@interface Market_Index_Top_Cell : UITableViewCell<SDCycleScrollViewDelegate,LMJScrollTextView2Delegate>

@property(nonatomic,strong)UIView *topLineView;

@property(nonatomic,strong)UIView *bottomLineView;

@property(nonatomic,strong)SDCycleScrollView *headerView;

@property(nonatomic,strong)UIView *noticeView;

@property(nonatomic,strong)UIImageView *logoIMV;

@property(nonatomic,strong)UIButton *gonggaoBtn;

@property(nonatomic,strong)UIButton *gonggaoDetailBtn;

@property(nonatomic,strong)UIButton *gonggaomoreBtn;

@property(nonatomic,strong)UIView *verLineView;

@property(nonatomic,strong)LMJScrollTextView2 *scrollTextView;

@property(nonatomic,strong)UIView *spaceView;

@property(nonatomic,strong)NSMutableArray *sliderArray;

@property(nonatomic,strong)NSMutableArray *gonggaoArray;

@property(nonatomic,strong)NSMutableArray *bannerArray;
//
@property(nonatomic,strong)NSMutableArray *noticeArray;

@property(nonatomic,copy)void (^bannerClickBlock)(NSInteger index);

@property(nonatomic,copy)void (^noticeClickBlock)(NSInteger index);

//-(void)initWithCellBannerArray:(NSMutableArray<Market_Index_Banner_Model *> *)bannerArray andNoticeArray:(NSMutableArray<Market_Index_Notice_Model *> *)noticeArray;

@end
