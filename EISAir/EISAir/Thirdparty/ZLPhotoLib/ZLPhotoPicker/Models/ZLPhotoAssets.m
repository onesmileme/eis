//
//  ZLAssets.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 15-1-3.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

#import "ZLPhotoAssets.h"

@implementation ZLPhotoAssets

- (UIImage *)thumbImage{
    return [UIImage imageWithCGImage:[self.asset aspectRatioThumbnail]];
}

- (UIImage *)originImage{
    
//    ALAssetRepresentation *representation = [self.asset defaultRepresentation];
//    CGImageRef imageRef = [representation fullResolutionImage];
//    
////    CGImageRef imageRef = [representation fullScreenImage];
//    
//    return [UIImage imageWithCGImage:imageRef];
    
    ALAssetRepresentation *representation = [self.asset defaultRepresentation];
    CGImageRef imageRef = [representation fullResolutionImage];
    return [UIImage imageWithCGImage:imageRef scale:1 orientation:(UIImageOrientation)[representation orientation]];
}


- (BOOL)isVideoType{
    NSString *type = [self.asset valueForProperty:ALAssetPropertyType];
    //媒体类型是视频
    return [type isEqualToString:ALAssetTypeVideo];
}

@end
