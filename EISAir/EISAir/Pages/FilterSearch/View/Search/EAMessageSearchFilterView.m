//
//  EAMessageSearchFilterView.m
//  EISAir
//
//  Created by chunhui on 2017/8/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMessageSearchFilterView.h"
#import "EAMsgSearchFilterHeaderView.h"
#import "EAMsgSearchFilterTableViewCell.h"

@interface EAMessageSearchFilterView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong) UITableView *tableView;
@property(nonatomic , strong) UIButton *confirmButton;
@property(nonatomic , strong) NSArray *items;
@property(nonatomic , strong) EAMsgSearchFilterHeaderView *header;
@property(nonatomic , strong) NSMutableDictionary *chooedIndexDict;
@property(nonatomic , assign) BOOL checkAll;

@end

@implementation EAMessageSearchFilterView

-(instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect f = self.bounds;
        f.size.height -= 55;
        _tableView = [[UITableView alloc]initWithFrame:f style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.allowsSelection = false;
        _tableView.backgroundColor = HexColor(0xf7f7f7);
        
        UINib *nib = [UINib nibWithNibName:@"EAMsgSearchFilterTableViewCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"cell_id"];
        
        _header = [[EAMsgSearchFilterHeaderView alloc]initWithFrame:CGRectMake(0, 0, _tableView.width, 34)];
        __weak typeof(self) wself = self;
        _header.checkBlock = ^(BOOL checked) {
            wself.checkAll = checked;
            if (checked) {
                for (NSInteger i = 0 ; i < wself.items.count ; i++) {
                    [wself.chooedIndexDict setObject:@(YES) forKey:@(i)];
                }
                [wself.tableView reloadData];
            }
        };
        _tableView.tableHeaderView = _header;
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setBackgroundImage:SYS_IMG(@"message_btn") forState:UIControlStateNormal];
        _confirmButton.frame = CGRectMake(18, self.height-50, self.width-36, 45);
        [_confirmButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_tableView];
        [self addSubview:_confirmButton];
        
        self.items = items;
        _chooedIndexDict = [[NSMutableDictionary alloc]initWithCapacity:items.count];
    }
    return self;
}

-(NSArray *)choosedItems
{
    if (_checkAll) {
        return _items;
    }
    NSMutableArray *citems = [[NSMutableArray alloc]initWithCapacity:_items.count];
    for (NSInteger i = 0 ; i < _items.count ; i++) {
        if ([_chooedIndexDict[@(i)] boolValue]) {
            [citems addObject:_items[i]];
        }
    }
    return citems;
}

-(void)confirmAction:(id)sender
{
    if (_confirmBlock) {
        _confirmBlock(self);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EAMsgSearchFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (!cell.chooseBlock) {
        __weak typeof(self) wself = self;
        cell.chooseBlock = ^(EAMsgSearchFilterTableViewCell *c, id model, BOOL checked) {
            NSInteger index = [wself.tableView indexPathForCell:c].row;
            wself.chooedIndexDict[@(index)] = @(checked);
        };
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
