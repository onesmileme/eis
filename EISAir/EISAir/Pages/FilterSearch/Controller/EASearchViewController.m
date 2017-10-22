//
//  EASearchViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EASearchViewController.h"
#import "EAMessageSearchFilterView.h"
#import "EAScanViewController.h"
#import "EAMsgSearchHistoryView.h"
#import "TKRequestHandler+Search.h"
#import "TKRequestHandler+Message.h"
#import "EAMessageFilterResultViewController.h"
#import "EAMsgSearchFilterHeaderView.h"
#import "EAMsgSearchFilterTableViewCell.h"

@interface EASearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong) UITableView *tableView;
@property(nonatomic , strong) UITextField *searchBar;
@property(nonatomic , strong) EAMsgSearchHistoryView *historyView;
@property(nonatomic , strong) NSMutableArray *historyKeys;
@property(nonatomic , strong) NSMutableArray *objList;
@property(nonatomic , copy)   NSString *searchKey;
@property(nonatomic , weak)   NSURLSessionDataTask *task;

@property(nonatomic , strong) EAMsgSearchFilterHeaderView *header;
@property(nonatomic , assign) BOOL checkAll;
@property(nonatomic , strong) NSMutableDictionary *chooedIndexDict;
@property(nonatomic , strong) UIButton *confirmButton;
@property(nonatomic , assign) BOOL isSug;
@property(nonatomic , strong) NSMutableArray *sugList;

@end

@implementation EASearchViewController


-(void)initNavbar
{
    _searchBar = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 33)];
    _searchBar.borderStyle = UITextBorderStyleNone;
    _searchBar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    _searchBar.layer.cornerRadius = 4;
    _searchBar.layer.masksToBounds = true;
    _searchBar.delegate = self;
    _searchBar.returnKeyType = UIReturnKeySearch;
    
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


-(EAMsgSearchHistoryView *)historyView
{
    if (!_historyView) {
        CGRect frame = self.view.bounds;
        __weak typeof(self) wself = self;
        _historyView = [[EAMsgSearchHistoryView alloc]initWithFrame:frame];
        _historyView.clearBlock = ^{
            [wself clearHistory];
        };
        _historyView.chooseBlock = ^(NSString *key) {
            [wself search:key];
            if (wself.historyView.superview) {
                [wself.historyView removeFromSuperview];
                wself.tableView.scrollEnabled = true;
            }
        };
    }
    return _historyView;
}

-(NSString *)cacheKey
{
    NSString *key = [NSString stringWithFormat:@"%@_history_key",self.searchType];    
    return key;
}

-(void)clearHistory
{
    NSString *key = [self cacheKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [self.historyKeys removeAllObjects];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavbar];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 60) style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = HexColor(0xf7f7f7);
    _tableView.allowsMultipleSelection = true;
    
    NSString *key = [self cacheKey];
    self.historyKeys = [[NSMutableArray alloc]init];
    NSArray *keys = [[NSUserDefaults standardUserDefaults] arrayForKey:key];
    
    [self.historyKeys addObjectsFromArray:keys];
            
    if (keys.count > 0) {
        [self.historyView updateWithKeys:keys];
        [self.tableView addSubview:self.historyView];
        self.tableView.scrollEnabled = false;
    }
    
    _objList = [NSMutableArray new];
    UINib *nib = [UINib nibWithNibName:@"EAMsgSearchFilterTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell_id"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"sug_id"];
    
    self.header = [[EAMsgSearchFilterHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width, 34)];
    __weak typeof(self) wself = self;
    _header.checkBlock = ^(BOOL checked) {
        wself.checkAll = checked;
        if (checked) {
            for (NSInteger i = 0 ; i < wself.objList.count ; i++) {
                [wself.chooedIndexDict setObject:@(YES) forKey:@(i)];
                [wself.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:false scrollPosition:UITableViewScrollPositionNone];
            }
        }else{
            [wself.chooedIndexDict removeAllObjects];
            [wself.tableView reloadData];
        }
    };
    
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmButton setBackgroundImage:SYS_IMG(@"message_btn") forState:UIControlStateNormal];
    _confirmButton.frame = CGRectMake(18, self.view.height-50, self.view.width-36, 45);
    _confirmButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    [_confirmButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_tableView];
    [self.view addSubview:_confirmButton];
    
    self.view.backgroundColor = HexColor(0xf7f7f7);
    
    _chooedIndexDict = [NSMutableDictionary new];
    _sugList = [NSMutableArray new];
    
    _confirmButton.hidden = true;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSUserDefaults standardUserDefaults] setObject:self.historyKeys forKey:[self cacheKey]];
}

-(void)confirmAction:(id)sender
{

    if (_chooseItemsBlock) {
        NSMutableArray *items = [[NSMutableArray alloc]init];
        for (NSString *key in [_chooedIndexDict allKeys]) {
            if ([_chooedIndexDict[key] boolValue]) {
                NSInteger index = [key integerValue];
                EAMsgSearchTipDataModel *m = _objList[index];
                [items addObject:m];
            }
        }
        
        _chooseItemsBlock(items);
    }
    
    [self.navigationController popViewControllerAnimated:true];
}

-(void)scanAction:(id)sender
{
    EAScanViewController *controller = [EAScanViewController scanController];
    
    __weak typeof(self) wself = self;
    controller.doneBlock = ^(NSString *urlcode) {
        //TODO dosearch
        if (wself.searchObjBlock) {
            wself.searchObjBlock(urlcode);
        }
        [wself.navigationController popViewControllerAnimated:true];
    };
    [self.navigationController pushViewController:controller animated:true];
}

-(void)search:(NSString *)text
{
    if (text.length == 0) {
        return;
    }
    if (self.task.state == NSURLSessionTaskStateRunning) {
        [self.task cancel];
    }
    
    [self addSearchKey:text];
    
    EAMsgFilterModel *filterModel = [[EAMsgFilterModel alloc]init];
    filterModel.objName = text;
    NSURLSessionDataTask *task = [[TKRequestHandler sharedInstance] searchWithFilterParam:filterModel completion:^(NSURLSessionDataTask *task, EAMsgSearchTipModel *model, NSError *error) {
        if (model.data.count > 0) {
            self.searchKey = text;
            [self.objList removeAllObjects];
            [self.objList addObjectsFromArray:model.data];
            [self.tableView reloadData];
            self.tableView.tableHeaderView = self.header;
            self.confirmButton.hidden = false;
        }else{
            self.tableView.tableHeaderView = nil;
            [EATools showToast:@"未搜索到结果"];
        }
    }];
    self.task = task;
}

-(void)sugSearch:(NSString *)input
{
    
}

-(void)addSearchKey:(NSString *)key
{
    NSInteger index =-1;
    for (NSInteger i = 0 ; i  < self.historyKeys.count ; i++) {
        NSString *str = self.historyKeys[i];
        if ([str isEqualToString:key]) {
            index = i;
            break;
        }
    }
    if (index >= 0) {
        [self.historyKeys removeObjectAtIndex:index];
    }
    [self.historyKeys insertObject:key atIndex:0];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSug) {
        return [_sugList count];
    }
    return [_objList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (_isSug) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"sug_id"];

//        UIView *split = [cell.contentView viewWithTag:100];
//        if (!split) {
//            split = [[UIView alloc]initWithFrame:CGRectMake(0, 42, self.view.width, 0.5)];
//            split.backgroundColor = HexColor(0xf3f3f3);
//            split.tag = 100;
//            [cell.contentView addSubview:split];
//        }
        EAMsgSearchTipDataModel *model = _objList[indexPath.row];
        cell.textLabel.attributedText = [self titleFor:model.objName];
        
    }else{
       
        EAMsgSearchFilterTableViewCell *fcell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
        if (!fcell.chooseBlock) {
            __weak typeof(self) wself = self;
            fcell.chooseBlock = ^(EAMsgSearchFilterTableViewCell *c, id model, BOOL checked) {
                NSInteger index = [wself.tableView indexPathForCell:c].row;
                wself.chooedIndexDict[@(index)] = @(checked);
            };
        }
        
        EAMsgSearchTipDataModel *model = _objList[indexPath.row];
        BOOL check = [self.chooedIndexDict[@(indexPath.row)] boolValue];
        [fcell updateTitle:model.objName msg:model.objDesc checked:check];
        
        cell = fcell;
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isSug) {
        NSString *key = self.searchBar.text;
        [self search:key];
    }else{
        self.chooedIndexDict[@(indexPath.row)] = @(YES);
    }
    
//    //show detail
//    EAMsgSearchTipDataModel *model = _objList[indexPath.row];
//    
//    EAMessageFilterResultViewController *controller = [[EAMessageFilterResultViewController alloc]init];
//    EAMsgFilterModel *filterModel = [[EAMsgFilterModel alloc]init];
//    filterModel.objList = @[model.objId];
//    [self.navigationController pushViewController:controller animated:true];    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isSug) {
        self.chooedIndexDict[@(indexPath.row)] = @(NO);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isSug) {
        return 42.5;
    }
    return 65;
}

-(NSAttributedString *)titleFor:(NSString *)objName
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:objName attributes:@{NSFontAttributeName:SYS_FONT(14),NSForegroundColorAttributeName:HexColor(0x2a2a2a)}];
    NSDictionary *dict = @{NSForegroundColorAttributeName:HexColor(0xb0b0b0)};
    for (NSInteger i = 0 ; i < objName.length ; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *sub = [objName substringWithRange:range];
        if ([self.searchKey containsString:sub]) {
            [title addAttributes:dict range:range];
        }
    }
    
    return title;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_isSug) {
        return CGFLOAT_MIN;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark - uitextfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.historyView.superview) {
        [self.historyView removeFromSuperview];
        self.tableView.scrollEnabled = true;
    }
    
    return true;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _isSug = true;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *content = [[NSMutableString alloc]initWithString:textField.text ];
    
    [content replaceCharactersInRange:range withString:string];
    
    [self sugSearch:content];
    
    return true;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    _isSug = false;
    [self search:textField.text];
    [textField resignFirstResponder];
    return true;
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
