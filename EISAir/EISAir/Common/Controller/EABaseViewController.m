//
//  EABaseViewController.m
//  CaiLianShe
//
//  Created by chunhui on 16/3/2.
//  Copyright © 2016年 chenny. All rights reserved.
//

#import "EABaseViewController.h"
#import "UIBarButtonItem+Navigation.h"
#import "MJRefresh.h"
//#import "FALogStatistiFAManager.h"
#import "EAVCView.h"
#import "UINavigationItem+margin.h"

@interface EABaseViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic , assign) NSTimeInterval startShowTimestamp;

@end

@implementation EABaseViewController

+(instancetype)nibController
{
    NSString *name = NSStringFromClass(self);
    return  [[self alloc]initWithNibName:name bundle:nil];
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _customRefreshTip = YES;
        _customBackItem = YES;
        self.pageName = @"";
        _pagedurationLog = YES;
    }
    return self;
}

- (void)loadView {
    if (self.nibName.length == 0) {
        self.view = [[EAVCView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }else{
        [super loadView];
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.customRefreshTip = YES;
    _customBackItem = YES;
    _pagedurationLog = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = false;
    self.automaticallyAdjustsScrollViewInsets = false;
//    [self addNightModelObserve];
    if (_customBackItem) {
        [self initBackItem];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


-(void)initBackItem
{
    UIBarButtonItem *backItem = [UIBarButtonItem defaultLeftItemWithTarget:self action:@selector(backAction)];
    
    [self.navigationItem setMarginLeftBarButtonItem:backItem];
}
- (void)addRightButtonWithTitle:(NSString *)title {
    UIFont *font = [UIFont systemFontOfSize:15];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = font;
    button.frame = CGRectMake(0, 0, 40, 30);
    [button addTarget:self action:@selector(rightButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)rightButtonPressed
{
    
}

//-(void)initNavbarTitle
//{
//    UILabel *titleLabel = [[UILabel alloc]init];
//    titleLabel.text = self.title;
//    titleLabel.font = [UIFont boldSystemFontOfSize:17];
//    titleLabel.textColor = [UIColor themeRedColor];
//    [titleLabel sizeToFit];
//    self.navigationItem.titleView = titleLabel;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //首页手指从最左侧滑动不处理
    if (self.navigationController &&  [[self.navigationController viewControllers] count] == 1) {
        return NO;
    }
    return YES;
}

//- (void)dealloc
//{
//    [self removeNightModelObserve];
//}

@end
