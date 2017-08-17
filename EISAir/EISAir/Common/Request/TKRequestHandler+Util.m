//
//  TKRequestHandler+Util.m
//  WeRead
//
//  Created by chunhui on 16/3/5.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "TKRequestHandler+Util.h"
#import "EANetworkManager.h"
#import "ImageHelper.h"

@implementation TKRequestHandler (Util)


/**
 *  上传图片
 *
 *  @param image      图片对象
 *  @param completion 完成回调
 *
 *  @return 请求对象
 */
-(NSURLSessionDataTask *)postImage:(UIImage *) image completion:(void(^)(NSURLSessionDataTask *task , NSDictionary * imageData , NSError *error))completion
{
    
    NSString *path = [NSString stringWithFormat:@"%@/upload/tweet_pic",AppHost];
    return [self postRequestForPath:path param:nil formData:^(id<AFMultipartFormData> formData) {
        if (formData) {
            NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
            
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpeg"];
        }
    } finish:^(NSURLSessionDataTask *sessionDataTask, id response, NSError *error) {
        
        completion(sessionDataTask,response,error);
        
    }];
    
}

/**
 *  上传图片
 *
 *  @param image      图片对象
 *  @param completion 完成回调
 *
 *  @return 请求对象
 */
-(NSURLSessionDataTask *)postUserAvatarImage:(UIImage *) image completion:(void(^)(NSURLSessionDataTask *task , EAUploadPicModel * model , NSError *error))completion
{
    
    NSString *path = [NSString stringWithFormat:@"%@/upload/user_pic",AppHost];
    
    return [self postRequestForPath:path param:nil jsonName:@"EAUploadPicModel" formData:^(id<AFMultipartFormData> formData) {
        if (formData) {
            NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
            
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpeg"];
        }
    } finish:^(NSURLSessionDataTask *sessionDataTask, JSONModel *model, NSError *error) {
        if (completion) {
            completion(sessionDataTask,(EAUploadPicModel *)model , error);
        }
    }];
}


/**
 *  上传图片
 *
 *  @param image      图片对象
 *  @param completion 完成回调
 *
 *  @return 请求对象
 */
-(NSURLSessionDataTask *)postImageForJson:(UIImage *) image completion:(void(^)(NSURLSessionDataTask *task , EAUploadPicModel *imageData , NSError *error))completion
{
    
    NSString *path = [NSString stringWithFormat:@"%@/upload/tweet_pic",AppHost];
    
    return [self postRequestForPath:path param:nil jsonName:@"EAUploadPicModel" formData:^(id<AFMultipartFormData> formData) {
        if (formData) {
            
            UIImage *normImage = [ImageHelper normImageOrientation:image];
            UIImage *sendImage = [ImageHelper resizeImage:normImage maxWidth:1024];
            
            NSData *imageData = UIImageJPEGRepresentation(sendImage, 0.8);
            
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpeg"];
        }
    } finish:^(NSURLSessionDataTask *sessionDataTask, JSONModel *model, NSError *error) {
        
        completion(sessionDataTask,(EAUploadPicModel *)model , error);
        
    }];
    
    
}

/**
 *  上传图片
 *
 *  @param imageFilePath  图片文件路径
 *  @param completion 完成回调
 *
 *  @return 请求对象
 */
-(NSURLSessionDataTask *)postImageFile:(NSString *) imageFilePath completion:(void(^)(NSURLSessionDataTask *task , JSONModel *imageData , NSError *error))completion
{
    
    NSString *path = [NSString stringWithFormat:@"%@/upload/tweet_pic",AppHost];
    return [self postRequestForPath:path param:nil jsonName:@"EAUploadPicModel" formData:^(id<AFMultipartFormData> formData) {
        if (formData) {
            NSData *imageData = [NSData dataWithContentsOfFile:imageFilePath];
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpeg"];
        }
    } finish:^(NSURLSessionDataTask *sessionDataTask, JSONModel *response, NSError *error) {
        
        
        
        completion(sessionDataTask,response,error);
        
    }];
    
}

- (NSURLSessionDataTask *)postRequestForPath:(NSString *)path
                                       image:(UIImage *)image
                                       param:(NSDictionary *)param
                                    jsonName:(NSString *)jsonName
                                      finish:(void (^)(JSONModel *model , NSError *error))finish {
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    return [self postRequestForPath:path param:param formData:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"photo.png" mimeType:@"image/jpeg"];
    } finish:^(NSURLSessionDataTask *sessionDataTask, id response, NSError *error) {
        
        JSONModel *model = nil;
        
        if ([response isKindOfClass:[NSData class]]) {
            @try {
                response = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
            }
            @catch (NSException *exception) {
                response = nil;
            }
        }
        
        //        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil];
        //        NSString * myString = [[NSString alloc] initWithData:jsonData  encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@",myString);
        
        if (response) {
            Class clazz = NSClassFromString(jsonName);
            model = [[clazz alloc]initWithDictionary:response error:nil];
        }
        
        if (finish) {
            finish(model,error);
        }
    } ];
}





@end
