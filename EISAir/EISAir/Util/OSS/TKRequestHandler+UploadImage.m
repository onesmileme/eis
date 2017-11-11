//
//  TKRequestHandler+UploadImage.m
//  EISAir
//
//  Created by chunhui on 2017/9/25.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler+UploadImage.h"
#import "TKAccountManager.h"
@implementation TKRequestHandler (UploadImage)

#if 0

+(void)load
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        NSString *imgurl = @"http:/panyun.oss-cn-beijing.aliyuncs.com/image/12345/20170925/icon.jpg";
//
//        NSURL *url = [NSURL URLWithString:imgurl];
//        NSLog(@"path is: %@",[url path]);
//        NSLog(@"file name is: %@",[imgurl lastPathComponent]);
        
        [[TKRequestHandler sharedInstance]getOssPolicyCompletion:^(NSURLSessionDataTask *task, EAOssPolicyModel *policy, NSError *error) {
          
            NSLog(@"policy is: \n%@\n",policy);
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"login_bg" ofType:@"jpg"];
            UIImage *img = [UIImage imageWithContentsOfFile:path];
            
            [[TKRequestHandler sharedInstance]postImage:img policy:policy completion:^(NSURLSessionDataTask *task, NSString *imgUrl , NSInteger size, NSError *error) {
                if (imgUrl) {
                    
                    EALoginUserInfoDataModel *uinfo = [[TKAccountManager sharedInstance]loginUserInfo];
//                    EASyncFileInfoItemModel *info = [[EASyncFileInfoItemModel alloc]init];
                    EASyncFileInfoModel *info = [[EASyncFileInfoModel alloc]init];
                    info.quoteId = uinfo.userId;
                    info.quoteType = @"userInfoImg";
                    info.fileSize = size;//[@(size) description];
                    info.fileDescription = @"user image";
                    info.fileName = [imgUrl lastPathComponent];
//                    NSURL *url = [NSURL URLWithString:imgUrl];
                    info.path = imgUrl;//[url absoluteString];
                    info.siteId = uinfo.siteId;
                    info.orgId = uinfo.orgId;
                    
//                    EASyncFileInfoModel *model = [[EASyncFileInfoModel alloc]init];
//                    model.items = @[info];
                    
                    [[TKRequestHandler sharedInstance]saveImageInfo:info completion:^(NSURLSessionDataTask *task, BOOL success, NSDictionary *dict , NSError *error) {
                        if (success) {
                            [[TKRequestHandler sharedInstance] loadUserImage:nil completion:^(NSURLSessionTask *task, NSString *imgUrl, NSError *error) {
                                
                            }];
                        }
                    }];
                    
                }
            }];
            
        }];
        
    });
}

#endif

-(NSURLSessionDataTask *)getOssPolicyCompletion:(void(^)(NSURLSessionDataTask *task , EAOssPolicyModel *policy , NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/dss/oss/policy",AppHost];
    
    return [[TKRequestHandler sharedInstance]getRequestForPath:path param:nil jsonName:@"EAOssPolicyModel" finish:^(NSURLSessionDataTask * _Nonnull sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {

        if(completion){
            completion(sessionDataTask,(EAOssPolicyModel *)model , error);
        }
    }];
}

-(NSURLSessionDataTask *)postImage:(UIImage *)image policy:(EAOssPolicyModel *)policy completion:(void (^)(NSURLSessionDataTask *task ,NSString *imgUrl ,NSInteger size , NSError *error))completion
{
    /*
     uploadAction: json.host  , // http:\/\/panyun.oss-cn-beijing.aliyuncs.com  ----上传方法的路径
     ossParam: {
     'key' :  '认证获取的dir' + '文件名'+'文件后缀', //文件路径
     'policy': json.policy,   //对应认证返回的 policy
     'OSSAccessKeyId': json.accessid, //对应认证返回的 accessid
     'success_action_status' : '200',
     'callback' : json.callback,//对应认证返回的 callback
     'signature': json.signature,//对应认证返回的 signature
     }
     */
    
    
    NSTimeInterval interval = [[NSDate date]timeIntervalSince1970];
    
    NSString *key = [policy.dir stringByAppendingPathComponent:[NSString stringWithFormat:@"icon_%.0f.jpg",interval*100]];
    NSString *imgUrl = nil;
    if ([policy.host hasSuffix:@"/"]) {
        imgUrl = [policy.host stringByAppendingString:key];
    }else{
        imgUrl = [policy.host stringByAppendingFormat:@"/%@",key];
    }
    
    NSString *path = policy.host;
    NSDictionary *param = @{@"key":key,
                            @"policy":policy.policy?:@"",
                            @"OSSAccessKeyId":policy.accessid?:@"",
                            @"success_action_status":@"200",
                            @"callback":policy.callback?:@"",
                            @"signature":policy.signature?:@""};
    
//    NSLog(@"param is: \n%@\n",param);
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    return [self postRequestForPath:path param:param formData:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpeg"];
    } finish:^(NSURLSessionDataTask *sessionDataTask, id response, NSError *error) {
        
        BOOL success = false;
        if ([response[@"Status"] isEqualToString:@"OK"]) {
            success = true;
        }
        
        @try{
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:response options:0 error:nil];
            NSString * myString = [[NSString alloc] initWithData:jsonData  encoding:NSUTF8StringEncoding];
            NSLog(@"%@",myString);
        }@catch(NSException *e){
            NSLog(@"exception is: %@",e);
        }
      
//        if (response) {
//            Class clazz = NSClassFromString(jsonName);
//            model = [[clazz alloc]initWithDictionary:response error:nil];
//        }
        
        if (completion) {
            completion(sessionDataTask, success?imgUrl:nil,[imageData length],error);
        }
    } ];

}


-(NSURLSessionDataTask *)saveImageInfo:(EASyncFileInfoModel *)info completion:(void(^)(NSURLSessionDataTask *task ,BOOL success , NSDictionary *info , NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/dss/fileinfos/save",AppHost];
    
    NSDictionary *param = [info toDictionary];
    
    NSLog(@"save image param is: \n%@",param);
    
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    
    NSArray *item = @[param];
    NSData *data = [NSJSONSerialization dataWithJSONObject:item options:kNilOptions error:nil];
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%lu",data.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if ([[TKAccountManager sharedInstance] isLogin]) {        
        TKUserInfo *userinfo = [TKAccountManager sharedInstance].userInfo;
        [request setValue:[NSString stringWithFormat:@"%@ %@",[userinfo.tokenType capitalizedString],userinfo.accessToken] forHTTPHeaderField:@"Authorization"];
    }
    
    NSURLSessionDataTask *task =  [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dict = nil;
        BOOL success = false;
        NSDictionary *info = nil;
        
        @try{
            if (data) {
                dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                NSLog(@"dict is: \n%@\n",dict);
                
                success = [dict[@"success"] boolValue];
                NSArray *datas  = dict[@"data"];
                if (datas.count > 0) {
                    info = [datas firstObject];
                }
            }
        }@catch(NSException *e){
            
        }
        if (error) {
            NSLog(@"error is: %@",error);
            NSData *d = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSString *info = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
            NSLog(@"info is: \n%@\n",info);

        }
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,success,info,error);
            });
        }
        
    }];
    [task resume];
    
    return task;
    
}

-(NSURLSessionTask *)loadUserImage:(NSString *)quoteId completion:(void(^)(NSURLSessionTask *task , NSString *imgUrl , NSError *error))completion
{
    ///dss/fileinfos/findByQuoteTypeAndQuoteId
    NSString *path = [NSString stringWithFormat:@"%@/dss/fileinfos/findByQuoteTypeAndQuoteId",AppHost];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    if (quoteId == nil) {
        EALoginUserInfoDataModel *uinfo = [[TKAccountManager sharedInstance]loginUserInfo];
        param[@"quoteId"] = uinfo.userId;
    }
    param[@"quoteType"] = @"userInfoImg";
    
    return [self getRequestForPath:path param:param finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, id  _Nullable response, NSError * _Nullable error) {
        NSString *imgUrl = nil;
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSDictionary *data = response[@"data"];
            if (data) {
                NSArray *imgs = data[@"images"];
                NSDictionary *imgDict = [imgs firstObject];
                if (imgDict) {
                    imgUrl = imgDict[@"path"];
                }
            }
        }
        if (completion) {
            completion(sessionDataTask,imgUrl,error);
        }
    }];
    
    
}

@end
