//
//  GE_ZiXun_HangYeCell.m
//  SSKJ
//
//  Created by 张超 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_ZiXun_HangYeCell.h"
#import <UIImageView+WebCache.h>

@implementation GE_ZiXun_HangYeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.detailsLabel.font = [UIFont systemFontOfSize:ScaleW(15)];
    self.pingLunLabel.font = [UIFont systemFontOfSize:ScaleW(11)];
    self.timeLabel.font = [UIFont systemFontOfSize:ScaleW(11)];
    
}

- (void)initWithModel:(NSDictionary *)model type:(NSInteger)type
{
    if (type == 1) {
        //行业资讯
        self.detailsLabel.text = model[@"title"];
        self.pingLunLabel.text = model[@"Art_Media_Name"];
        self.timeLabel.text = model[@"showtime"];
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:model[@"image"]] placeholderImage:[UIImage imageNamed:@"GE_ZiXun_defaultPic"]];
        
    }else if (type == 2){
        //平台新闻
        self.detailsLabel.text = model[@"title"];
        self.pingLunLabel.text = model[@"source"];
        self.timeLabel.text = model[@"create_time"];
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ProductBaseServer,model[@"imgCover"]]] placeholderImage:[UIImage imageNamed:@"GE_ZiXun_defaultPic"]];
    }
}

@end
