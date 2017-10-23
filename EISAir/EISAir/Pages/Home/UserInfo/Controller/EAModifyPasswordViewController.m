//
//  EAModifyPasswordViewController.m
//  EISAir
//
//  Created by chunhui on 2017/9/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAModifyPasswordViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "EAModifyPasswordItemView.h"
#import "TKRequestHandler+UserInfo.h"

@interface EAModifyPasswordViewController ()<UITextFieldDelegate>

@property(nonatomic , strong) TPKeyboardAvoidingScrollView *scrollView;
@property(nonatomic , strong) EAModifyPasswordItemView *oldPwdView;
@property(nonatomic , strong) EAModifyPasswordItemView *setPwdView;
@property(nonatomic , strong) EAModifyPasswordItemView *confirmPwdView;
@property(nonatomic , strong) UIView *tipView;
@property(nonatomic , strong) UIImageView *checkImageView;

@end

@implementation EAModifyPasswordViewController

-(void)initNavbar
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 60, 40);
    [button addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = saveItem;
    
}

-(void)loadView
{
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
    
    [self initNavbar];
    
    _scrollView = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    _scrollView.backgroundColor = HexColor(0xeeeeee);
    
    _oldPwdView = [[EAModifyPasswordItemView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    [_oldPwdView updateTitle:@"旧密码"];
    
    _setPwdView = [[EAModifyPasswordItemView alloc]initWithFrame:CGRectMake(0, _oldPwdView.bottom, SCREEN_WIDTH, 100)];
    [_setPwdView updateTitle:@"新密码"] ;
    
    _confirmPwdView = [[EAModifyPasswordItemView alloc]initWithFrame:CGRectMake(0, _setPwdView.bottom, SCREEN_WIDTH, 100)];
    [_confirmPwdView updateTitle:@"重复新密码"];
    
    self.tipView.top = _confirmPwdView.bottom;
    NSArray *views = @[_oldPwdView,_setPwdView,_confirmPwdView];
    
    for (EAModifyPasswordItemView *v in views) {
        v.textField.delegate = self;
        [_scrollView addSubview:v];
    }
    [_scrollView addSubview:_tipView];
    
    [self.view addSubview:_scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveAction:(id)sender
{
    if (_oldPwdView.textField.text.length == 0 || _setPwdView.textField.text.length == 0 || _confirmPwdView.textField.text.length == 0) {
        [EATools showToast:@"请输入旧密码和新密码"];
        return;
    }
    
    if (![_setPwdView.textField.text isEqualToString:_confirmPwdView.textField.text]) {
        [EATools showToast:@"两次密码不一致"];
        return;
    }
    
    if (_setPwdView.textField.text.length < 6 ) {
        [EATools showToast:@"密码小于6位"];
        return;
    }
        
    //TODO call modify password
    MBProgressHUD *hud = [EATools showLoadHUD:self.view];
    [[TKRequestHandler sharedInstance]modifyPassword:_setPwdView.textField.text oldPassword:_oldPwdView.textField.text completion:^(NSURLSessionDataTask *task, BOOL success, NSError *error) {
        if (success) {
            [hud hideAnimated:true];
            [self.navigationController popViewControllerAnimated:true];
        }else{
            hud.label.text = @"修改密码失败";
            [hud hideAnimated:true afterDelay:1];
        }
    }];
    
}

-(UIView *)tipView
{
    if (!_tipView) {
        _tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        UIImage *img = SYS_IMG(@"set_sle");
        UIImage *checkImg = SYS_IMG(@"set_sle_r");
        _checkImageView = [[UIImageView alloc]initWithImage:img highlightedImage:checkImg];
        _checkImageView.frame = CGRectMake(15, 13.5, 25, 25);
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = _checkImageView.frame;
        [button addTarget:self action:@selector(updateCheckAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc]init];
        label.font = SYS_FONT(14);
        label.textColor = HexColor(0x999999);
        label.text = @"明文显示";
        [label sizeToFit];
        label.left = _checkImageView.right + 10;
        label.centerY = _checkImageView.centerY;
        
        [_tipView addSubview:_checkImageView];
        [_tipView addSubview:button];
        [_tipView addSubview:label];
        
        
    }
    return _tipView;
}

-(void)updateCheckAction:(UIButton *)button
{
    _checkImageView.highlighted = !_checkImageView.highlighted;
    BOOL secure = !_checkImageView.highlighted;
    [_oldPwdView showSecure:secure];;
    [_setPwdView showSecure:secure];
    [_confirmPwdView showSecure:secure];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _setPwdView.textField || textField == _confirmPwdView.textField) {
        [_confirmPwdView updateTip:nil];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _confirmPwdView.textField) {
        if (![textField.text isEqualToString:_setPwdView.textField.text]) {
            [_confirmPwdView updateTip:@"两次密码输入不一样"];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    return true;
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
