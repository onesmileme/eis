//
//  EALoginViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/19.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EALoginViewController.h"
#import "EAFindPassordViewController.h"

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
    
}

-(IBAction)forgetPasswordAction:(id)sender
{
    EAFindPassordViewController *controller = [[EAFindPassordViewController alloc]initWithNibName:@"EAFindPassordViewController" bundle:nil];
    [self presentViewController:controller animated:true completion:^{
        
    }];
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
