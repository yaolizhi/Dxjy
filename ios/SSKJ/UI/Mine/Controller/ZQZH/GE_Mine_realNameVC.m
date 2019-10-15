//
//  GE_Mine_realNameVC.m
//  SSKJ
//
//  Created by 张超 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_realNameVC.h"
#import "GE_Mine_uploadIdCardVC.h"



@interface GE_Mine_realNameVC ()

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (weak, nonatomic) IBOutlet UILabel *ziliaoLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardTextField;
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UITextField *textField3;
@property (weak, nonatomic) IBOutlet UITextField *textField4;
@property (weak, nonatomic) IBOutlet UITextField *textField5;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UIView *yuanView1;
@property (weak, nonatomic) IBOutlet UIView *yuanView2;
@property (weak, nonatomic) IBOutlet UIView *yuanView3;
@property (weak, nonatomic) IBOutlet UIView *yuanView4;


@end

@implementation GE_Mine_realNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"实名开户";
    
    self.btn1.titleLabel.font = [UIFont systemFontOfSize:ScaleW(13)];
    [self.btn1 setTitleEdgeInsets:UIEdgeInsetsMake(ScaleW(45), 0, 0, 0)];
    self.btn2.titleLabel.font = [UIFont systemFontOfSize:ScaleW(13)];
    [self.btn2 setTitleEdgeInsets:UIEdgeInsetsMake(ScaleW(45), 0, 0, 0)];
    self.btn3.titleLabel.font = [UIFont systemFontOfSize:ScaleW(13)];
    [self.btn3 setTitleEdgeInsets:UIEdgeInsetsMake(ScaleW(45), 0, 0, 0)];
    self.btn4.titleLabel.font = [UIFont systemFontOfSize:ScaleW(13)];
    [self.btn4 setTitleEdgeInsets:UIEdgeInsetsMake(ScaleW(45), 0, 0, 0)];
    
    self.ziliaoLabel.font = [UIFont systemFontOfSize:ScaleW(15)];
    self.nameTextField.font = [UIFont systemFontOfSize:ScaleW(14)];
    self.cardTextField.font = [UIFont systemFontOfSize:ScaleW(14)];
    self.textField1.font = [UIFont systemFontOfSize:ScaleW(14)];
    self.textField2.font = [UIFont systemFontOfSize:ScaleW(14)];
    self.textField3.font = [UIFont systemFontOfSize:ScaleW(14)];
    self.textField4.font = [UIFont systemFontOfSize:ScaleW(14)];
    self.textField5.font = [UIFont systemFontOfSize:ScaleW(14)];
    
    self.nextBtn.titleLabel.font = [UIFont systemFontOfSize:ScaleW(16)];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            return ScaleW(100);
        }
            break;
        case 1:
        {
            return ScaleW(50);
        }
            break;
        case 2:
        {
            return ScaleW(0);
        }
            break;
        case 3:
        {
            return ScaleW(0);
        }
            break;
        case 4:
        {
            return ScaleW(10);
        }
            break;
        case 5:
        {
            return ScaleW(50);
        }
            break;
        case 6:
        {
            return ScaleW(0);
        }
            break;
        case 7:
        {
            return ScaleW(0);
        }
            break;
        case 8:
        {
            return ScaleW(50);
        }
            break;
        case 9:
        {
            return ScaleW(50);
        }
            break;
        case 10:
        {
//            return ScaleW(150);
            return 150;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

//下一步
- (IBAction)nextBtnClick:(UIButton *)sender {
    
//    if (_nameTextField.text.length == 0) {
//        [MBProgressHUD showError:@"请输入姓名"];
//        return;
//    }
//    if (_cardTextField.text.length == 0) {
//        [MBProgressHUD showError:@"请输入身份证号"];
//        return;
//    }
    if (_textField1.text.length == 0) {
        [MBProgressHUD showError:@"请输入银行卡类型，例如中国银行"];
        return;
    }
//    if (_textField2.text.length == 0) {
//        [MBProgressHUD showError:@"请输入开户行省份"];
//        return;
//    }
//    if (_textField3.text.length == 0) {
//        [MBProgressHUD showError:@"请输入开户行市/区"];
//        return;
//    }
    if (_textField4.text.length == 0) {
        [MBProgressHUD showError:@"请输入开户行地址"];
        return;
    }
    if (_textField5.text.length < 14) {
        [MBProgressHUD showError:@"请输入您要出入金的银行卡号"];
        return;
    }
    
    GE_Mine_uploadIdCardVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GE_Mine_uploadIdCardVC"];
    vc.cardType = _textField1.text;
    vc.cardAccount = _textField5.text;
    vc.cardAddress = _textField4.text;
    [self.navigationController pushViewController:vc animated:YES];
    
//    [self httpRequest];
}

//基本资料
- (void)httpRequest
{
    NSDictionary *params = @{@"account":[SSKJ_User_Tool sharedUserTool].getAccount,
                             @"app":@"app",
                             @"action":@"openAccount",
                             @"systemType":@"IOS",
                             @"username":_nameTextField.text,
                             @"idCardNo":_cardTextField.text,
                             @"cardType":_textField1.text,
                             @"province":_textField2.text,
                             @"city":_textField3.text,
                             @"bankCardOpenBank":_textField4.text,
                             @"cardNo":_textField5.text,
                             @"sessionId":[[SSKJ_User_Tool sharedUserTool] getToken]
                             };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:[NSString stringWithFormat:@"%@",ProductBaseURL] RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == 200)
        {
            
            GE_Mine_uploadIdCardVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GE_Mine_uploadIdCardVC"];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
    }];
    
}


@end
