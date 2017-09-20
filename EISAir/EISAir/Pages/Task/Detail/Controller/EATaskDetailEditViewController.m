//
//  EATaskDetailEditViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskDetailEditViewController.h"
#import "SAMTextView.h"
#import "EAUserSearchViewController.h"
#import "EAUserModel.h"

@interface EATaskDetailEditViewController ()

@property(nonatomic , strong) IBOutlet SAMTextView *textView;
@property(nonatomic , strong) IBOutlet UIView *assingBgView;
@property(nonatomic , strong) IBOutlet UILabel *assignLabel;
@property(nonatomic , strong) EAUserDataListModel *user;

@end

@implementation EATaskDetailEditViewController

-(void)initNavbar
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishAction:)];
    NSDictionary *dict = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    [item setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.title.length == 0) {
        self.title = @"执行中";
    }
    [self initNavbar];
    
    self.textView.layer.borderColor = [HexColor(0xd8d8d8) CGColor];
    self.textView.layer.borderWidth = 0.5;
    
    self.textView.placeholder = self.placeHoder?: @"请输入任务反馈";
    self.textView.placeholderTextColor = HexColor(0xb0b0b0);
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:gesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setShowAssign:(BOOL)showAssign
{
    _showAssign = showAssign;
    _assingBgView.hidden = !showAssign;
}

-(void)finishAction:(id)sender
{
    if (_doneBlock) {
        _doneBlock(_textView.text,self.user);
    }
}

-(void)tapAction:(UITapGestureRecognizer *)sender
{
    CGPoint location = [sender locationInView:self.view];
    if (CGRectContainsPoint(_textView.frame, location)) {
        return;
    }
    
    [self.textView resignFirstResponder];
}

-(IBAction)assignAction:(id)sender
{
    EAUserSearchViewController *controller = [[EAUserSearchViewController alloc]init];
    controller.hidesBottomBarWhenPushed = true;
    __weak typeof(self) wself = self;
    controller.chooseUserBlock = ^(EAUserDataListModel *user) {
        wself.user = user;
        wself.assignLabel.text = user.name;
    };
    [self.navigationController pushViewController:controller animated:true];
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
