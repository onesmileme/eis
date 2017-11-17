//
//  TKRequestHandler+Message.m
//  EISAir
//
//  Created by chunhui on 2017/8/31.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler+Message.h"
#import "TKAccountManager.h"
@implementation TKRequestHandler (Message)

#if 0

+(void)load
{
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        EAMsgFilterModel *model = [[EAMsgFilterModel alloc]init];
        EALoginUserInfoDataModel *dinfo = [TKAccountManager sharedInstance].loginUserInfo;
        model.orgId = dinfo.orgId;
        model.siteId = dinfo.siteId;
        model.isAdmin = dinfo.isAdmin;
        
        model.msgTypes = @[@"EIS_MSG_TYPE_ALARM",@"EIS_MSG_TYPE_RECORD",@"EIS_MSG_TYPE_EXCEPTION"];
        
//        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
//        param[@"orgId"] = dinfo.orgId;
//        param[@"siteId"] = dinfo.siteId;
        
        
        /*
         *  "EIS_MSG_TYPE_NOTICE": "通知",
         *  "EIS_MSG_TYPE_ALARM": "报警",
         *  "EIS_MSG_TYPE_RECORD": "人工记录",
         *  "EIS_MSG_TYPE_EXCEPTION": "异常"
         */
//        param[@"msgTypes"] = @"[EIS_MSG_TYPE_NOTICE]";
        
        NSDictionary *param = [model toDictionary];
        
        NSLog(@"param is: \n%@\n",param);
        
        NSString *path = [NSString stringWithFormat:@"%@/eis/open/msg/findMsgTitleList",AppHost];
        [[TKRequestHandler sharedInstance] postRequestForPath:path param:param finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, id  _Nullable response, NSError * _Nullable error) {
            if (response) {
                NSLog(@"response is: \n%@\n",response);
                
                NSData *d = [NSJSONSerialization dataWithJSONObject:response options:kNilOptions error:nil];
                NSString *c = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
                NSLog(@"cotnent is: \n%@\n",c);
            }
            if (error) {
                NSLog(@"error is: \n%@",error);
            }
        }];
        
    });
}

#endif

-(NSURLSessionDataTask *)loadMyMessageFilterParam:(EAMsgFilterModel *)fparam completion:(void (^)(NSURLSessionDataTask *task , EAMessageModel *model , NSError *error))completion
{
    NSString *personId = [TKAccountManager sharedInstance].loginUserInfo.personId;
    if (personId.length == 0) {
        return nil;
    }
    return [self loadMessageByPerson:personId filterParam:fparam completion:completion];
}

-(NSURLSessionDataTask *)loadMessageByPerson:(NSString *)personId filterParam:(EAMsgFilterModel *)fparam completion:(void (^)(NSURLSessionDataTask *task , EAMessageModel *model , NSError *error))completion
{
#if kOnLine
    NSString *path = [NSString stringWithFormat:@"%@/eis/open/msg/findEisMessageByPerson",AppHost];
#else
        NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/msg/findEisMessageByPerson",AppHost];
#endif
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    param[@"personId"] = personId;
    if (fparam) {
        NSDictionary *dict = [fparam toDictionary];
        [param addEntriesFromDictionary:dict];
    }
    
    NSLog(@"param is: %@",param);
    
    return [self postRequestForPath:path param:param jsonName:@"EAMessageModel" finish:^(NSURLSessionDataTask * _Nonnull sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(sessionDataTask,(EAMessageModel *)model , error);
        }
    }];
}

-(NSURLSessionDataTask *)findMessageDataFilterParam:(EAMsgFilterModel *)fparam completion:(void (^)(NSURLSessionDataTask *task , EAMessageModel *model , NSError *error))completion
{
#if kOnLine
    NSString *path = [NSString stringWithFormat:@"%@/eis/open/msg/findEisMessageData",AppHost];
#else
        NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/msg/findEisMessageData",AppHost];
#endif
    NSDictionary *param = [fparam toDictionary];
    
    return [self getRequestForPath:path param:param jsonName:@"EAMessageModel" finish:^(NSURLSessionDataTask * _Nonnull sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(sessionDataTask,(EAMessageModel *)model , error);
        }
    }];
}

/*
 * 加载筛选数据
 */
-(NSURLSessionDataTask *)loadMsgFilterData:(EAMsgFilterModel *)fparam completion:(void (^)(NSURLSessionDataTask *task , JSONModel *model , NSError *error))completion
{
#if kOnLine
    NSString *path = [NSString stringWithFormat:@"%@/eis/open/msg/findEisMessageData",AppHost];
#else
        NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/msg/findEisMessageData",AppHost];
#endif
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:[fparam toDictionary]];
    return [self postRequestForPath:path param:param jsonName:@"EAMessageModel" finish:^(NSURLSessionDataTask * _Nonnull sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(sessionDataTask,(EAMessageModel *)model , error);
        }
    }];
}


/*
 * 加载筛选项
 */
-(NSURLSessionDataTask *)loadMsgFilterTag:(EAMsgFilterModel *)model completion:(void (^)(NSURLSessionDataTask *task , EAMsgFilterTagModel *model , NSError *error))completion
{
    
    if (model == nil) {
        model = [[EAMsgFilterModel alloc]init];
        EALoginUserInfoDataModel *dinfo = [TKAccountManager sharedInstance].loginUserInfo;
        model.orgId = dinfo.orgId;
        model.siteId = dinfo.siteId;
        model.isAdmin = dinfo.isAdmin;
        
    }
//    /*
//     *  "EIS_MSG_TYPE_NOTICE": "通知",
//     *  "EIS_MSG_TYPE_ALARM": "报警",
//     *  "EIS_MSG_TYPE_RECORD": "人工记录",
//     *  "EIS_MSG_TYPE_EXCEPTION": "异常"
//     */
//    //        param[@"msgTypes"] = @"[EIS_MSG_TYPE_NOTICE]";
//    
    NSDictionary *param = [model toDictionary];
    
#if kOnLine
    NSString *path = [NSString stringWithFormat:@"%@/eis/open/msg/findMsgTitleList",AppHost];
#else
        NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/msg/findMsgTitleList",AppHost];
#endif
    NSURLSessionDataTask *task =  [[TKRequestHandler sharedInstance] postRequestForPath:path param:param jsonName:@"EAMsgFilterTagModel" finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        
        if (completion) {
            completion(sessionDataTask,(EAMsgFilterTagModel *)model , error);
        }
        
    } ];

    return task;
}

@end
