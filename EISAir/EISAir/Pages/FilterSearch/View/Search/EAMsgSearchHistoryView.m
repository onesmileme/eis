//
//  EAMsgSearchHistoryView.m
//  EISAir
//
//  Created by chunhui on 2017/9/16.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMsgSearchHistoryView.h"
#import "EAMsgSearchHistoryHeaderView.h"
#import "NSString+TKSize.h"

@interface EAMsgSearchHistoryView() <UICollectionViewDelegate , UICollectionViewDataSource>

@property(nonatomic , strong) UICollectionView *contentView;
@property(nonatomic , strong) NSArray *keys;

@end

@implementation EAMsgSearchHistoryView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 16;
        layout.minimumInteritemSpacing = 16;
        layout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        _contentView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _contentView.delegate = self;
        _contentView.dataSource = self;
        _contentView.backgroundColor = [UIColor whiteColor];
        
        [_contentView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell_id"];
        [self.contentView registerClass:[EAMsgSearchHistoryHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
        [self addSubview:_contentView];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)clearAction
{
    if (_clearBlock) {
        _clearBlock();
    }
}

-(void)updateWithKeys:(NSArray *)keys
{
    self.keys = keys;
    [self.contentView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _keys.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_id" forIndexPath:indexPath ];
    UILabel *l = [cell.contentView viewWithTag:100];
    if (!l) {
        l = [[UILabel alloc]initWithFrame:cell.contentView.bounds];
        l.textAlignment = NSTextAlignmentCenter;
        l.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        l.textColor = HexColor(0xb0b0b0);
        l.font = SYS_FONT(12);
        [cell.contentView addSubview:l];
    }
    l.text = _keys[indexPath.item];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    EAMsgSearchHistoryHeaderView *headView = (EAMsgSearchHistoryHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                                                withReuseIdentifier:@"UICollectionViewHeader"
                                                                                                                       forIndexPath:indexPath];
    if (!headView.removeBlock) {
        __weak typeof(self) wself = self;
        headView.removeBlock = ^{
            [wself clearAction];
        };
    }
    headView.backgroundColor = [UIColor whiteColor];
    return headView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{

    return CGSizeMake(collectionView.width, 52);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = _keys[indexPath.item];
    CGSize size =  [key sizeWithMaxWidth:self.width - 100 font:SYS_FONT(14)];
    return CGSizeMake(size.width+2, size.height+2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSArray<NSIndexPath *>* selectedItems = collectionView.indexPathsForSelectedItems;
//    for (NSIndexPath *path in selectedItems) {
//        if (path.section == indexPath.section) {
//            [collectionView deselectItemAtIndexPath:path animated:false];
//        }
//    }
//
//    return true;
//}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_chooseBlock) {
        NSString *key = _keys[indexPath.item];
        _chooseBlock(key);
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
