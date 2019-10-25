//
//  GE_Trading_Sell_Cell.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Trading_Sell_Cell.h"

#import "GE_Trading_ChooseGoods_View.h"

#import "GE_Login_ViewController.h"

@interface GE_Trading_Sell_Cell()<UITextFieldDelegate>
@property (nonatomic,strong) UILabel * coinnameLabel;//股票名称
@property (nonatomic,strong) UIView * lineView;
//最新价
@property (nonatomic,strong) UILabel * nowPriceTitle;
@property (nonatomic,strong) UILabel * nowPriceLabel;
//价格
@property (nonatomic,strong) UIView * priceBgView;
@property (nonatomic,strong) UITextField * priceTextField;
@property (nonatomic,strong) UILabel * priceTitle;
//数量
@property (nonatomic,strong) UIView * numberBgView;
@property (nonatomic,strong) UITextField * numberTextField;
@property (nonatomic,strong) UILabel * numberTitle;
@property (nonatomic,strong) UIButton *jiaBtn;
@property (nonatomic,strong) UIButton *jianBtn;

//保证金
@property (nonatomic,strong) UIView * baozhengjinView;
@property (nonatomic,strong) UILabel * baozhengjinLabel;
@property (nonatomic,strong) UILabel * baozhengjinTitle;
@property (nonatomic,strong) UILabel * gangganTitle;
//交易额
@property (nonatomic,strong) UILabel * totalPriceTitle;
@property (nonatomic,strong) UILabel * totalPriceLabel;
//提交Btn
@property (nonatomic,strong) UIButton *sureBtn;

@property(nonatomic,assign)BOOL isHaveDian;//判断是否有小数

@property (nonatomic,assign) NSInteger isShiOrXian;//0市价  1限价

//购买数量
@property (nonatomic, assign) NSInteger number;

@property (nonatomic,strong) GE_Trading_OneStock_Model *oneStockModel1;//单只股票详情


@end
@implementation GE_Trading_Sell_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = kMainWihteColor;
        
        [self setUIConfig];
        
        self.isShiOrXian = 0;
        
        self.number = 1;
    }
    return self;
}

- (void)setUIConfig
{
    [self coinnameLabel];
    [self lineView];
    
    [self nowPriceTitle];
    [self nowPriceLabel];
    
    [self priceBgView];
    [self priceTextField];
    [self priceTitle];
    
    [self numberBgView];
    [self jianBtn];
    [self jiaBtn];
    [self numberTextField];
    [self numberTitle];
    
    [self baozhengjinView];
    [self baozhengjinTitle];
    [self baozhengjinLabel];
    [self gangganTitle];
    
    [self totalPriceLabel];
    [self totalPriceTitle];
    
    [self sureBtn];
    
    //直接计算
    [self currentMoney];
}

- (UILabel *)coinnameLabel{
    if (_coinnameLabel == nil) {
        _coinnameLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"----" textColor:kMainBlackColor font:WLFontBoldSize(16)];
        _coinnameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_coinnameLabel];
        [_coinnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(@0);
            make.height.equalTo(@50);
        }];
    }
    return _coinnameLabel;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [FactoryUI createViewWithFrame:CGRectZero Color:LineGrayColor];
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(self.coinnameLabel.mas_bottom);
            make.height.equalTo(@(1));
        }];
    }
    return _lineView;
}

- (UILabel *)nowPriceTitle{
    if (_nowPriceTitle == nil) {
        _nowPriceTitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"最新价" textColor:kMainBlackColor font:systemFont(15)];
        [self.contentView addSubview:_nowPriceTitle];
        [_nowPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(self.lineView.mas_bottom).offset(20);
            make.height.equalTo(@15);
        }];
    }
    return _nowPriceTitle;
}

- (UILabel *)nowPriceLabel{
    if (_nowPriceLabel == nil) {
        _nowPriceLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"----" textColor:GREEN_HEX_COLOR font:systemFont(15)];
        [self.contentView addSubview:_nowPriceLabel];
        [_nowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-15));
            make.top.equalTo(self.lineView.mas_bottom).offset(20);
            make.height.equalTo(@15);
        }];
    }
    return _nowPriceLabel;
}

- (UIView *)priceBgView{
    if (_priceBgView == nil) {
        _priceBgView = [FactoryUI createViewWithFrame:CGRectZero Color:UIColorFromRGB(0xF5F5F5)];
        _priceBgView.layer.borderColor = UIColorFromRGB(0xF5F5F5).CGColor;
        _priceBgView.layer.borderWidth = 1;
        [self.contentView addSubview:_priceBgView];
        [_priceBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nowPriceTitle.mas_bottom).offset(20);
            make.right.equalTo(@(-15));
            make.height.equalTo(@40);
            make.left.equalTo(@80);
        }];
    }
    return _priceBgView;
}

- (UITextField *)priceTextField{
    if (_priceTextField == nil) {
        _priceTextField = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"以市场上最优价融券" placeHolder:@""];
        _priceTextField.textColor = kMainBlackColor;
        _priceTextField.font = systemFont(15);
        _priceTextField.delegate = self;
        _priceTextField.enabled = NO;
        _priceTextField.keyboardType = UIKeyboardTypeDecimalPad;
        [_priceTextField addTarget:self action:@selector(textFiedValueChanged:) forControlEvents:(UIControlEventEditingChanged)];
        [self.priceBgView addSubview:_priceTextField];
        [_priceTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(@0);
            make.left.equalTo(@10);
        }];
    }
    return _priceTextField;
}

- (UILabel *)priceTitle{
    if (_priceTitle == nil) {
        _priceTitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"价格" textColor:kMainBlackColor font:systemFont(15)];
        [self.contentView addSubview:_priceTitle];
        [_priceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(15));
            make.width.equalTo(@(60));
            make.centerY.equalTo(self.priceBgView.mas_centerY);
        }];
    }
    return _priceTitle;
}

- (UIView *)numberBgView{
    if (_numberBgView == nil) {
        _numberBgView = [FactoryUI createViewWithFrame:CGRectZero Color:UIColorFromRGB(0xF5F5F5)];
        _numberBgView.layer.borderColor = UIColorFromRGB(0xF5F5F5).CGColor;
        _numberBgView.layer.borderWidth = 1;
        [self.contentView addSubview:_numberBgView];
        [_numberBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.priceBgView.mas_bottom).offset(15);
            make.right.equalTo(@(-15));
            make.height.equalTo(@40);
            make.left.equalTo(@80);
        }];
    }
    return _numberBgView;
}

- (UIButton *)jianBtn{
    if (_jianBtn == nil) {
        _jianBtn = [FactoryUI createButtonWithFrame:CGRectZero title:@"-" titleColor:kMainBlackColor imageName:nil backgroundImageName:nil target:self selector:@selector(jianBtnAction) font:systemFont(30)];
        _jianBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _jianBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.numberBgView addSubview:_jianBtn];
        [_jianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@((ScreenWidth - 95) / 3 - 20));
            make.top.left.bottom.equalTo(@0);
        }];
    }
    return _jianBtn;
}

- (UIButton *)jiaBtn{
    if (_jiaBtn == nil) {
        _jiaBtn = [FactoryUI createButtonWithFrame:CGRectZero title:@"+" titleColor:kMainBlackColor imageName:nil backgroundImageName:nil target:self selector:@selector(jiaBtnAction) font:systemFont(30)];
        _jiaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _jiaBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.numberBgView addSubview:_jiaBtn];
        [_jiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@((ScreenWidth - 95) / 3 - 20));
            make.top.right.bottom.equalTo(@0);
        }];
    }
    return _jiaBtn;
}

- (UITextField *)numberTextField{
    if (_numberTextField == nil) {
        _numberTextField = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"1" placeHolder:@"请输入数量"];
        _numberTextField.backgroundColor = kMainWihteColor;
        _numberTextField.textAlignment = NSTextAlignmentCenter;
        _numberTextField.textColor = kMainBlackColor;
        _numberTextField.delegate = self;
        [_numberTextField addTarget:self action:@selector(textFiedValueChanged:) forControlEvents:(UIControlEventEditingChanged)];
        _numberTextField.font = systemFont(15);
        _numberTextField.keyboardType = UIKeyboardTypeDecimalPad;
        [self.numberBgView addSubview:_numberTextField];
        [_numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.left.equalTo(self.jianBtn.mas_right);
            make.right.equalTo(self.jiaBtn.mas_left);
        }];
    }
    return _numberTextField;
}

- (UILabel *)numberTitle{
    if (_numberTitle == nil) {
        _numberTitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"手数" textColor:kMainBlackColor font:systemFont(15)];
        [self.contentView addSubview:_numberTitle];
        [_numberTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(15));
            make.width.equalTo(@(60));
            make.centerY.equalTo(self.numberBgView.mas_centerY);
        }];
    }
    return _numberTitle;
}
- (UIView *)baozhengjinView{
    if (_baozhengjinView == nil) {
        _baozhengjinView = [FactoryUI createViewWithFrame:CGRectZero Color:kMainWihteColor];
        _baozhengjinView.layer.borderColor = LineGrayColor.CGColor;
        _baozhengjinView.layer.borderWidth = 1;
        [self.contentView addSubview:_baozhengjinView];
        [_baozhengjinView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.numberBgView.mas_bottom).offset(15);
            make.right.equalTo(@(-15));
            make.height.equalTo(@40);
            make.left.equalTo(@80);
        }];
    }
    return _baozhengjinView;
}

- (UILabel *)baozhengjinLabel{
    if (_baozhengjinLabel == nil) {
        _baozhengjinLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"0.00" textColor:kMainBlackColor font:systemFont(15)];
        [self.baozhengjinView addSubview:_baozhengjinLabel];
        [_baozhengjinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(@0);
            make.left.equalTo(@10);
        }];
    }
    return _baozhengjinLabel;
}

- (UILabel *)gangganTitle{
    if (_gangganTitle == nil) {
        _gangganTitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"10倍杠杆" textColor:kMainBlackColor font:systemFont(15)];
        _gangganTitle.hidden = YES;
        [self.baozhengjinView addSubview:_gangganTitle];
        [_gangganTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(@0);
            make.right.equalTo(@(-5));
        }];
    }
    return _gangganTitle;
}

- (UILabel *)baozhengjinTitle{
    if (_baozhengjinTitle == nil) {
        _baozhengjinTitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"保证金" textColor:kMainBlackColor font:systemFont(15)];
        [self.contentView addSubview:_baozhengjinTitle];
        [_baozhengjinTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(15));
            make.width.equalTo(@(60));
            make.centerY.equalTo(self.baozhengjinView.mas_centerY);
        }];
    }
    return _baozhengjinTitle;
}

- (UILabel *)totalPriceTitle{
    if (_totalPriceTitle == nil) {
        _totalPriceTitle = [FactoryUI createLabelWithFrame:CGRectZero text:@"综合服务费" textColor:kMainBlackColor font:systemFont(15)];
        [_totalPriceTitle setHidden:YES];
        [self.contentView addSubview:_totalPriceTitle];
        [_totalPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(self.baozhengjinView.mas_bottom).offset(15);
            make.height.equalTo(@40);
        }];
    }
    return _totalPriceTitle;
}

- (UILabel *)totalPriceLabel{
    if (_totalPriceLabel == nil) {
        _totalPriceLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"----" textColor:RED_HEX_COLOR font:systemFont(18)];
        [_totalPriceLabel setHighlighted:YES];
        [self.contentView addSubview:_totalPriceLabel];
        [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-15));
            make.top.equalTo(self.baozhengjinView.mas_bottom).offset(15);
            make.height.equalTo(@40);
        }];
    }
    return _totalPriceLabel;
}

- (UIButton *)sureBtn{
    if (_sureBtn == nil) {
        _sureBtn = [FactoryUI createButtonWithFrame:CGRectZero title:@"做空" titleColor:kMainWihteColor imageName:nil backgroundImageName:nil target:self selector:@selector(sureBtnAction) font:systemFont(15)];
        _sureBtn.backgroundColor = GREEN_HEX_COLOR;
        _sureBtn.layer.cornerRadius = 5;
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _sureBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_sureBtn];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(self.totalPriceLabel.mas_bottom).offset(30);
            make.right.equalTo(@(-15));
            make.height.equalTo(@(45));
        }];
    }
    return _sureBtn;
}

//减
- (void)jianBtnAction
{
    if (self.number <= 1) {
        return;
    }
    
    self.number = self.number - 1;
    
    self.numberTextField.text = [NSString stringWithFormat:@"%ld",self.number];
    
    [self currentMoney];
}
//加
- (void)jiaBtnAction
{
    
    self.number = self.number + 1;
    
    self.numberTextField.text = [NSString stringWithFormat:@"%ld",self.number];
    
    [self currentMoney];
}

#pragma mark -- 数据获取 ---
- (void)setPrice:(NSString *)price
{
    self.nowPriceLabel.text = [WLTools noroundingStringWith:price.doubleValue afterPointNumber:6];
    
    [self currentMoney];
}

- (void)setChangeRate:(NSString *)changeRate
{
    if ([changeRate containsString:@"-"]) {
        
        self.nowPriceLabel.textColor = GREEN_HEX_COLOR;
    }
    else
    {
        self.nowPriceLabel.textColor = RED_HEX_COLOR;
    }
}

- (void)setOneStockModel:(GE_Trading_OneStock_Model *)oneStockModel
{
    self.coinnameLabel.text = oneStockModel.name.length == 0 ? @"----" : [NSString stringWithFormat:@"%@/%@",oneStockModel.name,oneStockModel.code];
    
    self.oneStockModel1 = oneStockModel;
    
    self.gangganTitle.text = [NSString stringWithFormat:@"%@倍杠杆",oneStockModel.leverage_rz];
    
    
    if ([oneStockModel.changeRate containsString:@"-"]) {
        
        self.nowPriceLabel.textColor = GREEN_HEX_COLOR;
    }
    else
    {
        self.nowPriceLabel.textColor = RED_HEX_COLOR;
    }
    
//    self.nowPriceLabel.text = oneStockModel.price.length == 0 ? @"----" : [WLTools noroundingStringWith:oneStockModel.price.doubleValue afterPointNumber:6];
    self.nowPriceLabel.text = oneStockModel.price.length == 0 ? @"----" : [NSString stringWithFormat:@"%.2f",oneStockModel.price.doubleValue];
    
    //直接计算
    [self currentMoney];
    
    
}

#pragma mark -- 计算下单价 ---
-(void)currentMoney
{
    double amount;
    
    //购买数量  手数*每手多少股
    double buyNum = self.numberTextField.text.integerValue * self.oneStockModel1.shares.doubleValue;
    
    //手购买数量*现价/杠杆
    amount = buyNum*self.nowPriceLabel.text.doubleValue*self.oneStockModel1.leverage_rj.doubleValue;
    //综合服务费
    double fee = buyNum*self.nowPriceLabel.text.doubleValue*self.oneStockModel1.trans_fee.doubleValue / 100;
    
    if (self.oneStockModel1.name.length > 0) {
        self.baozhengjinLabel.text = [NSString stringWithFormat:@"%.2f",amount];
//        [WLTools noZero:amount afterPoint:6];
        
        self.totalPriceLabel.text = [NSString stringWithFormat:@"%.2f",fee];
    }
}

#pragma mark --—— 下单 -----
- (void)sureBtnAction
{
    if ([kLogined integerValue] != 1) {
        
        GE_Login_ViewController * loginvc = [[GE_Login_ViewController alloc]init];
        
        [self.vc.navigationController pushViewController:loginvc animated:YES];
        
        [MBProgressHUD showError:@"请先登录！"];
        
        return;
    }
    
    if (self.priceTextField.text.length == 0) {
        
        [MBProgressHUD showError:@"请输入价格"];
        
        return;
    }
    if ([self.numberTextField.text integerValue] == 0) {
        
        [MBProgressHUD showError:@"请输入数量"];
        
        return;
    }
    
    if ([self.numberTextField.text integerValue] < self.oneStockModel1.num_min.integerValue) {
        
        [MBProgressHUD showError:[NSString stringWithFormat:@"最小购买数量为%@",self.oneStockModel1.num_min]];
        
        return;
    }
    
    
    
    
    
    if (self.SellOrderBlock) {
        
        NSDictionary *dic = @{@"otype":@"2",
                              @"buynum":self.numberTextField.text,
                              @"shopname":self.oneStockModel1.code,
                              @"code":self.oneStockModel1.name,
                              @"price":self.nowPriceLabel.text
                              };
        
        
        self.SellOrderBlock(dic);
        
        if (self.isShiOrXian == 1) {
            self.priceTextField.text = @"";
        }
        self.numberTextField.text = @"1";
        
       
    }
}

#pragma mark -- 价格或数量发生变化时的监听事件 --
-(void)textFiedValueChanged:(UITextField *)textFlied{
    
    if ([self.priceTextField isFirstResponder]) {
        [self currentMoney];
    }
    
    if ([self.numberTextField isFirstResponder]) {
        
        if (self.numberTextField.text.integerValue < 0) {
            
            [MBProgressHUD showError:@"数量不能小于1"];
            
            self.numberTextField.text = @"1";
        }
        
        self.number = self.numberTextField.text.integerValue;
        
        [self currentMoney];
    }
    
}
#pragma mark--- 输入控制 ---
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0)
    {
        return YES;
    }
    if ([textField.text rangeOfString:@"."].location == NSNotFound){
        _isHaveDian = NO;
    }
    
    if ([string length] > 0) {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.'){
            //输入的字符是否是小数点
            if (single == '.'){
                if(!_isHaveDian)//text中还没有小数点
                {
                    _isHaveDian = YES;
                    
                    return YES;
                }else{
                    [MBProgressHUD showError:SSKJLocalized(@"您已经输入过小数点了", nil)];
                    
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                
                if (_isHaveDian)
                {    //存在小数点
                    if (textField==self.priceTextField) //法币计价
                    {
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 4){
                            return YES;
                        }else{
                            [MBProgressHUD showError:SSKJLocalized(@"您最多输入四位小数", nil)];
                            return NO;
                        }
                        
                    }
                    if (textField == self.priceTextField) {
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 4){
                            return YES;
                        }else{
                            [MBProgressHUD showError:SSKJLocalized(@"您最多输入四位小数", nil)];
                            return NO;
                        }
                    }
                }
                else
                {
                    return YES;
                }
            }
        }
        else
        {    //输入的数据格式不正确
            
            [MBProgressHUD showError:SSKJLocalized(@"您输入的格式不正确", nil)];
            
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            
            return NO;
        }
    }
    else
    {
        return YES;
    }
    return YES;
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
