//
//  EATaskDetailViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskDetailViewController.h"
#import "EATaskStateInfoTableViewCell.h"
#import "EATaskStateDoingTableViewCell.h"

@interface EATaskDetailViewController ()

@end

@implementation EATaskDetailViewController

+(instancetype)controller
{
    EATaskDetailViewController *controller = [[EATaskDetailViewController alloc]initWithStyle:UITableViewStyleGrouped];
    controller.hidesBottomBarWhenPushed = true;
    
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINib *nib = [UINib nibWithNibName:@"EATaskStateDoingTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"doing_cell"];
    
    nib = [UINib nibWithNibName:@"EATaskStateInfoTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"state_cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
