//
//  Market_Search_Cell.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/5/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Market_Search_Cell.h"

@implementation Market_Search_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self namelabel];
        [self codeabel];
        [self addBtn];
        [self lineview];
    }
    return self;
}
- (UILabel *)namelabel{
    if (_namelabel == nil) {
        _namelabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"美黄金", nil) textColor:kMainBlackColor font:systemFont(ScaleW(15))];
        [self.contentView addSubview:_namelabel];
        [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(15)));
            make.top.bottom.equalTo(@0);
        }];
    }
    return _namelabel;
}

- (UILabel *)codeabel{
    if (_codeabel == nil) {
        _codeabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"GLNC", nil) textColor:kMainDarkBlackColor font:systemFont(ScaleW(15))];
        [self.contentView addSubview:_codeabel];
        [_codeabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.namelabel.mas_right).offset(ScaleW(15));
            make.top.bottom.equalTo(@0);
        }];
    }
    return _codeabel;
}

- (UIButton *)addBtn{
    if (_addBtn == nil) {
        _addBtn = [FactoryUI createButtonWithFrame:CGRectZero title:SSKJLocalized(@"  添加自选", nil) titleColor:kMainColor imageName:@"Market_add_coin" backgroundImageName:nil target:self selector:@selector(addbtnAction) font:systemFont(15)];
        [self.contentView addSubview:_addBtn];
        [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(ScaleW(-15)));
            make.top.bottom.equalTo(@0);
        }];
    }
    return _addBtn;
}

- (UIView *)lineview{
    if (_lineview == nil) {
        _lineview = [FactoryUI createViewWithFrame:CGRectZero Color:LineGrayColor];
        [self.contentView addSubview:_lineview];
        [_lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.height.equalTo(@(ScaleW(1)));
        }];
    }
    return _lineview;
}

- (void)addbtnAction{
    if (self.AddZiXuanBlock) {
        self.AddZiXuanBlock(self.model);
    }
}

- (void)initDataWithModel:(Market_Search_Model *)model index:(NSInteger)index{
    
    self.model = model;
    
    if (index == 1) {
        self.addBtn.hidden = NO;
    }else{
        self.addBtn.hidden = YES;
    }
    self.namelabel.text = model.pname;
    self.codeabel.text = model.code;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
