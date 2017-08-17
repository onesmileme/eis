//
//  TKWeChatLoginHelper.m
//  ToolKit
//
//  Created by chunhui on 16/1/30.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "TKWeChatLoginHelper.h"
#import "AFNetworking.h"
#import "TKRequestHandler.h"
#import "WXApi.h"

@interface TKWeChatLoginHelper ()

@property(nonatomic , strong) NSString *state;
@property(nonatomic , strong) NSString *code;
@property(nonatomic , strong) TKWexinUserAuthoInfo *authInfo;
@property(nonatomic , strong) TKWexinUserInfo *wxUserInfo;
@property(nonatomic , strong) void (^loginCompletion)(TKWexinUserInfo *wxUserInfo);

@end


@implementation TKWeChatLoginHelper

//+(void)load
//{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        TKWeChatLoginHelper *helper = [[TKWeChatLoginHelper alloc]init];
//        [helper doLogin:^(TKWexinUserInfo *wxUserInfo){
//            
//        }];
//        
//    });
//}


+(TKWeChatLoginHelper *)sharedInstance
{
    static TKWeChatLoginHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TKWeChatLoginHelper alloc]init];
    });
    
    return instance;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.state = @"login";
    }
    return self;
}

-(void)checkRefreshToken:(TKWexinUserAuthoInfo *)authInfo completion:(void (^)(TKWexinUserAuthoInfo *refreshAuthInfo))completion
{
    
#if 0
    self.authInfo = authInfo;
    NSDate *date = [NSDate date];
    
    /*
     refresh_token拥有较长的有效期（30天），当refresh_token失效的后，需要用户重新授权，所以，请开发者在refresh_token即将过期时（如第29天时），进行定时的自动刷新并保存好它
     */
    
    if ([date timeIntervalSince1970] - [authInfo.refreshTimestamp doubleValue] >  15*24*60*60) {
//        //超过15天进行刷新
    
        [self refreshToken:authInfo.refreshToken completion:^(TKWexinUserAuthoInfo *refreshAuthInfo) {
            completion(refreshAuthInfo);
        }];
        
    }
#endif
    
}

-(void)doLogin:(void(^)(TKWexinUserInfo *userInfo))completion
{
    
    self.loginCompletion = completion;
    
    SendAuthReq *req = [[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo";
    req.state = self.state;

    [WXApi sendReq:req];
    
}

-(BOOL)handleUrl:(NSURL *)url
{
    NSString *path =  url.host;
    if ([path isEqualToString:@"oauth"]) {
        
        NSString *query = [url query];
        NSArray *keyvalues = [query componentsSeparatedByString:@"&"];
        NSMutableDictionary *queryDict = [[NSMutableDictionary alloc]init];
        
        for (NSString *kv in keyvalues) {
            
            NSArray * pair = [kv componentsSeparatedByString:@"="];
            queryDict[pair[0]] = pair[1];
            
        }
        
        if ([queryDict[@"state"] isEqualToString:self.state]) {
            
            NSString *code = queryDict[@"code"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self doOauthWithCode:code];
            });
            
            return YES;
        }
        
    }
    
    return NO;
}

-(void)doOauthWithCode:(NSString *)code
{
    NSString *path = @"https://api.weixin.qq.com/sns/oauth2/access_token";
    NSDictionary *param = @{@"code":code , @"grant_type":@"authorization_code" , @"appid":self.appId,@"secret":self.appSecret};
    [[TKRequestHandler sharedInstance] getRequestForPath:path param:param finish:^(NSURLSessionDataTask *sessionDataTask, id response, NSError *error) {
                
        self.authInfo = [[TKWexinUserAuthoInfo alloc]initWithDictionary:response error:nil];
        self.authInfo.refreshTimestamp = @([[NSDate date]timeIntervalSince1970]);
        
        if (self.authInfo) {
            [self loadUserInfo];
        }
        
        
    }];
    
}

-(void)loadUserInfo
{
    NSString *path = @"https://api.weixin.qq.com/sns/userinfo";

    NSDictionary *param = @{@"access_token":self.authInfo.accessToken?:@"",@"openid":self.authInfo.openid?:@""};
    
    [[TKRequestHandler sharedInstance]getRequestForPath:path param:param finish:^(NSURLSessionDataTask *sessionDataTask, id response, NSError *error) {
        
        if (response) {
            self.wxUserInfo = [[TKWexinUserInfo alloc]initWithDictionary:response error:nil];
            [self mergeAuthToUserInfo];
        }else{
            self.wxUserInfo = nil;
        }
        
        self.loginCompletion(self.wxUserInfo);
        
    }];
    
}

-(void)mergeAuthToUserInfo
{
    
    self.wxUserInfo.accessToken = self.authInfo.accessToken;
    self.wxUserInfo.openid      = self.authInfo.openid;
    if (self.authInfo.expiresIn) {
        self.wxUserInfo.expiresIn   = [NSString stringWithFormat:@"%@",self.authInfo.expiresIn];
    }
    if(self.authInfo.refreshToken){
        self.wxUserInfo.refreshToken = [NSString stringWithFormat:@"%@",self.authInfo.refreshToken];
    }
    
}

-(void)refreshToken:(NSString *)refreshToken completion:(void (^)(TKWexinUserAuthoInfo *refreshAuthInfo))completion
{
    NSString *path = @"https://api.weixin.qq.com/sns/oauth2/refresh_token";
    NSDictionary *param = @{ @"grant_type":@"refresh_token" , @"appid":self.appId,@"refresh_token":refreshToken};
    
    [[TKRequestHandler sharedInstance]getRequestForPath:path param:param finish:^(NSURLSessionDataTask *sessionDataTask, id response, NSError *error) {
        
        NSLog(@"refresh token response is : %@",response);
        
        if (completion) {
            TKWexinUserAuthoInfo *authInfo = [[TKWexinUserAuthoInfo alloc]initWithDictionary:response error:nil];
            completion(authInfo);
        }
        
        
    }];
}


@end
