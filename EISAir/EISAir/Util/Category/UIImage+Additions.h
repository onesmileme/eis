//
//  UIImage+Additions.h
//  ZDComponents
//
//  Created by zhuchao on 13-12-19.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)
- (UIImage *)colorizeWithColor:(UIColor *)color;//覆盖一个颜色
- (UIImage *)highLightColor;//覆盖一个高光色
- (UIImage *)mirroredImage;//镜像翻转图像
//+ (UIImage *)imageFromView:(UIView *)view;//view to image
+ (UIImage *)imageFromView:(UIView *)view andOpaque:(BOOL) opaque;
@end

#pragma mark - Alpha
@interface UIImage (Alpha)
- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
@end


#pragma mark - resize
@interface UIImage (Resize)

/**
 截取图片内的某一块
 【线程安全】

 @param bounds 指定区域
 @return UIImage
 */
- (UIImage *)croppedImage:(CGRect)bounds;

/**
 返回一个正方形的小图，可以设置圆角，设置外边缘透明区域，图片质量
 【线程安全】

 @param thumbnailSize 正方形小图大小
 @param borderSize 外边框透明区域
 @param cornerRadius 圆角大小
 @param quality 图片质量
 @return UIImage
 */
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;

/**
 将图片缩放到制定大小，可指定图片质量
 【线程安全】

 @param newSize 指定大小
 @param quality 图片质量
 @return UIImage
 */
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;

/// 类似 resizedImage:interpolationQuality: 方法，但可指定放入到制定大小的方式
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

/**
 给定一个最大大小，在其范围内即可，和resizedImage:interpolationQuality:方法类似

 @param maxSize 最大大小
 @param quality 图片质量
 @return UIImage
 */
- (UIImage *)resizedImageWithMaxSize:(CGSize)maxSize interpolationQuality: (CGInterpolationQuality)quality;


/**
 将某个Image叠加到当前Image，并返回一个新的Image

 @param topImage 上层image
 @param topRect 叠加位置
 @return UIImage
 */
- (UIImage *)combineTopImage:(UIImage *)topImage topRect:(CGRect)topRect;

- (UIImage *)createNewImageWithMaxSize: (CGSize)size marginLeft: (BOOL)marginleft;
- (CGSize)getImageResizeWithMaxSize: (CGSize)maxSize;
- (UIImage *)corpImageInframe:(CGRect)frame;
- (UIImage*)resizedScaleImageWithNewSize:(CGSize)newSize;
@end


#pragma mark - Round Corner
@interface UIImage (RoundedCorner)
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
- (UIImage *)roundedCornerImageWithShadow:(NSInteger)shadowSize cornerSize:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
@end

#pragma mark - Create 
@interface UIImage (Create)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end
