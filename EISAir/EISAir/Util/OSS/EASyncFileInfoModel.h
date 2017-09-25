//
//  EASyncFileInfoModel.h
//  EISAir
//
//  Created by chunhui on 2017/9/25.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EASyncFileInfoModel : JSONModel

@property (nonatomic, copy , nullable) NSString *quoteId;
@property (nonatomic, copy , nullable) NSString *quoteType;//userInfoImg
@property (nonatomic, copy , nullable) NSString *fileName;
@property (nonatomic, copy , nullable) NSString *fileDescription;
@property (nonatomic, copy , nullable) NSString *fileSize;
@property (nonatomic, copy , nullable) NSString *path;
@property (nonatomic, copy , nullable) NSString *orgId;
@property (nonatomic, copy , nullable) NSString *siteId;

@end
