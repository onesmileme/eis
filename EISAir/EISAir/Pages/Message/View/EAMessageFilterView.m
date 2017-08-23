//
//  EAMessageFilterView.m
//  EISAir
//
//  Created by chunhui on 2017/8/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMessageFilterView.h"
#import "EAMessageFilterCollectionViewCell.h"


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
        
        _collectionView = [[UICollectionView alloc]initWithFrame:f collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        UINib *nib = [UINib nibWithNibName:@"EAMessageFilterCollectionViewCell" bundle:nil];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:@"cellid"];
        [self addSubview:_collectionView];
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
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

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *v = [[UICollectionReusableView alloc]initWithFrame:CGRectMake(0, 0, collectionView.width, 30)];
    v.backgroundColor = [UIColor redColor];
    return v;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
