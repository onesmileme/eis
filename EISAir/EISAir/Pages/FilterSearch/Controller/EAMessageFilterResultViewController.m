//
//  EAMessageFilterResultViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMessageFilterResultViewController.h"
#import "EAMessageNoDataView.h"
#import "EAMsgFilterModel.h"
#import "TKAccountManager.h"
#import "TKRequestHandler+Message.h"
#import "EAMsgDetailViewController.h"
#import "EAMessageTableViewCell.h"
#import "EAMessageModel.h"
#import "MJRefresh.h"

@interface EAMessageFilterResultViewController ()

@property(nonatomic , strong) EAMessageDataModel *dataModel;
@property(nonatomic , strong) EAMessageNoDataView *noDataView;
@property(nonatomic , strong) NSMutableArray *msgList;
@property(nonatomic , assign) NSInteger pageNum;
@end

@implementation EAMessageFilterResultViewController

+(instancetype)controller
{
    EAMessageFilterResultViewController *controller = [[EAMessageFilterResultViewController alloc]initWithStyle:UITableViewStylePlain];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"筛选结果";
    UINib *nib = [UINib nibWithNibName:@"EAMessageTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"msg_cell"];
    
    [self addHeaderRefreshView:self.tableView];
    _msgList = [[NSMutableArray alloc]init];
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, CGFLOAT_MIN) ];
    header.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = header;
    UIView *footer = [[UIView alloc]initWithFrame:header.frame];
    footer.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footer;
    
    [self startHeadRefresh:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(EAMessageNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [EAMessageNoDataView view];
        __weak typeof(self) wself = self;
        _noDataView.tapBlock = ^{            
            [wself startHeadRefresh:wself.tableView];
            [wself.noDataView removeFromSuperview];
        };
    }
    return _noDataView;
}

-(void)headRefreshAction
{
    [self loadMessage:0];
}

-(void)footRefreshAction
{
    [self loadMessage:_pageNum+1];
}

-(void)loadMessage:(NSInteger)pageNum
{
    
    EALoginUserInfoDataModel *udata = [TKAccountManager sharedInstance].loginUserInfo;
    
    if (!_filterModel) {
        _filterModel = [[EAMsgFilterModel alloc]init];
    }
    
    _filterModel.pageNum = @(pageNum).description;
    _filterModel.pageSize = @"20";
    _filterModel.orgId = udata.orgId;
    _filterModel.siteId = udata.siteId;
    
    [[TKRequestHandler sharedInstance] loadMyMessageFilterParam:_filterModel completion:^(NSURLSessionDataTask *task, EAMessageModel *model, NSError *error) {
        
        [self stopRefresh:self.tableView];
        
        if (error || !model.success) {
            
#if DEBUG
            NSLog(@"error is: %@",error);
            NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSString *c = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"info is: \n%@\n",c);
            
#endif
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
            hud.label.text = @"请求失败";
            [hud hideAnimated:true afterDelay:0.7];
        }else{
            self.dataModel = model.data;
            
            if (pageNum == 0) {
                self.msgList = [[NSMutableArray alloc]initWithArray:model.data.list];
            }else{
                [self.msgList addObjectsFromArray:model.data.list];
            }
            
            if (model.data.list.count > 0) {
                self.pageNum = [model.data.pageNum integerValue];
                if (!self.tableView.footer) {
                    [self addFooterRefreshView:self.tableView];
                }
            }else if (_pageNum == 0 ){
                //没有数据
                self.noDataView.frame = self.view.bounds;
                [self.view addSubview:self.noDataView];
            }
            
            [self.tableView reloadData];
            
        }
    }];
}


#pragma mark - tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _msgList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EAMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"msg_cell"];
    
    EAMessageDataListModel *model = _msgList[indexPath.row];
    
    [cell updateWithModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 81;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    EAMessageDataListModel *model = _msgList[indexPath.row];
    if (!model) {
        return;
    }
    EAMsgDetailViewController *controller = [[EAMsgDetailViewController alloc]initWithStyle:UITableViewStyleGrouped];
    controller.hidesBottomBarWhenPushed = true;
    controller.msgModel = model;
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
