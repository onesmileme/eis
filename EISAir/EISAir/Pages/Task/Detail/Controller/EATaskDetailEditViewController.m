//
//  EATaskDetailEditViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskDetailEditViewController.h"
#import "SAMTextView.h"
@interface EATaskDetailEditViewController ()

@property(nonatomic , strong) IBOutlet SAMTextView *textView;

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
    self.title = @"执行中";
    [self initNavbar];
    
    self.textView.layer.borderColor = [HexColor(0xd8d8d8) CGColor];
    self.textView.layer.borderWidth = 0.5;
    
    self.textView.placeholder = @"请输入任务反馈";
    self.textView.placeholderTextColor = HexColor(0xb0b0b0);
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:gesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)finishAction:(id)sender
{
    
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
