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
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}

-(IBAction)sendAction:(id)sender
{
    [self startCountDown];
    
    [[TKRequestHandler sharedInstance]sendMessageCompletion:^(NSURLSessionDataTask *task, NSDictionary *model, NSError *error) {
        
    }];
    
}

-(IBAction)confirmAction:(id)sender
{
    
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
