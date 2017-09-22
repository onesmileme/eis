//
//  EATaskAddTableViewController.m
//  EISAir
//
//  Created by chunhui on 2017/9/21.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskAddTableViewController.h"
#import "EATaskItemModel.h"
#import "EAAddTaskInputCell.h"
#import "EAAddTaskDateCell.h"
#import <TPKeyboardAvoidingTableView.h>
#import "TKCommonTools.h"
#import "EAScanViewController.h"

@interface EATaskAddTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong) TPKeyboardAvoidingTableView *tableView;
@property(nonatomic , strong) EATaskItemModel *model;

@end

@implementation EATaskAddTableViewController

+(instancetype)controller
{
    EATaskAddTableViewController *controller = [[EATaskAddTableViewController alloc]init];
    return controller;
}

-(void)initNavbar
{
    self.title = @"填写数据";
    UIImage *img = SYS_IMG(@"scan") ;
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *scanItem = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(scanAction:)];
    self.navigationItem.rightBarButtonItem = scanItem;
    
}

-(void)scanAction:(id)sender
{
    EAScanViewController *controller = [EAScanViewController scanController];
    __weak typeof(self) wself = self;
    controller.doneBlock = ^(NSString *urlcode) {
        wself.model.index = urlcode;
        [wself.tableView reloadData];
    };
    [self.navigationController pushViewController:controller animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self initNavbar];
    _tableView = [[TPKeyboardAvoidingTableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"EAAddTaskInputCell" bundle:nil];
    for (int i = 0 ; i < 9; i++) {
        NSString *cid = [NSString stringWithFormat:@"-%d-",i];
        [_tableView registerNib:nib forCellReuseIdentifier:cid];
    }
    nib = [UINib nibWithNibName:@"EAAddTaskDateCell" bundle:nil];
    for (int i = 9 ; i < 12; i++) {
        NSString *cid = [NSString stringWithFormat:@"-%d-",i];
        [_tableView registerNib:nib forCellReuseIdentifier:cid];
    }
    
    _tableView.tableFooterView = [self nextView];
    [self.view addSubview:_tableView];
    
    
    _model = [[EATaskItemModel alloc]init];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)nextView
{
    UIView *nextView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:SYS_IMG(@"task_btn_next") forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.8, 43);
    [button addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    button.center = CGPointMake(nextView.width/2, nextView.height/2);
    [nextView addSubview:button];
    
    return nextView;
}

-(void)nextAction
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 12;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *c = nil;
    NSString *cellid = [NSString stringWithFormat:@"-%ld-",indexPath.row];
    
    
    if (indexPath.row < 9) {
        EAAddTaskInputCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid ];
        if (!cell.modifyBlock) {
            cell.modifyBlock = ^(EAAddTaskInputCell *cell) {
                
            };
            
            cell.inputBlock = ^(EAAddTaskInputCell *cell, NSString *content) {
                switch (cell.tag) {
                    case EATaskItemTypeIndex:
                    {
//                        title = @"序号";
                        _model.index = content;
                    }
                        break;
                    case EATaskItemTypeTableNum:
                    {
                        // @"表号";
                        _model.tableNum = content;
                    }
                        break;
                    case EATaskItemTypeBeilv:
                    {
                        // @"倍率";
                        _model.beilv = content;
                    }
                        break;
                    case EATaskItemTypeAmount:
                    {
                        // @"用量";
                        _model.amount = content;
                    }
                        break;
                    case EATaskItemTypeLastAmount:
                    {
                         // @"上次用量";
                        _model.lastAmount = content;
                    }
                        break;
                    case EATaskItemTypeThisAmountDays:
                    {
                        // @"本次用量日数";
                        _model.thisAmountDays = content;
                    }
                        break;
                    case EATaskItemTypeLastAmountDays:
                    {
                        // @"上次用量日数";
                         _model.lastAmountDays = content;
                    }
                        break;
                    case EATaskItemTypeThisNum:
                    {
                        // @"本次读数";
                        _model.thisNum = content;
                    }
                        break;
                    case EATaskItemTypeLastNum:
                    {
                        // @"上次读数";
                        _model.lastNum = content;
                    }
                        break;
                    default:
                        break;

                }
            };
        }
        
        cell.tag = indexPath.row;
        NSString *content = nil;
        NSString *title = nil;
        switch (indexPath.row) {
            case EATaskItemTypeIndex:
            {
                title = @"序号";
                content = _model.index;
            }
                break;
            case EATaskItemTypeTableNum:
            {
                title = @"表号";
                content = _model.tableNum;
            }
                break;
            case EATaskItemTypeBeilv:
            {
                title = @"倍率";
                content = _model.beilv;
            }
                break;
            case EATaskItemTypeAmount:
            {
                title = @"用量";
                content = _model.amount;
            }
                break;
            case EATaskItemTypeLastAmount:
            {
                title = @"上次用量";
                content = _model.lastAmount;
            }
                break;
            case EATaskItemTypeThisAmountDays:
            {
                title = @"本次用量日数";
                content = _model.thisAmountDays;
            }
                break;
            case EATaskItemTypeLastAmountDays:
            {
                title = @"上次用量日数";
                content = _model.lastAmountDays;
            }
                break;
            case EATaskItemTypeThisNum:
            {
                title = @"本次读数";
                content = _model.thisNum;
            }
                break;
            case EATaskItemTypeLastNum:
            {
                title = @"上次读数";
                content = _model.lastNum;
            }
                break;
            default:
                break;
        }
        cell.titleLabel.text = title;
        cell.contentField.text = content;
        
        
        c = cell;
        
    }else{
        EAAddTaskDateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell.chooseDate) {
            cell.chooseDate = ^(EAAddTaskDateCell *cell ,NSDate *date) {
                NSString *content = [TKCommonTools dateStringWithFormat:TKDateFormatChineseShortYMD date:date];
                switch (cell.tag) {
                    case EATaskItemTypeDate:
                    {
                        // @"抄表日期";
                         _model.date = content;
                    }
                        break;
                    case EATaskItemTypeLastDate:
                    {
                        // @"上次抄表日期";
                         _model.lastDate = content ;
                    }
                        break;
                    case EATaskItemTypeMonth:
                    {
                        // @"本次用量结算月份";
                        NSArray *components = [content componentsSeparatedByString:@"-"];
                        if (components.count > 2) {
                            content = [NSString stringWithFormat:@"%@-%@",components[0],components[1]];
                        }
                        _model.month = content;
                    }
                        break;
                        
                    default:
                        break;
                }
                cell.contentField.text = content;
            };
        }
        
        cell.tag = indexPath.row;
        NSString *content = nil;
        NSString *title = nil;
        switch (indexPath.row) {
            case EATaskItemTypeDate:
            {
                title = @"抄表日期";
                content = _model.date;
            }
                break;
            case EATaskItemTypeLastDate:
            {
                title = @"上次抄表日期";
                content = _model.lastDate;
            }
                break;
            case EATaskItemTypeMonth:
            {
                title = @"本次用量结算月份";
                content = _model.month;
            }
                break;
                
            default:
                break;
        }
        
        cell.contentField.text = content;
        cell.titleLabel.text = title;
        
        c = cell;
    }
    
    
    // Configure the cell...
    c.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return c;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 39;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = [UIColor clearColor];
    return v;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if ([cell isKindOfClass:[EAAddTaskInputCell class]]) {
//        EAAddTaskInputCell *c = (EAAddTaskInputCell *)cell;
//        [c.contentField becomeFirstResponder];
//    }else{
//        EAAddTaskDateCell *c = (EAAddTaskDateCell *)cell;
//        [c.contentField becomeFirstResponder];
//    }
//}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
