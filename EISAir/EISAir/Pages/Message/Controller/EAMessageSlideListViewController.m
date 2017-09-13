//
//  EAMessageSlideListViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMessageSlideListViewController.h"
#import "TMCache.h"
#import "EAMessageTableViewCell.h"
#import "EAMessageModel.h"
#import "TKRequestHandler+Message.h"
#import "TKAccountManager.h"
#import <MJRefresh.h>
#import "EAMessageNoDataView.h"

@interface EAMessageSlideListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *msgListTableView;
@property(nonatomic , strong) NSMutableArray *msgList;
@property(nonatomic , strong) NSArray *types;

@property(nonatomic , strong) EAMessageNoDataView *noDataView;

@property(nonatomic , strong) EAMessageDataModel *dataModel;
@property(nonatomic , strong) NSMutableDictionary *filterDict;
@property(nonatomic , strong) EAMsgFilterModel *filterModel;
@property(nonatomic , assign) NSInteger pageNum;

@end

@implementation EAMessageSlideListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect frame = self.view.bounds;
    frame.size.height -= 49+25;
    
    _msgListTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    _msgListTableView.delegate = self;
    _msgListTableView.dataSource = self;
//    _msgListTableView.contentInset = UIEdgeInsetsMake(0, 0, 51, 0);
    _msgListTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    _msgListTableView.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
    
    UINib *nib = [UINib nibWithNibName:@"EAMessageTableViewCell" bundle:nil];
    [_msgListTableView registerNib:nib forCellReuseIdentifier:@"msg_cell"];
    
    [self.view addSubview:_msgListTableView];
    
    [self addHeaderRefreshView:_msgListTableView];
    
    _msgList = [[NSMutableArray alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_types && self.msgList.count == 0 && ![self.msgListTableView.header isRefreshing]) {
        [self startHeadRefresh:self.msgListTableView];
    }
    
}

-(EAMessageNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [EAMessageNoDataView view];
        __weak typeof(self) wself = self;
        _noDataView.tapBlock = ^{
//            [wself loadMessage:0];
            [wself startHeadRefresh:wself.msgListTableView];
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

-(void)updateCustomConfig:(EAMsgFilterModel *)filterModel
{
    
}

-(void)updateWithType:(NSArray *)types reload:(BOOL)reload
{
    if (![_types isEqual:types]) {
        _pageNum = 0;
        _types = types;
    }
    if (reload && _msgList.count == 0) {
        [self loadMessage:_pageNum];
    }
}

-(void)loadMessageIfNotRequest
{
    
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
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    if (_filterDict) {
        [param addEntriesFromDictionary:_filterDict];
    }
    
    EALoginUserInfoDataModel *udata = [TKAccountManager sharedInstance].loginUserInfo;
    
    if (!_filterModel) {
        _filterModel = [[EAMsgFilterModel alloc]init];
    }
    
    _filterModel.pageNum = @(pageNum).description;
    _filterModel.pageSize = @"20";
    _filterModel.orgId = udata.orgId;
    _filterModel.siteId = udata.siteId;
    if (_types) {
        _filterModel.msgTypes = _types;
    }
    
    
    [[TKRequestHandler sharedInstance] loadMyMessageFilterParam:_filterModel completion:^(NSURLSessionDataTask *task, EAMessageModel *model, NSError *error) {
        
        [self stopRefresh:self.msgListTableView];
        
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
                if (!self.msgListTableView.footer) {
                    [self addFooterRefreshView:self.msgListTableView];
                }
            }else if (_pageNum == 0 ){
                //没有数据
                self.noDataView.frame = self.view.bounds;
                [self.view addSubview:self.noDataView];
            }
            
            [self.msgListTableView reloadData];
            
            NSLog(@"type is: %@ \n model is: \n%@\n",self.types,model);
            
        }        
    }];
}


#pragma mark - tableview delegate
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    if (_showMessageBlock) {
        EAMessageDataListModel *model = _msgList[indexPath.row];
        _showMessageBlock(model);
    }
}

#pragma mark - cache
-(NSString *)cacheKey
{
    NSString *key = [_types componentsJoinedByString:@"_"];
    return [NSString stringWithFormat:@"my_message_%@",key];
}

-(void)saveCurrentNews
{
    if ([_msgList count] > 0) {
        
        TMCache *cacher = [TMCache sharedCache];
        NSString *key = [self cacheKey];
        if (key) {
            NSArray *list = [NSArray arrayWithArray:_msgList];
            
            [cacher setObject:list forKey:key block:^(TMCache *cache, NSString *key, id object) {
                
            }];
        }
    }
}

-(void)loadCache
{
    TMCache *cacher = [TMCache sharedCache];
    NSString *key = [self cacheKey];
    if (key) {
        __weak typeof(self) wself = self;
        [cacher objectForKey:key block:^(TMCache *cache, NSString *key, id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (wself && [[wself cacheKey]isEqualToString:key]){
                    //是当前要加载的缓存
                    [wself.msgList removeAllObjects];
                    
                    if ([object isKindOfClass:[NSArray class]]) {
                        [wself.msgList addObjectsFromArray:object];
                    }
                    
                    [wself.msgListTableView reloadData];
                }
            });
        }];
    }
}

-(void)removeCache
{
    NSString *key = [self cacheKey];
    if (key) {
        TMCache *cacher = [TMCache sharedCache];
        [cacher removeObjectForKey:key];
    }
}

@end
