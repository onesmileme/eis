//
//  TKRequestHandler+Search.m
//  EISAir
//
//  Created by chunhui on 2017/9/16.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler+Search.h"
#import "TKAccountManager.h"

@implementation TKRequestHandler (Search)

-(NSURLSessionDataTask *)searchWithFilterParam:(EAMsgFilterModel *)filterModel completion:(void (^)(NSURLSessionDataTask *task , EAMsgSearchTipModel *model , NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/object/findObjects",AppHost];
    if (!filterModel.productArray) {
        EALoginUserInfoDataModel *dinfo = [TKAccountManager sharedInstance].loginUserInfo;
        filterModel.orgId = dinfo.orgId;
        filterModel.siteId = dinfo.siteId;
        filterModel.isAdmin = dinfo.isAdmin;
        filterModel.productArray = dinfo.productArray;
    }
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:[filterModel toDictionary]];
    
    return [self postRequestForPath:path param:param jsonName:@"EAMsgSearchTipModel" finish:^(NSURLSessionDataTask * _Nonnull sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(sessionDataTask,(EAMsgSearchTipModel *)model , error);
        }
    }];
}

@end
