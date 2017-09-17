//
//  EAFilterView.m
//  EISAir
//
//  Created by chunhui on 2017/8/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAFilterView.h"
#import "EAFilterCollectionViewCell.h"
#import "EAFilterHeaderView.h"
#import "EAFilterDateChooseView.h"

@interface EAFilterView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic , strong) UICollectionView *collectionView;
@property(nonatomic , strong) NSArray *tags;
@property(nonatomic , assign) BOOL showDate;
@property(nonatomic , strong) NSArray *dates;
@property(nonatomic , assign) BOOL chooseDate;
@property(nonatomic , strong) EAFilterDateChooseView *chooseDateView;
@property(nonatomic , assign) BOOL showIndicator;

@end

@implementation EAFilterView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        CGRect f = self.bounds;
        f.origin.x = f.size.width/5;
        f.size.width -= f.origin.x;
        f.size.height -= 49;
        
        
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(12, 16, 10, 15);
        _collectionView = [[UICollectionView alloc]initWithFrame:f collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        UINib *nib = [UINib nibWithNibName:@"EAFilterCollectionViewCell" bundle:nil];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:@"cellid"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"date_cell"];
        
        [self.collectionView registerClass:[EAFilterHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
        
        _collectionView.allowsMultipleSelection = true;
        [self addSubview:_collectionView];
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = SYS_FONT(16);
        [button setBackgroundColor:[UIColor whiteColor]];
        button.layer.borderColor = [HexColor(0x11bbf2) CGColor];
        button.layer.borderWidth = 0.5;
        [button setTitleColor:HexColor(0x666666) forState:UIControlStateNormal];
        [button setTitle:@"重置" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(_collectionView.left, _collectionView.bottom, _collectionView.width/2, self.height - _collectionView.bottom);
        
        [self addSubview:button];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = SYS_FONT(16);
        [button setBackgroundColor:HexColor(0x28cfc1)];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(_collectionView.centerX, _collectionView.bottom, _collectionView.width/2, self.height - _collectionView.bottom);
        [self addSubview:button];
        
        _dates = @[@"昨天",@"最近三天",@"本周",@"自定义日期"];

        [self addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)tapAction:(id )sender
{
//    CGPoint location = [gesture locationInView:self];
//    if (!CGRectContainsPoint(self.collectionView.frame, location)) {
        [self hide];
//    }
}

-(void)setType:(NSString *)type
{
    _type = type;
    
}

-(void)updateWithTags:(NSArray *)tags hasDate:(BOOL)showDate showIndicator:(BOOL)showIndicator
{
    _tags = tags;
    _showDate = showDate;
    _showIndicator = showIndicator;
    [self.collectionView reloadData];
}

-(void)resetAction
{
    [self.collectionView reloadData];
    self.chooseDate = NO;
}

-(void)confirmAction
{
    if (_confirmBlock) {
        NSString *item = nil;
        NSDate *startDate = nil;
        NSDate *endDate = nil;
        NSArray *selectedItems = [self.collectionView indexPathsForSelectedItems];
        for (NSIndexPath *indexPath in selectedItems) {
            if (indexPath.section == 0) {
                item = _tags[indexPath.item];
            }else{
                endDate = [NSDate date];
                switch (indexPath.item) {
                    case 0://昨天
                    {                        
                        startDate = [self dateBefore:1 orWeek:0 since:endDate];
                        endDate = [self dateBefore:0 orWeek:-1 since:endDate];
                    }
                        break;
                    case 1:
                    {//最近三天
                        startDate = [self dateBefore:2 orWeek:0 since:endDate];
                    }
                        break;
                    case 2:
                    {//本周
                        startDate = [self dateBefore:-1 orWeek:1 since:endDate];
                    }
                        break;
                    default:
                        //自定义
                    {
                        startDate = _chooseDateView.startDate;
                        endDate = _chooseDateView.toDate;
                    }
                        break;
                }
            }
        }
        _confirmBlock(item,startDate , endDate );
    }
    [self hide];
}

-(NSDate *)dateBefore:(NSInteger)day orWeek:(NSInteger)week since:(NSDate *)date
{
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | kCFCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    NSDate *checkDate = nil;
    NSTimeInterval interval = 0;
    
    if (day >= 0) {
        interval = (24*60*60)*day + (comps.hour*60+comps.minute)*60 + comps.second;
        if (day == 0) {
            interval += 1;
        }
    }else{
        NSInteger weekday = comps.weekday;
        if (weekday == 1) {
            //周日
            weekday = 7;
        }else{
            weekday -= 1;
        }
        interval = ((24*60*60*(weekday-1))+(comps.hour*60+comps.minute)*60)+comps.second;
    }
    checkDate = [date dateByAddingTimeInterval:-interval];
    return checkDate;
}

-(void)showInView:(UIView *)v 
{
    self.chooseDate = NO;
    [v addSubview:self];
    
}

-(void)hide
{
    [self removeFromSuperview];
    self.chooseDate = NO;
}

-(EAFilterDateChooseView *)chooseDateView
{
    if (!_chooseDateView) {
        _chooseDateView = [[EAFilterDateChooseView alloc]initWithFrame:CGRectMake(0, 0, self.collectionView.width - 32, 30)];
    }
    return _chooseDateView;
}

-(void)setChooseDate:(BOOL)chooseDate
{
    _chooseDate = chooseDate;
    if (_chooseDate) {
        CGSize size = self.collectionView.contentSize;
        self.chooseDateView.frame = CGRectMake(16, size.height, self.collectionView.width - 32, 30);
        [_chooseDateView clearDate];
        [self.collectionView addSubview:self.chooseDateView];
    }else{
        [_chooseDateView removeFromSuperview];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return _tags.count;
    }
    NSInteger count = 4;
//    if (_chooseDate) {
//        count++;
//    }
    return count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *c = nil;
    if (indexPath.section == 1 && indexPath.item == _dates.count) {
        c = [collectionView dequeueReusableCellWithReuseIdentifier:@"date_cell" forIndexPath:indexPath];
        [c.contentView addSubview:self.chooseDateView];
        self.chooseDateView.backgroundColor = [UIColor redColor];
    }else{
        EAFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
        NSString *title = nil;
        if (indexPath.section == 0) {
            title = _tags[indexPath.item];
        }else{
            title = _dates[indexPath.item];
        }
        cell.titleLabel.text = title;
        c = cell;
    }
    return c;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger count = 1;
    if (_showDate) {
        count++;
    }
    return count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    EAFilterHeaderView *headView = (EAFilterHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                            withReuseIdentifier:@"UICollectionViewHeader"
                                                                                   forIndexPath:indexPath];
    headView.backgroundColor = [UIColor whiteColor];
    
    NSString *title = indexPath.section == 0 ?self.type:@"时间";
    BOOL showIndicator = _showIndicator && indexPath.section == 0;
    
    [headView updateTitle:title showTopLine:indexPath.section != 0 showIndicator:showIndicator];
    if (_showIndicator) {
        __weak typeof(self) wself = self;
        NSInteger section = indexPath.section;
        headView.tapBlock = ^(EAFilterHeaderView *header) {
            if (wself.tapHeadBlock) {
                wself.tapHeadBlock(self, section);
            }
        };
    }
    
    return headView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat height = 35;
    if (section == 0) {
        height = 40;
    }
    return CGSizeMake(collectionView.width, height);
}

 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && _dates.count == indexPath.item) {
        return CGSizeMake(collectionView.width-32, 30);
    }
    return CGSizeMake(80, 35);
}

 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 12;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray<NSIndexPath *>* selectedItems = collectionView.indexPathsForSelectedItems;
    for (NSIndexPath *path in selectedItems) {
        if (path.section == indexPath.section) {
            [collectionView deselectItemAtIndexPath:path animated:false];
        }
    }
    
    return true;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.item == _dates.count - 1 && indexPath.section == 1) {
        self.chooseDate = true;
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == _dates.count - 1 && indexPath.section == 1) {
        self.chooseDate = false;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
