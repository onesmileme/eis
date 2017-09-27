//
//  EAFindPassordViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAFindPassordViewController.h"
#import "EALoginCountdownView.h"
#import "TKRequestHandler+Login.h"
#import "EATools.h"

@interface EAFindPassordViewController ()<UITextFieldDelegate>

@property(nonatomic , strong) IBOutlet UIScrollView *scrollView;
@property(nonatomic , strong) IBOutlet UIView *contentView;


@property(nonatomic , strong) IBOutlet UIButton *phoneLeftButton;
@property(nonatomic , strong) IBOutlet UITextField *phoneTextField;
@property(nonatomic , strong) IBOutlet UITextField *chapterTextField;
@property(nonatomic , strong) IBOutlet UITextField *passwordTextField;
@property(nonatomic , strong) IBOutlet UITextField *cofirmTextField;
@property(nonatomic , strong) IBOutlet UIButton *sendChapterButton;

@property(nonatomic , strong) EALoginCountdownView *countdownView;
@property(nonatomic , copy)   NSString *captcha;
@property(nonatomic , copy)   NSString *phone;


@end

@implementation EAFindPassordViewController

-(void)initTextField
{
    NSArray *fields = @[_phoneTextField,_chapterTextField,_passwordTextField,_cofirmTextField];
    for (UITextField *field in fields) {
        field.delegate = self;
        field.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        field.leftViewMode = UITextFieldViewModeAlways;
    }
    
    _phoneTextField.leftView = _phoneLeftButton;
    _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initTextField];
    
    self.contentView.frame = CGRectMake(13.5, 94, SCREEN_WIDTH-27, self.contentView.height);
    [self.scrollView addSubview:self.contentView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startCountDown
{
    if (!_countdownView) {
        _countdownView = [[EALoginCountdownView alloc]initWithFrame:_sendChapterButton.frame];
        
        __weak typeof(self) wself = self;
        _countdownView.countdownBlock = ^{
            wself.countdownView.hidden = true;
        };
        
        [self.contentView addSubview:_countdownView];
    }
    
    _countdownView.hidden = false;
    [_countdownView startCount];
    
}

-(IBAction)backAction:(id)sender
{
    [self.view endEditing:true];
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:^{
            
        }];
    }
}

-(IBAction)sendAction:(id)sender
{
    [self.view endEditing:true];
    [self startCountDown];
    
    self.phone = self.phoneTextField.text;
    [[TKRequestHandler sharedInstance]sendMessage:self.phone completion:^(NSURLSessionDataTask *task, NSDictionary *model, NSError *error) {
        if (model && [model[@"success"] integerValue] == 1) {
            //成功
        }
    }];
    
}

-(IBAction)confirmAction:(id)sender
{
    [self.view endEditing:true];
    
    if (self.phoneTextField.text.length == 0) {
        [EATools showToast:@"请输入手机号，并获取验证码"];
        return;
    }else if (self.chapterTextField.text.length == 0){
        [EATools showToast:@"请输入验证码"];
        return;
    }else if (self.passwordTextField.text.length == 0 || ![self.passwordTextField.text isEqualToString:self.cofirmTextField.text]){
        [EATools showToast:@"两次密码不一致"];
        return;
    }
    
    MBProgressHUD *hud = [EATools showLoadHUD:self.view];
    [[TKRequestHandler sharedInstance]findPassword:self.phoneTextField.text captcha:self.chapterTextField.text password:self.passwordTextField.text completion:^(NSURLSessionDataTask *task, NSDictionary *response, NSError *error) {
        BOOL success = false;
        if (response) {
            
            success = [response[@"success"] integerValue] > 0;
            if (success) {
                hud.label.text = @"密码重置成功";
            }else{
                hud.label.text = response[@"msg"]?:@"密码重置失败";
            }
        }else{
            hud.label.text = @"密码重置失败";
        }
        [hud hideAnimated:true afterDelay:1];
        if (success) {
            [self backAction:nil];
        }
    }];
    
}
#pragma textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.background = SYS_IMG(@"lost_password_input_pre");
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.background = SYS_IMG(@"lost_password_input");
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UITextField *next = nil;
    if (textField == _phoneTextField) {
        next = _chapterTextField;
    }else if (textField == _chapterTextField){
        next = _passwordTextField;
    }else if (textField == _passwordTextField){
        next = _cofirmTextField;
    }
    if (next) {
        [next becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
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
