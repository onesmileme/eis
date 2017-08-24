//
//  EAMessageFilterView.m
//  EISAir
//
//  Created by chunhui on 2017/8/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMessageFilterView.h"
#import "EAMessageFilterCollectionViewCell.h"
#import "EAMessageFilterHeaderView.h"

@interface EAMessageFilterView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic , strong) UICollectionView *collectionView;

@end

@implementation EAMessageFilterView

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
        UINib *nib = [UINib nibWithNibName:@"EAMessageFilterCollectionViewCell" bundle:nil];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:@"cellid"];
        
        [self.collectionView registerClass:[EAMessageFilterHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
        
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
//        button.layer.borderColor = [HexColor(0x11bbf2) CGColor];
//        button.layer.borderWidth = 0.5;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(_collectionView.centerX, _collectionView.bottom, _collectionView.width/2, self.height - _collectionView.bottom);
        [self addSubview:button];
    }
    return self;
}

-(void)resetAction
{
    
}

-(void)confirmAction
{
    if (_confirmBlock) {
        _confirmBlock();
    }
    [self hide];
}

-(void)showInView:(UIView *)v 
{
    [v addSubview:self];
}

-(void)hide
{
    [self removeFromSuperview];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EAMessageFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.titleLabel.text = @"标签标签";
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    EAMessageFilterHeaderView *headView = (EAMessageFilterHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                            withReuseIdentifier:@"UICollectionViewHeader"
                                                                                   forIndexPath:indexPath];
    headView.backgroundColor = [UIColor whiteColor];
    [headView updateTitle:@"通知标签" showTopLine:indexPath.section != 0];
    
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
    return CGSizeMake(80, 35);
}

 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 12;
}

/*
;
 - (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

 */

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
