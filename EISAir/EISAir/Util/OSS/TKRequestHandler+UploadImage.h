//
//  TKRequestHandler+UploadImage.h
//  EISAir
//
//  Created by chunhui on 2017/9/25.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler.h"
#import "EAOssPolicyModel.h"
#import "EASyncFileInfoModel.h"

@interface TKRequestHandler (UploadImage)

-(NSURLSessionDataTask *)getOssPolicyCompletion:(void(^)(NSURLSessionDataTask *task , EAOssPolicyModel *policy , NSError *error))completion;

@end
