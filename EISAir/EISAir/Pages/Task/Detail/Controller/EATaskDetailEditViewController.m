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
#import "TKRequestHandler+Task.h"
#import "EATaskHelper.h"
#import "EATools.h"

@interface EATaskDetailEditViewController ()

@property(nonatomic , strong) IBOutlet SAMTextView *textView;
@property(nonatomic , strong) IBOutlet UIView *assingBgView;
@property(nonatomic , strong) IBOutlet UILabel *assignLabel;
@property(nonatomic , strong) NSArray<EAUserDataListModel *>* users;


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
        switch (_editType) {
            case EATaskEditTypeAssign:
            {
                self.title = @"指派给";
            }
                break;
            case EATaskEditTypeReject:
            {
                self.title = @"拒绝原因";
            }
                break;
            case EATaskEditTypeExecute:
            {
                self.title = @"执行中";
            }
                break;
            default:
                break;
        }
        
    }
    [self initNavbar];
    
    self.textView.layer.borderColor = [HexColor(0xd8d8d8) CGColor];
    self.textView.layer.borderWidth = 0.5;
    
    self.textView.placeholder = self.placeHoder?: @"请输入任务反馈";
    self.textView.placeholderTextColor = HexColor(0xb0b0b0);
    
    if (!_showAssign) {
        self.assingBgView.hidden = true;
    }
    
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
    if (_textView.text.length == 0) {
        [EATools showToast: @"您还没填写原因！"];
        return;
    }
    
    switch (_editType) {
        case EATaskEditTypeAssign:
        {
            [self assignTaskAction];
        }
            break;
        case EATaskEditTypeReject:
        {
            [self refuseAction];
        }
            break;
        case EATaskEditTypeExecute:
        {
            [self executeAction];
        }
            break;
        default:
            break;
    }
    
    [self refuseAction];
}

-(void)refuseAction
{
    EATaskUpdateModel *model = [[EATaskUpdateModel alloc]init];
    model.anewStatus = [EATaskHelper executeStatusName:EATaskExecuteStatusRefuse];

    [self updateTaskAction:model];
}

-(void)assignTaskAction
{
    EATaskUpdateModel *model = [[EATaskUpdateModel alloc]init];
    model.anewStatus = [EATaskHelper executeStatusName:EATaskExecuteStatusRefuse];

    [self updateTaskAction:model];
}


-(void)executeAction
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"该任务是否完成" message:nil preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) wself = self;
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        EATaskUpdateModel *model = [[EATaskUpdateModel alloc]init];
        model.anewStatus = [EATaskHelper executeStatusName:EATaskExecuteStatusCompleted];
        //@"接收任务";
        model.transferPersonIds = [wself atUserIds];
        [self updateTaskAction:model];
    }];
    
    [controller addAction:action];
    
    action = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        EATaskUpdateModel *model = [[EATaskUpdateModel alloc]init];
        model.anewStatus = [EATaskHelper executeStatusName:EATaskExecuteStatusReceive];
        //@"接收任务";
        model.transferPersonIds = [wself atUserIds];
        [self updateTaskAction:model];
    }];
    [controller addAction:action];
    
    [self presentViewController:controller animated:true completion:nil];
    
}

-(NSArray *)atUserIds
{
    if (_users.count > 0) {
        NSMutableArray *ids = [[NSMutableArray alloc]init];
        for(EAUserDataListModel *m in self.users){
            [ids addObject:m.uid];
        }
        return ids;
    }
    return nil;
}

-(void)updateTaskAction:(EATaskUpdateModel * )model
{
    model.taskId = self.task.tid;
    model.taskResult = self.textView.text;
    if (_users.count > 0) {
        NSMutableArray *ids = [[NSMutableArray alloc]init];
        for (EAUserDataListModel *u in _users) {
            [ids addObject:u.uid];
        }
        model.transferPersonIds = ids;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    __weak typeof(self) wself = self;
    [[TKRequestHandler sharedInstance] saveEisTaskResult:model completion:^(NSURLSessionDataTask *task, EATaskUpdateModel *model, NSError *error) {
        if (error == nil && model) {
            [hud hideAnimated:true];
            if (wself.doneBlock) {
                wself.doneBlock(wself.textView.text, nil);
            }
            [wself.navigationController popViewControllerAnimated:true];
        }else{
            hud.label.text = @"更改请求失败";
            [hud hideAnimated:true afterDelay:0.7];
            NSLog(@"error is: \n%@\n",error);
        }
    }];
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
    controller.chooseUserBlock = ^(NSArray<EAUserDataListModel *>* users) {
        wself.users = users;
        if (users.count > 0) {
            NSMutableArray *userNames = [NSMutableArray new];
            for (EAUserDataListModel *m in users) {
                [userNames addObject:m.name];
            }
            wself.assignLabel.text = [userNames componentsJoinedByString:@","];
        }else{
            wself.assignLabel.text = nil;
        }
        
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
