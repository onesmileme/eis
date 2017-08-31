//
//  TKRequestHandler+Account.h
//  WeRead
//
//  Created by chunhui on 16/1/30.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "TKRequestHandler.h"
#import "TKWexinUserInfo.h"
#import "EALoginUserInfoModel.h"


typedef NS_ENUM(NSInteger , TKLoginType) {
    TKLoginTypeWeixin = 0,
    TKLoginTypeQQ = 1
};

@class EAUserInfoModel;
@interface TKRequestHandler (Account)


-(NSURLSessionDataTask *)loadLoginUserInfo:(void(^)(NSURLSessionDataTask *task , EALoginUserInfoModel *model , NSError * error))completion;

//-(NSURLSessionDataTask *)loginWithWxUserInfo:(TKWexinUserInfo *)info finish:(void(^)(BOOL success , NSString *avatar , NSString *nickName , NSString *uid , NSString *token, bool hasInterest, bool needBind))finish;
//
//-(NSURLSessionDataTask *)loginWithQQUserInfo:(TKWexinUserInfo *)info finish:(void(^)(BOOL success , NSString *avatar , NSString *nickName , NSString *uid , NSString *token, bool hasInterest, bool needBind))finish;
//
//-(NSURLSessionDataTask *)loginWithUserInfo:(TKWexinUserInfo *)info  type:(TKLoginType )type finish:(void(^)(BOOL success , NSString *avatar , NSString *nickName , NSString *uid , NSString *token, bool hasInterest, bool needBind))finish;
//


///**
// *  拉取用户信息
// *
// *  @param uid       用户uid
// */
//-(NSURLSessionDataTask *)loadUserInfo:(NSString *)uid completion:(void(^)(NSURLSessionDataTask *task , EAUserInfoModel *model , NSError * error))completion;
/**
 * 获取某用户的信息
 * @param uid  要获取的用的 uid
 */
-(NSURLSessionDataTask *)searchUserInfo:(NSString *)uid completion:(void(^)(NSURLSessionDataTask *task , EAUserInfoModel *model , NSError * error))completion;


@end
