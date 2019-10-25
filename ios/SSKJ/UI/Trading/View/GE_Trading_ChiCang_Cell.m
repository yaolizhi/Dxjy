//
//  GE_Trading_ChiCang_Cell.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Trading_ChiCang_Cell.h"
#import "GE_Trading_ChiCang_View.h"

@interface GE_Trading_ChiCang_Cell()
//做多做空 名字
@property(nonatomic,strong)UILabel *directionLable;
//时间
@property(nonatomic,strong)UILabel *dateLabel;
//买价
@property(nonatomic,strong)UILabel *positionLable;
//现价
@property(nonatomic,strong)UILabel *moneyLabel;
//持仓
@property(nonatomic,strong)UILabel *currentLable;
//可用
@property(nonatomic,strong)UILabel *ensureMoneyLabel;
//手续费
@property(nonatomic,strong)UILabel *sxFeeLabel;
//盈亏
@property(nonatomic,strong)UILabel *amountLable;
//保证金
@property(nonatomic,strong)UILabel *gyfeeLabel;
//过夜费
@property(nonatomic,strong)UILabel *label8;
//止盈
@property(nonatomic,strong)UILabel *label9;
//止损
@property(nonatomic,strong)UILabel *label10;


//平仓Btn
@property(nonatomic,strong)UIButton *sellBtn;

//平仓Btn
@property(nonatomic,strong)UIButton *setBtn;

// 编辑按钮
@property (nonatomic, strong) UIButton *editBtn;

//分割线
@property(nonatomic,strong)UIView *line;

// 按钮分割线
@property (nonatomic, strong) UIView *secondLine;

//数据
@property(nonatomic,strong)GE_Trading_ChiCang_Model *model;

//持仓or挂单
@property(nonatomic,assign)ChiCangTableViewCellStyle aStyle;

@property (nonatomic, strong) UIScrollView *backView;

@end

@implementation GE_Trading_ChiCang_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kMainWihteColor;
        [self setUIConfig];
    }
    return self;
}

//UIFrame设置
-(void)setUIConfig
{
    float width = (Screen_Width - 23 - 100)/2.f;
    
    //方向币种
    self.directionLable = [[UILabel alloc]initWithFrame:CGRectMake(23, 21, width, 16)];
    [self.contentView label:self.directionLable font:ScaleW(13) textColor:kMainGrayColor text:@"做空 BTC/USDT"];
    [self.contentView addSubview:self.directionLable];
    
    //时间
    self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width - 10 - width, 21, width, 12)];
    [self.contentView label:self.dateLabel font:ScaleW(13) textColor:kMainBlackColor text:@"12:11 04/24"];
    self.dateLabel.maxX = Screen_Width - 10;
    self.dateLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.dateLabel];
    
    //买价
    self.positionLable = [[UILabel alloc]initWithFrame:CGRectMake(23, 50, width, 13)];
    [self.contentView label:self.positionLable font:ScaleW(13) textColor:kMainBlackColor text:@"买价 601.24"];
    [self.contentView addSubview:self.positionLable];
    
    //限价
    self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.positionLable.maxX, 50, width, 13)];
    [self.contentView label:self.moneyLabel font:ScaleW(13) textColor:kMainBlackColor text:@"现价 601.24"];
    [self.contentView addSubview:self.moneyLabel];
    
    //持仓
    self.currentLable = [[UILabel alloc]initWithFrame:CGRectMake(23, 75, width, 13)];
    [self.contentView label:self.currentLable font:ScaleW(13) textColor:kMainBlackColor text:@"持仓 601.24"];
    [self.contentView addSubview:self.currentLable];
    
    //可用
    self.ensureMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.currentLable.maxX, 75, width, 13)];
    [self.contentView label:self.ensureMoneyLabel font:ScaleW(13) textColor:kMainBlackColor text:@"可用 601.24"];
    [self.contentView addSubview:self.ensureMoneyLabel];
    
    //手续费
    self.sxFeeLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, 100, width, 13)];
    [self.contentView label:self.sxFeeLabel font:ScaleW(13) textColor:kMainBlackColor text:@"手续费 601.24"];
    [self.contentView addSubview:self.sxFeeLabel];
    
    //盈亏
    self.amountLable = [[UILabel alloc]initWithFrame:CGRectMake(self.positionLable.maxX, 100, width, 13)];
    [self.contentView label:self.amountLable font:ScaleW(13) textColor:kMainBlackColor text:@"盈亏 601.24"];
    [self.contentView addSubview:self.amountLable];
    
    //保证金
    self.gyfeeLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, 125, width, 13)];
    [self.contentView label:self.gyfeeLabel font:ScaleW(13) textColor:kMainBlackColor text:@"保证金 601.24"];
    [self.contentView addSubview:self.gyfeeLabel];
    
    //过夜费
    self.label8 = [[UILabel alloc]initWithFrame:CGRectMake(self.currentLable.maxX, 125, width, 13)];
    [self.contentView label:self.label8 font:ScaleW(13) textColor:kMainBlackColor text:@"过夜费 "];
    [self.contentView addSubview:self.label8];
    
    //止盈
    self.label9 = [[UILabel alloc]initWithFrame:CGRectMake(23, 150, width, 13)];
    [self.contentView label:self.label9 font:ScaleW(13) textColor:kMainBlackColor text:@"止盈 "];
    [self.contentView addSubview:self.label9];
    
    //止损
    self.label10 = [[UILabel alloc]initWithFrame:CGRectMake(self.currentLable.maxX, 150, width, 13)];
    [self.contentView label:self.label10 font:ScaleW(13) textColor:kMainBlackColor text:@"止损 "];
    [self.contentView addSubview:self.label10];
    
    
    //平仓
    self.sellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sellBtn.frame = CGRectMake(Screen_Width - 100, 75-20, 90, 45);
    self.sellBtn.layer.cornerRadius = 3;
    self.sellBtn.layer.masksToBounds = YES;
    self.sellBtn.backgroundColor = kMainColor;
    [self.contentView addSubview:self.sellBtn];
    [self.contentView btn:self.sellBtn font:ScaleW(16) textColor:kMainWihteColor text:SSKJLocalized(@"平仓", nil) image:nil];
    [self.sellBtn addTarget:self action:@selector(sellBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //设置
    self.setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.setBtn.frame = CGRectMake(Screen_Width - 100, 75+40, 90, 45);
    self.setBtn.layer.cornerRadius = 3;
    self.setBtn.layer.masksToBounds = YES;
    self.setBtn.layer.borderWidth = 1.0;
    self.setBtn.layer.borderColor = kMainColor.CGColor;
    self.setBtn.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.setBtn];
    [self.contentView btn:self.setBtn font:ScaleW(16) textColor:kMainColor text:SSKJLocalized(@"设置", nil) image:nil];
    [self.setBtn addTarget:self action:@selector(setBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    self.setBtn.hidden = YES;

}

-(void)setDataFrom:(GE_Trading_ChiCang_Model *)data style:(ChiCangTableViewCellStyle)style
{
    self.aStyle = style;
    
    self.model = data;
    
    switch (style) {
        case ChiCangTableViewCellStyleChiCang:
        {
            self.setBtn.hidden = YES;
            
            self.label10.hidden = YES;
            
            self.label9.hidden = YES;
            
            self.label8.hidden = YES;
            
            self.directionLable.text = [NSString stringWithFormat:@"%@ %@",[data.otype integerValue] == 1 ? @"做多" : @"做空",data.pname];
            
            [self setLabelAttributed:self.directionLable color:[data.otype integerValue] == 1 ? RED_HEX_COLOR : GREEN_HEX_COLOR];
            
            self.dateLabel.text = [WLTools convertTimestamp:data.addtime.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            self.positionLable.text =  [NSString stringWithFormat:@"买价 %.2f",data.buyprice.doubleValue];
            
            self.moneyLabel.text =  [NSString stringWithFormat:@"现价 %.2f",data.newprice.doubleValue];
            
            self.currentLable.text = [NSString stringWithFormat:@"持仓 %@",data.buynum];
            
            self.ensureMoneyLabel.text = [NSString stringWithFormat:@"盈亏 %.2f",data.fdyk.doubleValue];
            
            self.sxFeeLabel.text = [NSString stringWithFormat:@"手续费 %.2f",data.sxfee.doubleValue];
            
            self.amountLable.text = [NSString stringWithFormat:@"过夜费 %.2f",data.dayfee.doubleValue];
            
            NSInteger index = [data.fdyk containsString:@"-"] ? 1 : 0;
            
            [self DoSomeWith:self.ensureMoneyLabel color:index == 1 ? GREEN_HEX_COLOR : RED_HEX_COLOR ];
            
            self.gyfeeLabel.text = [NSString stringWithFormat:@"保证金 %.2f",data.totalprice.doubleValue];
            
            self.label8.text = [NSString stringWithFormat:@"过夜费 %.2f",data.dayfee.doubleValue];
            
            self.label9.text = [NSString stringWithFormat:@"止盈 %.2f",data.stopProfitPrice.doubleValue];
            
            self.label10.text = [NSString stringWithFormat:@"止损 %.2f",data.stopLossPrice.doubleValue];

        }
            break;
        case ChiCangTableViewCellStyleGuaDan:
        {
            
            self.setBtn.hidden = YES;
            
            self.sellBtn.y = 60;
            
            [self.sellBtn setTitle:SSKJLocalized(@"撤单", nil) forState:(UIControlStateNormal)];
            
            self.label10.hidden = YES;
            
            self.label9.hidden = YES;
            
            self.label8.hidden = YES;
            
            self.gyfeeLabel.hidden = YES;
            
            self.directionLable.text = [NSString stringWithFormat:@"%@ %@",[data.otype integerValue] == 1 ? @"做多" : @"做空",data.pname];
            
            [self setLabelAttributed:self.directionLable color:[data.buyBillType integerValue] == 1 ? RED_HEX_COLOR : GREEN_HEX_COLOR];
            
            self.dateLabel.text = data.addtime;
            
            self.positionLable.text =  [NSString stringWithFormat:@"买价 %.2f",data.buyprice.doubleValue];
            
            self.moneyLabel.text =  [NSString stringWithFormat:@"手数 %@",data.buynum];
            
            self.currentLable.text = [NSString stringWithFormat:@"保证金 %.2f",data.totalprice.doubleValue];
            
            self.ensureMoneyLabel.text = [NSString stringWithFormat:@"手续费 %.2f",data.sxfee.doubleValue];
            
            self.sxFeeLabel.text = [NSString stringWithFormat:@"止盈 %.2f",data.stopProfitPrice.doubleValue];
            
            self.amountLable.text = [NSString stringWithFormat:@"止损 %.2f",data.stopLossPrice.doubleValue];
        }
            break;
            
        default:
            break;
    }

}

//设置
- (void)setBtnClicked:(UIButton *)btn
{
    
    if (self.setBtnBlock) {
        self.setBtnBlock();
    }
}


//平仓
-(void)sellBtnClicked:(UIButton *)sender
{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(sellOrBuyData:style:view:)]){
        [self.delegate sellOrBuyData:self.model style:ChiCangTableViewCellStyleChiCang view:sender];
    }
}

- (void)setLabelAttributed:(UILabel *)label color:(UIColor *)color
{
    if(label.text.length > 2)
    {
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc]initWithString:label.text];
        
        NSDictionary *atr  = @{
                               NSFontAttributeName: [UIFont systemFontOfSize:15],
                               NSForegroundColorAttributeName:color,
                               };
        [s setAttributes:atr range:NSMakeRange(0, 2)];
        
        label.attributedText = s;
    }
}

- (void)DoSomeWith:(UILabel *)label color:(UIColor *)color
{
    if(label.text.length > 2)
    {
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc]initWithString:label.text];
        
        NSDictionary *atr  = @{
                               NSFontAttributeName: [UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:color,
                               };
        [s setAttributes:atr range:NSMakeRange(2, label.text.length - 2)];
        
        label.attributedText = s;
    }
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
