//
//  EAUserSearchViewController.m
//  EISAir
//
//  Created by chunhui on 2017/8/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAUserSearchViewController.h"
#import "EAUserSearchHeader.h"


@interface EAUserSearchViewController ()<UITextFieldDelegate>

@property(nonatomic , strong) NSArray *pinyinArray;
@property(nonatomic , strong) NSDictionary *nameDict;
@property(nonatomic , strong) EAUserSearchHeader *searchHeader;

@end

@implementation EAUserSearchViewController

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
    // Do any additional setup after loading the view.
    self.title = @"交接给";
 
    [self initNavbar];
    
    _searchHeader = [[EAUserSearchHeader alloc]initWithFrame:CGRectMake(0,0 , SCREEN_WIDTH,40 )];
    _searchHeader.searchBar.delegate = self;
    self.tableView.tableHeaderView = _searchHeader;
    
    
//    [self test];
}

-(void)test
{
    NSMutableArray *py = [[NSMutableArray alloc] init];
    for (int i = 'A' ; i <= 'Z'; i++) {
        [py addObject:[NSString stringWithFormat:@"%c",i]];
    }
    self.pinyinArray = py;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    NSArray *names = @[@"aaa",@"bbb",@"ccc",@"ddd",@"eee"];
    for (NSString *n in py) {
        dict[n] = names;
    }
    self.nameDict = dict;
}

-(void)finishAction:(id)sender
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_pinyinArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = _pinyinArray[section];
    NSArray *values = _nameDict[key];
    return [values count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor themeBlackColor];
        cell.textLabel.font =[UIFont systemFontOfSize:15];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.backgroundColor = [UIColor themeRedColor];
    }
    
    NSString *key = _pinyinArray[indexPath.section];
    NSArray *values = _nameDict[key];
    cell.textLabel.text = values[indexPath.row];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *key = _pinyinArray[section];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor blackColor];//HexColor(0x00b0ce);
    label.text = key;
    [label sizeToFit];
    label.left = 16.5;
    label.centerY = 14;
    
    UIView *header = [[UIView alloc]init];
    [header addSubview:label];
    header.backgroundColor = HexColor(0xf7f7f7);
    
    return header;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _pinyinArray;
}

#pragma mark - search bar
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    return true;
}

@end
