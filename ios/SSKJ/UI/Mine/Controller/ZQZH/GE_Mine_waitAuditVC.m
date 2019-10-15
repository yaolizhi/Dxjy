//
//  GE_Mine_waitAuditVC.m
//  SSKJ
//
//  Created by 张超 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GE_Mine_waitAuditVC.h"
#import "GE_Mine_realNameVC.h"
#import "Mine_RealName_ViewController.h"
@interface GE_Mine_waitAuditVC ()

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (weak, nonatomic) IBOutlet UIView *yuanView1;
@property (weak, nonatomic) IBOutlet UIView *yuanView2;
@property (weak, nonatomic) IBOutlet UIView *yuanView3;
@property (weak, nonatomic) IBOutlet UIView *yuanView4;

@property (weak, nonatomic) IBOutlet UIButton *resetRenZhengBtn;


@property (weak, nonatomic) IBOutlet UIImageView *jieguoImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;

@end

@implementation GE_Mine_waitAuditVC

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
    
    self.detailsLabel.font = [UIFont systemFontOfSize:ScaleW(15)];
    
    if (self.dataSource.count>0) {
        switch ([self.dataSource[@"auth_status"] intValue]) {
            case 4:
            {
                //已拒绝
                self.jieguoImageView.image = [UIImage imageNamed:@"GE_My_auditFail"];
                self.detailsLabel.text =[NSString stringWithFormat:@"审核失败，失败原因：\n%@",self.dataSource[@"checkReason"]];
                [self.btn4 setTitle:@"审核失败" forState:UIControlStateNormal];
                self.resetRenZhengBtn.hidden = NO;
            }
                break;
            case 3:
            {
                //审核成功
                self.jieguoImageView.image = [UIImage imageNamed:@"GE_My_auditSuccess"];
                self.detailsLabel.text = @"审核成功";
                [self.btn4 setTitle:@"审核成功" forState:UIControlStateNormal];
                self.resetRenZhengBtn.hidden = YES;
            }
                break;
            case 2:
            {
                //审核中
                self.jieguoImageView.image = [UIImage imageNamed:@"GE_My_auditWaiting"];
                self.detailsLabel.text = @"审核中，请耐心等待";
                [self.btn4 setTitle:@"等待审核" forState:UIControlStateNormal];
                self.resetRenZhengBtn.hidden = YES;
                
            }
                break;
                
            default:
                break;
        }
    }
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
            return ScaleW(350);
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (void)viewWillDisappear:(BOOL)animated{
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

//重新认证
- (IBAction)resetRenZhengBtnClick:(UIButton *)sender {
//    GE_Mine_realNameVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GE_Mine_realNameVC"];
//    [self.navigationController pushViewController:vc animated:YES];

    Mine_RealName_ViewController *vc = [[Mine_RealName_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
