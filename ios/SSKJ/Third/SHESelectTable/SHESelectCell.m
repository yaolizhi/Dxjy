//
//  SHESelectCell.m
//  breeder
//
//  Created by xxx on 2017/11/21.
//  Copyright © 2017年 xxx. All rights reserved.
//

#import "SHESelectCell.h"

@implementation SHESelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         self.selectionStyle=UITableViewCellSelectionStyleNone;
        //颜色要修改
        self.backgroundColor = kMainBackgroundColor;
        
        CGFloat selfWidth=self.frame.size.width;
        _leftLab=[[UILabel alloc]initWithFrame:CGRectMake(6, 0, selfWidth, self.frame.size.height)];
        _leftLab.textAlignment=NSTextAlignmentLeft;
        _leftLab.font=[UIFont systemFontOfSize:15];
        //颜色要修改
        _leftLab.textColor = kMainBlackColor;
        
        [self addSubview:_leftLab];
        
        _selectBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-6-selfWidth*1/4, 0, selfWidth, self.frame.size.height)];
        [_selectBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _selectBtn.userInteractionEnabled=NO;
        _selectBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        [self addSubview:_selectBtn];
        
        //颜色要修改
         [self creatLineWithCGRect:CGRectMake(0, 0, selfWidth, 1) withColor:kMainBackgroundColor withView:self];
        
        
        
    }
    return self;
}
-(UILabel *)creatLineWithCGRect:(CGRect)rect withColor:(UIColor *)color withView:(UIView *)view
{
    UILabel *line=[[UILabel alloc]initWithFrame:rect];
    line.backgroundColor=color;
    [view addSubview:line];
    return line;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
