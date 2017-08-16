//
//  PickerCollectionView.m
//  相机
//
//  Created by 张磊 on 14-11-11.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import "ZLPhotoPickerCollectionView.h"
#import "ZLPhotoPickerCollectionViewCell.h"
#import "ZLPhotoPickerImageView.h"
#import "ZLPhotoPickerFooterCollectionReusableView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZLPhotoAssets.h"
#import "ZLPhoto.h"

@interface ZLPhotoPickerCollectionView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic , strong) ZLPhotoPickerFooterCollectionReusableView *footerView;

// 判断是否是第一次加载
@property (nonatomic , assign , getter=isFirstLoadding) BOOL firstLoadding;

@end

@implementation ZLPhotoPickerCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate = self;
        _selectAssets = [NSMutableArray array];
    }
    return self;
}

#pragma mark -getter
- (NSMutableArray *)selectsIndexPath
{
    if (!_selectsIndexPath) {
        _selectsIndexPath = [NSMutableArray array];
    }
    
    if (_selectsIndexPath) {
        NSSet *set = [NSSet setWithArray:_selectsIndexPath];
        _selectsIndexPath = [NSMutableArray arrayWithArray:[set allObjects]];
    }
    return _selectsIndexPath;
}

#pragma mark -setter
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    // 需要记录选中的值的数据
    if (self.isRecoderSelectPicker){
        NSMutableArray *selectAssets = [NSMutableArray array];
        for (ZLPhotoAssets *asset in self.selectAssets) {
            for (ZLPhotoAssets *asset2 in self.dataArray) {
                
                if ([asset isKindOfClass:[UIImage class]] || [asset2 isKindOfClass:[UIImage class]]) {
                    continue;
                }
                if ([asset.asset.defaultRepresentation.url isEqual:asset2.asset.defaultRepresentation.url]) {
                    [selectAssets addObject:asset2];
                    break;
                }
            }
        }
        _selectAssets = selectAssets;
    }
    
    [self reloadData];
}

#pragma mark -<UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZLPhotoPickerCollectionViewCell *cell = nil;
    if(indexPath.item == 0 && self.topShowPhotoPicker){
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cameraCellIdentifier forIndexPath:indexPath];
        
        UIImage *image = self.cameraImage;
        if (!image) {
            image = [UIImage imageNamed:@"camera"];
        }
        [cell updateForCamera:image];
        
    }else{
        
        cell =  [ZLPhotoPickerCollectionViewCell cellWithCollectionView:collectionView cellForItemAtIndexPath:indexPath];
        if (!cell.switchSelectBlock) {
            //切换选择不选择
            __weak typeof(self) wself = self;
            cell.switchSelectBlock = ^(ZLPhotoPickerCollectionViewCell *photoCell){
                NSIndexPath *ipath = [wself indexPathForCell:photoCell];
                [wself changePhotoSelect:ipath];
            };
        }
        
        // 需要记录选中的值的数据
        if (self.isRecoderSelectPicker) {
            for (ZLPhotoAssets *asset in self.selectAssets) {
                if ([asset.asset.defaultRepresentation.url isEqual:[self.dataArray[indexPath.item] asset].defaultRepresentation.url]) {
                    [self.selectsIndexPath addObject:@(indexPath.row)];
                }
            }
        }
        
        ZLPhotoAssets *asset = self.dataArray[indexPath.item];
        BOOL selected = ([self.selectsIndexPath containsObject:@(indexPath.row)]);
        [cell updateWithAssets:asset selected:selected];
    }
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.topShowPhotoPicker && indexPath.item == 0) {
        
        if ([self checkOverMax]) {
            return;
        }
        if ([self.collectionViewDelegate respondsToSelector:@selector(pickerCollectionViewDidCameraSelect:)]) {
            [self.collectionViewDelegate pickerCollectionViewDidCameraSelect:self];
        }
        
    }else if ([self.collectionViewDelegate respondsToSelector:@selector(pickerCollectionView:browseAtIndexPath:)]) {
        [self.collectionViewDelegate pickerCollectionView:self browseAtIndexPath:indexPath];
    }
}

#pragma mark 底部View
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ZLPhotoPickerFooterCollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionFooter) {
        ZLPhotoPickerFooterCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        footerView.count = self.dataArray.count;
        reusableView = footerView;
        self.footerView = footerView;
    }else{
        
    }
    return reusableView;
}

-(BOOL)checkOverMax
{
    NSUInteger minCount = (self.minCount < 0) ? KPhotoShowMaxCount :  self.minCount;
    if (self.selectAssets.count >= minCount) {
        NSString *format = [NSString stringWithFormat:@"最多选择%zd张图片",minCount];
        if (minCount == 0) {
            format = [NSString stringWithFormat:@"您已经选满了图片"];
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:format delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alertView show];
        return true;
    }
    return false;
}

-(void)changePhotoSelect:(NSIndexPath *)indexPath
{
    if (self.topShowPhotoPicker && indexPath.item == 0) {
        
        if ([self checkOverMax]) {
            return;
        }
        if ([self.collectionViewDelegate respondsToSelector:@selector(pickerCollectionViewDidCameraSelect:)]) {
            [self.collectionViewDelegate pickerCollectionViewDidCameraSelect:self];
        }
        return ;
    }
    
    if (!self.lastDataArray) {
        self.lastDataArray = [NSMutableArray array];
    }
    
    ZLPhotoPickerCollectionViewCell *cell = (ZLPhotoPickerCollectionViewCell *) [self cellForItemAtIndexPath:indexPath];
    
    ZLPhotoAssets *asset = self.dataArray[indexPath.row];
    
    BOOL choosedImage = [cell isSelectedImage];
    
    // 如果没有就添加到数组里面，存在就移除
    if (choosedImage) {
        
        [self.selectsIndexPath removeObject:@(indexPath.row)];
        [self.selectAssets removeObject:asset];
        [self.lastDataArray removeObject:asset];
        
    }else{
        
        // 1 判断图片数超过最大数或者小于0
        if ([self checkOverMax]) {
            return;
        }
        
        [self.selectsIndexPath addObject:@(indexPath.row)];
        [self.selectAssets addObject:asset];
        [self.lastDataArray addObject:asset];
        
    }
    
    // 告诉代理现在被点击了!
    if ([self.collectionViewDelegate respondsToSelector:@selector(pickerCollectionViewDidSelected: deleteAsset:)]) {
        if (choosedImage) {
            // 删除的情况下
            [self.collectionViewDelegate pickerCollectionViewDidSelected:self deleteAsset:asset];
        }else{
            [self.collectionViewDelegate pickerCollectionViewDidSelected:self deleteAsset:nil];
        }
    }
    
    [cell selectImage:!choosedImage];

}


- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    self.firstLoadding = YES;
    
//    // 时间置顶的话
//    if (self.status == ZLPickerCollectionViewShowOrderStatusTimeDesc) {
//        if (!self.firstLoadding && self.contentSize.height > [[UIScreen mainScreen] bounds].size.height) {
//            // 滚动到最底部（最新的）
//            [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.dataArray.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
//            // 展示图片数
//            self.contentOffset = CGPointMake(self.contentOffset.x, self.contentOffset.y + 100);
//            self.firstLoadding = YES;
//        }
//    }else if (self.status == ZLPickerCollectionViewShowOrderStatusTimeAsc){
//        // 滚动到最底部（最新的）
//        if (!self.firstLoadding && self.contentSize.height > [[UIScreen mainScreen] bounds].size.height) {
//            [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
//            // 展示图片数
//            self.contentOffset = CGPointMake(self.contentOffset.x, -self.contentInset.top);
//            self.firstLoadding = YES;
//        }
//    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
