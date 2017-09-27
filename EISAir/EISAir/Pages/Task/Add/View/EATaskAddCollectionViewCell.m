//
//  EATaskAddCollectionViewCell.m
//  EISAir
//
//  Created by chunhui on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskAddCollectionViewCell.h"
#import "EAAddTaskInputCell.h"
#import "EAAddTaskDateCell.h"
#import "TPKeyboardAvoidingTableView.h"
#import "EATaskItemModel.h"

@interface EATaskAddCollectionViewCell ()<UITableViewDelegate ,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic , strong) UITableView *tableView;
@property(nonatomic , strong) EATaskItemDataModel *model;

@end

@implementation EATaskAddCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTableview];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupTableview];
    }
    return self;
}

-(void)setupTableview
{
    _tableView = [[TPKeyboardAvoidingTableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    
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
    
    [self.contentView addSubview:_tableView];
}

-(void)updateWithModel:(EATaskItemDataModel *)model
{
    self.model = model;
    [self.tableView reloadData];
}

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
                        _model.tagid = content;
                    }
                        break;
                    case EATaskItemTypeTableNum:
                    {
                        // @"表号";
                        _model.objName = content;
                    }
                        break;
                    case EATaskItemTypeBeilv:
                    {
                        // @"倍率";
                        _model.rate = content;
                    }
                        break;
                    case EATaskItemTypeAmount:
                    {
                        // @"用量";
                        _model.consumption = content;
                    }
                        break;
                    case EATaskItemTypeLastAmount:
                    {
                        // @"上次用量";
                        _model.lastConsumption = content;
                    }
                        break;
                    case EATaskItemTypeThisAmountDays:
                    {
                        // @"本次用量日数";
                        _model.consumptionDays = content;
                    }
                        break;
                    case EATaskItemTypeLastAmountDays:
                    {
                        // @"上次用量日数";
                        _model.lastConsumptionDays = content;
                    }
                        break;
                    case EATaskItemTypeThisNum:
                    {
                        // @"本次读数";
                        _model.readCount = content;
                    }
                        break;
                    case EATaskItemTypeLastNum:
                    {
                        // @"上次读数";
                        _model.value = content;
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
                content = _model.tagid;
            }
                break;
            case EATaskItemTypeTableNum:
            {
                title = @"表号";
                content = _model.objName;
            }
                break;
            case EATaskItemTypeBeilv:
            {
                title = @"倍率";
                content = _model.rate;
            }
                break;
            case EATaskItemTypeAmount:
            {
                title = @"用量";
                content = _model.consumption;
            }
                break;
            case EATaskItemTypeLastAmount:
            {
                title = @"上次用量";
                content = _model.lastConsumption;
            }
                break;
            case EATaskItemTypeThisAmountDays:
            {
                title = @"本次用量日数";
                content = _model.consumptionDays;
            }
                break;
            case EATaskItemTypeLastAmountDays:
            {
                title = @"上次用量日数";
                content = _model.lastConsumptionDays;
            }
                break;
            case EATaskItemTypeThisNum:
            {
                title = @"本次读数";
                content = _model.readCount;
            }
                break;
            case EATaskItemTypeLastNum:
            {
                title = @"上次读数";
                content = _model.value;
            }
                break;
            default:
                break;
        }
        cell.titleLabel.text = title;
        cell.contentField.text = content;
        
        if (indexPath.row == EATaskItemTypeThisNum) {
            cell.contentField.enabled = true;
        }else{
            cell.contentField.enabled = false;
        }
        
        
        c = cell;
        
    }else{
        EAAddTaskDateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.contentField.tag = indexPath.row;
        if (!cell.chooseDate) {
            cell.chooseDate = ^(EAAddTaskDateCell *cell ,NSDate *date) {
                NSString *content = [TKCommonTools dateStringWithFormat:TKDateFormatChineseShortYMD date:date];
                switch (cell.tag) {
                    case EATaskItemTypeDate:
                    {
                        // @"抄表日期";
                        _model.meterDate = content;
                    }
                        break;
                    case EATaskItemTypeLastDate:
                    {
                        // @"上次抄表日期";
                        _model.lastMeterDate = content ;
                    }
                        break;
                    case EATaskItemTypeMonth:
                    {
                        // @"本次用量结算月份";
                        NSArray *components = [content componentsSeparatedByString:@"-"];
                        if (components.count > 2) {
                            content = [NSString stringWithFormat:@"%@-%@",components[0],components[1]];
                        }
                        _model.settlementMonth = content;
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
                content = _model.meterDate;
            }
                break;
            case EATaskItemTypeLastDate:
            {
                title = @"上次抄表日期";
                content = _model.lastMeterDate;
            }
                break;
            case EATaskItemTypeMonth:
            {
                title = @"本次用量结算月份";
                content = _model.settlementMonth;
            }
                break;
                
            default:
                break;
        }
        
        cell.contentField.text = content;
        cell.titleLabel.text = title;
        
        if (indexPath.row == EATaskItemTypeDate) {
            cell.contentField.enabled = true;
        }else{
            cell.contentField.enabled = false;
        }
        
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



@end
