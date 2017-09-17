//
//  EAEnergyTableView.m
//  EISAir
//
//  Created by DoubleHH on 2017/9/17.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAEnergyTableView.h"
#import "EAEnergyCell.h"

@interface EAEnergyTableView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation EAEnergyTableView {
    NSArray *_dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)updateData:(NSArray *)data {
    _dataArray = data;
    [self reloadData];
}

#pragma mark - TableView Delegate/DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [EAEnergyCell cellHeightWithModel:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    EAEnergyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[EAEnergyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setModel:_dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.clickBlock) {
        self.clickBlock(indexPath.row);
    }
}

@end
