//
//  TKRequestHandler+Util.h
//  WeRead
//
//  Created by chunhui on 16/3/5.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "TKRequestHandler.h"
#import "EAUploadPicModel.h"

@class FATweetModel;
@interface TKRequestHandler (Util)

/**
 *  上传图片
 *
 *  @param image      图片对象
 *  @param completion 完成回调
 *
 *  @return 请求对象
 */
-(NSURLSessionDataTask *_Nullable)postImage:(UIImage *_Nonnull) image completion:(void(^_Nullable)(NSURLSessionDataTask *_Nonnull task , NSDictionary * _Nullable imageData , NSError *_Nullable error))completion;

/**
 *  上传用户头像图片
 *
 *  @param image      图片对象
 *  @param completion 完成回调
 *
 *  @return 请求对象
 */
-(NSURLSessionDataTask *_Nullable)postUserAvatarImage:(UIImage *_Nonnull) image completion:(void(^_Nullable)(NSURLSessionDataTask *_Nonnull task , EAUploadPicModel * _Nullable model , NSError *_Nullable error))completion;

/**
 *  上传图片
 *
 *  @param image      图片对象
 *  @param completion 完成回调
 *
 *  @return 请求对象
 */
-(NSURLSessionDataTask *_Nullable)postImageForJson:(UIImage *_Nonnull) image completion:(void(^_Nullable)(NSURLSessionDataTask *_Nonnull task ,  EAUploadPicModel * _Nullable imageData , NSError *_Nullable error))completion;

/**
 *  上传图片
 *
 *  @param imageFilePath  图片文件路径
 *  @param completion 完成回调
 *
 *  @return 请求对象
 */
-(NSURLSessionDataTask *_Nullable)postImageFile:(NSString *_Nonnull) imageFilePath completion:(void(^_Nullable)(NSURLSessionDataTask *_Nonnull task , JSONModel *_Nullable imageData , NSError *_Nullable error))completion;

- (NSURLSessionDataTask *_Nullable )postRequestForPath:(NSString *_Nullable)path
                                       image:(UIImage *_Nullable)image
                                       param:(NSDictionary *_Nullable)param
                                    jsonName:(NSString *_Nullable)jsonName
                                      finish:(void (^_Nullable)(JSONModel *_Nullable model , NSError *_Nullable error))finish;

@end
