//
//  EATaskSlideListViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskSlideListViewController.h"
#import "TKRequestHandler+Task.h"
#import "EAMessageNoDataView.h"
#import "EATaskInfoTableViewCell.h"
#import "TKAccountManager.h"
#import "MJRefresh.h"

@interface EATaskSlideListViewController ()

@property(nonatomic , strong) NSMutableArray *msgList;
//@property(nonatomic , strong) NSArray *types;

@property(nonatomic , strong) EAMessageNoDataView *noDataView;

@property(nonatomic , strong) EATaskDataModel *dataModel;
@property(nonatomic , strong) EATaskFilterModel *filterModel;
@property(nonatomic , assign) NSInteger pageNum;

@end

@implementation EATaskSlideListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    UINib *nib = [UINib nibWithNibName:@"EATaskInfoTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"task_cell"];
    [self addHeaderRefreshView:self.tableView];
    
    _msgList = [[NSMutableArray alloc]init];
    
    [NotificationCenter addObserver:self selector:@selector(loginDoneNotfiication:) name:kLoginDoneNotification object:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [NotificationCenter removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_taskType && self.msgList.count == 0 && ![self.tableView.header isRefreshing]) {
        [self startHeadRefresh:self.tableView];
    }
}

-(EAMessageNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [EAMessageNoDataView view];
        _noDataView.isTask = YES;
        __weak typeof(self) wself = self;
        _noDataView.tapBlock = ^{            
            [wself startHeadRefresh:wself.tableView];
            [wself.noDataView removeFromSuperview];
        };
    }
    return _noDataView;
}

-(void)pageWillPurge
{
    
}

-(void)pageWillReuse
{
    
}

-(void)pageWillShow
{
    
}

-(BOOL)reuseable
{
    return YES;
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
    if (!_filterModel) {
        _filterModel = [[EATaskFilterModel alloc]init];
        
        EALoginUserInfoDataModel *udata = [TKAccountManager sharedInstance].loginUserInfo;
        _filterModel.pageSize = @"20";
        _filterModel.orgId = udata.orgId;
        _filterModel.siteId = udata.siteId;
    }
    
    _filterModel.pageNum = @(pageNum).description;
    _filterModel.taskTypes = @[self.taskType?:@""];

    [[TKRequestHandler sharedInstance]findMyTask:_filterModel completion:^(NSURLSessionDataTask *task, EATaskModel *model, NSError *error) {
        [self stopRefresh:self.tableView];
        
        if (error || !model.success) {
            
#if DEBUG
            NSLog(@"error is: %@",error);
            NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSString *c = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"info is: \n%@\n",c);
            
#endif
            
            MBProgressHUD *hud = [EATools showLoadHUD:self.view];
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
                if (!model.data.lastPage && !self.tableView.footer) {
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
    EATaskInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"task_cell"];
    
    EATaskDataListModel *model = _msgList[indexPath.row];
    
    [cell updateWithModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EATaskDataListModel *model = _msgList[indexPath.row];
    return [EATaskInfoTableViewCell heightForModel:model];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;//CGFLOAT_MIN;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    if (_showTaskBlock) {
        EATaskDataListModel *model = _msgList[indexPath.row];
        _showTaskBlock(model);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)loginDoneNotfiication:(NSNotification *)notfication
{
    if (_taskType) {
        [self startHeadRefresh:self.tableView];
    }
    
}

@end
