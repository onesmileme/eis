//
//  EAMessageSearchViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMessageSearchViewController.h"
#import "EAMessageSearchFilterView.h"
#import "EAScanViewController.h"

@interface EAMessageSearchViewController ()

@property(nonatomic , strong) UITextField *searchBar;
@property(nonatomic , strong) EAMessageSearchFilterView *filterView;

@end

@implementation EAMessageSearchViewController


-(void)initNavbar
{
    _searchBar = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 33)];
    _searchBar.borderStyle = UITextBorderStyleNone;
    _searchBar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    _searchBar.layer.cornerRadius = 4;
    _searchBar.layer.masksToBounds = true;
    
    //left view
    //search
    UIImageView *searchView =  [[UIImageView alloc]initWithImage:SYS_IMG(@"seach_icon1")];
    searchView.contentMode = UIViewContentModeCenter;
    searchView.frame = CGRectMake(0, 0, 35, 33);
    _searchBar.leftView = searchView;
    
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    self.navigationItem.titleView = _searchBar;
    
    _searchBar.font = SYS_FONT(14);
    
    NSAttributedString *placeholder = [[NSAttributedString alloc]initWithString:@"请输入名称描述" attributes:@{NSFontAttributeName:SYS_FONT(14),NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _searchBar.attributedPlaceholder = placeholder;
    
    UIImage *img = SYS_IMG(@"scan") ;
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *scanItem = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(scanAction:)];
    self.navigationItem.rightBarButtonItem = scanItem;
}

-(EAMessageSearchFilterView *)filterView
{
    if (!_filterView) {
        CGRect frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT -64);
        
        NSArray *items = @[@{@"name":@"1111",@"info":@"2222"} , @{@"name":@"3333",@"info":@"2222"} , @{@"name":@"4444",@"info":@"2222"}];
        
        _filterView = [[EAMessageSearchFilterView alloc]initWithFrame:frame items:items];
    }
    return _filterView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavbar];
    self.view.backgroundColor = [UIColor redColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scanAction:(id)sender
{
    EAScanViewController *controller = [EAScanViewController scanController];
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
