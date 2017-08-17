//
//  TKRequestHandler+Account.h
//  WeRead
//
//  Created by chunhui on 16/1/30.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "TKRequestHandler.h"
#import "TKWexinUserInfo.h"

typedef NS_ENUM(NSInteger , TKLoginType) {
    TKLoginTypeWeixin = 0,
    TKLoginTypeQQ = 1
};

@class EAUserInfoModel;
@interface TKRequestHandler (Account)

-(NSURLSessionDataTask *)loginWithWxUserInfo:(TKWexinUserInfo *)info finish:(void(^)(BOOL success , NSString *avatar , NSString *nickName , NSString *uid , NSString *token, bool hasInterest, bool needBind))finish;

-(NSURLSessionDataTask *)loginWithQQUserInfo:(TKWexinUserInfo *)info finish:(void(^)(BOOL success , NSString *avatar , NSString *nickName , NSString *uid , NSString *token, bool hasInterest, bool needBind))finish;

-(NSURLSessionDataTask *)loginWithUserInfo:(TKWexinUserInfo *)info  type:(TKLoginType )type finish:(void(^)(BOOL success , NSString *avatar , NSString *nickName , NSString *uid , NSString *token, bool hasInterest, bool needBind))finish;



/**
 *  拉取用户信息
 *
 *  @param uid       用户uid
 *  @param completion
 *
 *  @return
 */
-(NSURLSessionDataTask *)loadUserInfo:(NSString *)uid completion:(void(^)(NSURLSessionDataTask *task , EAUserInfoModel *model , NSError * error))completion;
/**
 * 获取某用户的信息
 * @param uid  要获取的用的 uid
 */
-(NSURLSessionDataTask *)searchUserInfo:(NSString *)uid completion:(void(^)(NSURLSessionDataTask *task , EAUserInfoModel *model , NSError * error))completion;

/**
 *  加载默认运营用户信息  苹果审核时使用
 *
 */
-(NSURLSessionDataTask *)loadDefaultUserInfo:(void(^)(NSDictionary *info ,  EAUserInfoModel *model)) completion;

@end
