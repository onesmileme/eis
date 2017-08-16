//
//  PickerCollectionViewCell.m
//  相机
//
//  Created by 张磊 on 14-11-11.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import "ZLPhotoPickerCollectionViewCell.h"

@interface ZLPhotoPickerCollectionViewCell ()

@property(nonatomic , strong) ZLPhotoPickerImageView *contentImgView;
@property(nonatomic , strong) UIImageView *cameraImageView;

@end

@implementation ZLPhotoPickerCollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLPhotoPickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
}

-(ZLPhotoPickerImageView *)contentImgView
{
    if (!_contentImgView) {
        _contentImgView = [[ZLPhotoPickerImageView alloc]initWithFrame:self.bounds];
        _contentImgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleWidth;
        _contentImgView.maskViewFlag = false;
        _contentImgView.userInteractionEnabled = true;
        __weak typeof(self) wself = self;
        _contentImgView.changeSelectBlock = ^{
            if (wself.switchSelectBlock) {
                wself.switchSelectBlock(wself);
            }
        };
    }
    return _contentImgView;
}

-(UIImageView *)cameraImageView
{
    if (!_cameraImageView) {
        _cameraImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _cameraImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _cameraImageView.contentMode = UIViewContentModeScaleAspectFit;
        _cameraImageView.clipsToBounds = true;
    }
    return _cameraImageView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.contentImgView];
    }
    return self;
}

-(void)updateWithAssets:(ZLPhotoAssets *)asset selected:(BOOL)selected
{
    if (_cameraImageView) {
        [_cameraImageView removeFromSuperview];
    }
    _contentImgView.isVideoType = asset.isVideoType;
    if ([asset isKindOfClass:[ZLPhotoAssets class]]) {
        _contentImgView.image= asset.thumbImage;
    }
    _contentImgView.maskViewFlag = selected;
}

-(void)updateForCamera:(UIImage *)cameraImage
{
    self.cameraImageView.image = cameraImage;
    [self.contentView addSubview:self.cameraImageView];
}

-(void)selectImage:(BOOL)selected
{
    _contentImgView.maskViewFlag = selected;
}

-(BOOL)isSelectedImage
{
    return _contentImgView.isMaskViewFlag;
}



@end

NSString *const cellIdentifier = @"cell";
NSString *const cameraCellIdentifier = @"cameraCell";
