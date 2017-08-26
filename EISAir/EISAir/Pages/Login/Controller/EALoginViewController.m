//
//  EALoginViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EALoginViewController.h"
#import "EAFindPassordViewController.h"
#import "TKRequestHandler+Login.h"
#import "TKAccountManager.h"

@interface  EALoginViewController ()<UITextFieldDelegate>

@property(nonatomic , strong) IBOutlet UITextField *nameField;
@property(nonatomic , strong) IBOutlet UITextField *passwordField;
    
    
@end

@implementation EALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:gesture];
    
    NSDictionary *attr = @{NSFontAttributeName:SYS_FONT(16),NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.nameField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"用户名" attributes:attr];
    self.passwordField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"密码" attributes:attr];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tapAction:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:true];
}

-(IBAction)loginAction:(id)sender
{
    if (_nameField.text.length == 0) {
        [EATools showToast:@"请输入用户名"];
        return;
    }
    if (_passwordField.text.length == 0) {
        [EATools showToast:@"请输入密码"];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    NSString *name = _nameField.text;
    [[TKRequestHandler sharedInstance]loginWithUserName:name password:_passwordField.text completion:^(NSURLSessionDataTask *task, EAOauthModel *model, NSError *error) {
        if (error || model == nil) {
            hud.label.text = @"请求失败";
            [hud hideAnimated:true afterDelay:0.7];
            return ;
        }
        
        if (model.errorDescription.length > 0) {
            hud.label.text = model.errorDescription;
            [hud hideAnimated:true afterDelay:0.7];
            return;
        }
        
        TKUserInfo *userInfo = [TKAccountManager sharedInstance].userInfo;
        userInfo.username = name;
        
        userInfo.accessToken = model.accessToken;
        userInfo.tokenType = model.tokenType;
        userInfo.expiresIn = model.expiresIn;
        userInfo.refreshToken = model.refreshToken;
        
        [[TKAccountManager sharedInstance] save];
        [[NSNotificationCenter defaultCenter]postNotificationName:kLoginDoneNotification object:nil];
        
        [hud hideAnimated:true];
    }];
    
}

-(IBAction)forgetPasswordAction:(id)sender
{
    EAFindPassordViewController *controller = [[EAFindPassordViewController alloc]initWithNibName:@"EAFindPassordViewController" bundle:nil];
//    [self.navigationController pushViewController:controller animated:true];
    [self presentViewController:controller animated:true completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _nameField) {
        [_passwordField becomeFirstResponder];
    }else{        
        [self.view endEditing:true];
    }
    
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
