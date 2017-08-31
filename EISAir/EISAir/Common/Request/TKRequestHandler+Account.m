//
//  TKRequestHandler+Account.m
//  WeRead
//
//  Created by chunhui on 16/1/30.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "TKRequestHandler+Account.h"
#import "EANetworkManager.h"
#import "EAUserInfoModel.h"
#import "TKAccountManager.h"

@implementation TKRequestHandler (Account)
//
//-(NSURLSessionDataTask *)loginWithWxUserInfo:(TKWexinUserInfo *)info finish:(void(^)(BOOL success , NSString *avatar , NSString *nickName , NSString *uid ,NSString *token, bool hasInterest, bool needBind))finish
//{
//    
//    return [self loginWithUserInfo:info type:TKLoginTypeWeixin finish:^(BOOL success, NSString *avatar, NSString *nickName, NSString *uid, NSString *token, bool hasInterest, bool needBind) {
//        finish(success,avatar , nickName , uid , token, hasInterest, needBind);
//    }];
//    
//}
//
//-(NSURLSessionDataTask *)loginWithQQUserInfo:(TKWexinUserInfo *)info finish:(void(^)(BOOL success , NSString *avatar , NSString *nickName , NSString *uid , NSString *token, bool hasInterest, bool needBind))finish
//{
//    
//    return [self loginWithUserInfo:info type:TKLoginTypeQQ finish:^(BOOL success, NSString *avatar, NSString *nickName, NSString *uid, NSString *token, bool hasInterest, bool needBind) {
//        finish(success,avatar , nickName , uid ,token,  hasInterest, needBind);
//    }];
//    
//}
//
//
//-(NSURLSessionDataTask *)loginWithUserInfo:(TKWexinUserInfo *)info  type:(TKLoginType)type finish:(void(^)(BOOL success , NSString *avatar , NSString *nickName , NSString *uid , NSString *token, bool hasInterest, bool needBind))finish
//{
//    
//    NSString *path = [NSString stringWithFormat:@"%@/user/login",AppHost];
//    NSDictionary *dict = [info toDictionary];
//    NSMutableDictionary *param = [[NSMutableDictionary alloc]initWithDictionary:dict];
//    
//    if (info.openid) {
//        param[@"usid"] = info.openid;
//    }
//    
//    if (info.nickname) {
//        param[@"userName"] = info.nickname;
//    }
//    
//    param[@"accessToken"] = info.accessToken;
//    param[@"iconURL"] = info.headimgurl;
//    
//    NSString *typename = @"";
//    if (type == TKLoginTypeWeixin) {
//        typename = @"weixin";
//    }else if (type == TKLoginTypeQQ){
//        typename = @"qq";
//    }
//    param[@"platformName"] = typename;
//    
//    return [[TKRequestHandler sharedInstance] postRequestForPath:path param:param finish:^(NSURLSessionDataTask *sessionDataTask, id response, NSError *error) {
//        
//        BOOL success = false;
//        
//        NSDictionary *data = response[@"data"];
//        
//        NSString *avatar = nil;
//        NSString *nickName = nil;
//        NSString *uid = nil;
//        NSString *token = nil;
//        BOOL hasInterest = false;//是否设置过兴趣爱好
//        BOOL needBind = true;
//        
//        if (data) {
//            avatar = data[@"headimgurl"];
//            nickName = data[@"nickname"];
//            uid = data[@"uid"];
//            token = data[@"token"];
//            hasInterest = ([data[@"interest_flag"] integerValue] == 1);
//            needBind = ([data[@"need_bind"] integerValue] == 1);
//            success = true;
//        }
//        
//        finish(success,avatar,nickName,uid ,token, hasInterest, needBind);
//        
//    }];
//    
//}

//-(NSURLSessionDataTask *)loadDefaultUserInfo:(void(^)(NSDictionary *info ,  EAUserInfoModel *model)) completion
//{
//    NSString *path = [NSString stringWithFormat:@"%@/user/defaultuser",AppHost];
//    return [self getRequestForPath:path param:nil finish:^(NSURLSessionDataTask *sessionDataTask, id response, NSError *error) {
//        NSDictionary *data = response[@"data"];
//        EAUserInfoModel *model = nil;
//        NSDictionary *content = data[@"content"];
//        if (content) {
//            model = [[EAUserInfoModel alloc]initWithDictionary:content error:nil];
//        }else{
//            
////            if (error) {
////                NSString *path = [[NSBundle mainBundle]pathForResource:@"default_user.json" ofType:nil];
////                NSData *defaultData = [NSData dataWithContentsOfFile:path];
////                model = [[EAUserInfoModel alloc]initWithData:defaultData error:nil];
////            }
//        }
//        
//        completion(content,model);
//        
//    }];
//    
//}

//
//-(NSURLSessionDataTask *)loadUserInfo:(NSString *)uid completion:(void(^)(NSURLSessionDataTask *task , EAUserInfoModel *model , NSError * error))completion
//{
//    return [self searchUserInfo:uid completion:^(NSURLSessionDataTask *task, EAUserInfoModel *model, NSError *error) {
//        if (completion) {
//            completion(task,model,error);
//        }
//    }];
//}

-(NSURLSessionDataTask *)searchUserInfo:(NSString *)uid completion:(void(^)(NSURLSessionDataTask *task , EAUserInfoModel *model , NSError * error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/user/home",AppHost];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    
    param[@"search_uid"] = uid;
    
    NSString *myUid = MYUID;
    if (myUid.length == 0) {
        param[@"uid"] = uid;
    }
    
    return [self getRequestForPath:path param:param finish:^(NSURLSessionDataTask *sessionDataTask, id response, NSError *error) {
        EAUserInfoModel *model = nil;
        if (response) {
            NSDictionary *data = response[@"data"];
            NSDictionary *content = data[@"content"];
            model = [[EAUserInfoModel alloc]initWithDictionary:content error:nil];
        }
        if (completion) {
            completion(sessionDataTask, model,error);
        }
    }];
}


-(NSURLSessionDataTask *)loadLoginUserInfo:(void(^)(NSURLSessionDataTask *task , EALoginUserInfoModel *model , NSError * error))completion
{
    NSString *path = [NSString stringWithFormat:@"%@/eis/open/user/findLoginUser",AppHost];
    
    return [self getRequestForPath:path param:nil jsonName:@"EALoginUserInfoModel" finish:^(NSURLSessionDataTask * _Nonnull sessionDataTask, JSONModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(sessionDataTask,(EALoginUserInfoModel *)model , error);
        }
    }];
}





@end
