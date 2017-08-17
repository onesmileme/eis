//
//  EASharePanelView.m
//  FunApp
//
//  Created by liuzhao on 2016/12/1.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "EASharePanelView.h"
#import "EASharePanelCell.h"

#define kButtonHeight 50
#define kCellWidth 76
#define kCellHeight 105

@interface EASharePanelView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *scrollView;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation EASharePanelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titles = [[NSMutableArray alloc] init];
        _images = [[NSMutableArray alloc] init];
        [self setupSubviews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupSubviews
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsZero;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _scrollView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - kButtonHeight) collectionViewLayout:layout];
    _scrollView.delegate = self;
    _scrollView.dataSource = self;
    _scrollView.contentInset = UIEdgeInsetsZero;
    _scrollView.showsHorizontalScrollIndicator = false;
    _scrollView.scrollsToTop = false;
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    [_scrollView registerClass:[EASharePanelCell class] forCellWithReuseIdentifier:@"cell"];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:HexColor(0x666666) forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _cancelButton.frame = CGRectMake(0, _scrollView.bottom, self.bounds.size.width, kButtonHeight);
    [_cancelButton addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_scrollView];
    [self addSubview:_cancelButton];
}

- (void)updateWithTitles:(NSArray *)titles images:(NSArray *)images
{
    [self.titles removeAllObjects];
    [self.images removeAllObjects];
    
    [self.titles addObjectsFromArray:titles];
    [self.images addObjectsFromArray:images];
    
    [_scrollView reloadData];
    [_scrollView layoutIfNeeded];
}

- (void)dismissAction
{
    if (_dismiss) {
        _dismiss();
    }
}

#pragma mark - UICollection delegate and datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  [_titles count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = _titles[indexPath.item];
    UIImage *image = _images[indexPath.item];
    
    EASharePanelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setCellWithTitle:title image:image];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.chooseItem) {
        self.chooseItem(indexPath.item);
    }
}

#pragma mark - flow layout delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kCellWidth, kCellWidth);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return  UIEdgeInsetsZero;
}


@end
