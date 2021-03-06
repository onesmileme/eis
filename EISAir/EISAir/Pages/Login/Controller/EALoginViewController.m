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
#import "TKRequestHandler+Account.h"
#import "TKRequestHandler+UploadImage.h"

static BOOL showLogin = false;

@interface  EALoginViewController ()<UITextFieldDelegate>

@property(nonatomic , strong) IBOutlet UITextField *nameField;
@property(nonatomic , strong) IBOutlet UITextField *passwordField;
    
    
@end

@implementation EALoginViewController

+(BOOL)isShowLogin
{
    return showLogin;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:gesture];
    
    NSDictionary *attr = @{NSFontAttributeName:SYS_FONT(16),NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.nameField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"用户名" attributes:attr];
    self.passwordField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"密码" attributes:attr];
    
    showLogin = true;
}

-(void)dealloc
{
    showLogin = false;
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

-(void)loadLoinUserInfo:(MBProgressHUD *)hud userInfo:(TKUserInfo *)userinfo refresh:(BOOL)refresh
{
    TKRequestHandler *handler = [TKRequestHandler sharedInstance];
    [handler setValue:[NSString stringWithFormat:@"%@ %@",[userinfo.tokenType capitalizedString],userinfo.accessToken] forHTTPHeaderField:@"Authorization"];
    
    [handler loadLoginUserInfo:^(NSURLSessionDataTask *task, EALoginUserInfoModel *model, NSError *error) {
        if (error || model == nil || !model.success) {
            hud.label.text = @"请求失败";
            [hud hideAnimated:true afterDelay:0.7];
            return ;
        }
        
        [TKAccountManager sharedInstance].loginUserInfo = model.data;
        
        [[TKAccountManager sharedInstance] save];
        
        [self loadUserAvatar];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:kLoginDoneNotification object:nil userInfo:@{@"refresh":@(refresh)}];
        
        showLogin = false;
        
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:true];
        }
        
        [hud hideAnimated:true];
        
    }];
}

-(void)loadUserAvatar
{
    [[TKRequestHandler sharedInstance] loadUserImage:nil completion:^(NSURLSessionTask *task, NSString *imgUrl, NSError *error) {
        if (imgUrl) {
            [TKAccountManager sharedInstance].loginUserInfo.avatar = imgUrl;
            [[TKAccountManager sharedInstance] save];
        }
    }];
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
    
    MBProgressHUD *hud = [EATools showLoadHUD:self.view];
    NSString *name = _nameField.text;
    [[TKRequestHandler sharedInstance]loginWithUserName:name password:_passwordField.text completion:^(NSURLSessionDataTask *task, EAOauthModel *model, NSError *error) {
        if (error || model == nil) {

      
            NSData *d = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            
            NSDictionary *info = nil;
            @try {
                    info = [NSJSONSerialization JSONObjectWithData:d options:kNilOptions error:nil];
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            
#if DEBUG
            NSLog(@"error is: \n%@\n",info);
#endif
            
            NSString *tip = info[@"error_description"];
            if (tip == nil || tip.length == 0 ){
                tip = @"请求失败";
            } else if([tip isEqualToString:@"Bad credentials"]) {
                tip = @"密码不正确";
            }
            
            hud.label.text = tip;
            [hud hideAnimated:true afterDelay:0.7];
            return ;
        }
        
        if (model.errorDescription.length > 0) {
            hud.label.text = model.errorDescription;
            [hud hideAnimated:true afterDelay:0.7];
            return;
        }
        
        TKUserInfo *userInfo = [TKAccountManager sharedInstance].userInfo;
        BOOL refresh = userInfo.username.length > 0;
        
        userInfo.username = name;
        
        userInfo.accessToken = model.accessToken;
        userInfo.tokenType = model.tokenType;
        userInfo.expiresIn = model.expiresIn;
        userInfo.refreshToken = model.refreshToken;
        
        [self loadLoinUserInfo:hud userInfo:userInfo refresh:refresh];
    }];
    
}

-(IBAction)forgetPasswordAction:(id)sender
{
    EAFindPassordViewController *controller = [[EAFindPassordViewController alloc]initWithNibName:@"EAFindPassordViewController" bundle:nil];
    if (self.navigationController) {
        [self.navigationController pushViewController:controller animated:true];
    }else{
        [self presentViewController:controller animated:true completion:nil];
    }
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
