//
//  PickerCollectionViewCell.h
//  相机
//
//  Created by 张磊 on 14-11-11.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPhotoPickerImageView.h"
#import "ZLPhotoAssets.h"
@class UICollectionView;

extern NSString *const cellIdentifier;
extern NSString *const cameraCellIdentifier;

@interface ZLPhotoPickerCollectionViewCell : UICollectionViewCell

+ (instancetype) cellWithCollectionView : (UICollectionView *) collectionView cellForItemAtIndexPath:(NSIndexPath *) indexPath;

@property (nonatomic , strong) UIImage *cellImage;

@property (nonatomic , copy) void (^switchSelectBlock)(ZLPhotoPickerCollectionViewCell *cell);

-(void)updateWithAssets:(ZLPhotoAssets *)asset selected:(BOOL)selected;

-(void)updateForCamera:(UIImage *)cameraImage;

-(BOOL)isSelectedImage;

-(void)selectImage:(BOOL)selected;

@end
