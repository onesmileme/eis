//
//  MYAccountManager.m
//  Find
//
//  Created by chunhui on 15/4/25.
//  Copyright (c) 2015年 chunhui. All rights reserved.
//

#import "TKAccountManager.h"
#import "TKFileUtil.h"
#import "TKWexinUserAuthoInfo.h"
#import "TKWeChatLoginHelper.h"
#import "MBProgressHUD.h"
#import "TKRequestHandler+Account.h"

@interface TKAccountManager ()

@property(nonatomic , strong) TKWexinUserAuthoInfo *authInfo;


@end

@implementation TKAccountManager

+ (TKAccountManager *)sharedInstance {
    static TKAccountManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TKAccountManager alloc]init];
    });
    
    return manager;
}

/*
 * 拉取默认用户信息
 */
-(void)loadDefaultInfo
{
    if (self.userInfo == nil) {
        [[TKRequestHandler sharedInstance]loadDefaultUserInfo:^(NSDictionary *info ,  EAUserInfoModel *model) {
            if ( info && info.allKeys.count > 0) {
                self.userInfo = [[TKUserInfo alloc]initWithDictionary:info error:nil];
                if (self.userInfo.uid.length == 0) {
                    self.userInfo.uid = self.userInfo.openid;
                }
                self.userInfo.isDefaultUser = true;
                [self save];
            }
        }];
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self loadUserInfo];
        
//#if !DEBUG
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self loadDefaultInfo];
//        });
//#endif
        
    }
    return self;
}

-(void)loadUserInfo
{
    NSString *path = [self userinfoPath];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.userInfo = [[TKUserInfo alloc]initWithData:data error:nil];
    }else{
        self.userInfo = [[TKUserInfo alloc]init];
    }
    
    path = [self authPath];
    if ([fm fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        
//        NSString *content = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        self.authInfo = [[TKWexinUserAuthoInfo alloc]initWithData:data error:nil];
    }
}

- (BOOL)isLogin {
    
    return  [self uid].length > 0 && self.userInfo.avatar.length > 0 && self.userInfo.nickname.length > 0;
    
}

- (NSString *)uid
{
//#if TARGET_IPHONE_SIMULATOR
//    
////    return @"oMH0xwCU82GQ2dz81HsMhOMh30bw"; //明旭
//    
////    return @"oMH0xwIZmKHtCDVEVKxHrKKvG7K0"; //玥玥
//    
//    if (self.userInfo.uid.length == 0) {
//        return @"oqRwHwVk_Juc5BelTFMln1UpDUgU";
//    }
//#endif
    
    return self.userInfo.uid;
}

- (NSString *)myName
{
//#if TARGET_IPHONE_SIMULATOR
//    if (self.userInfo.userNickName.length == 0) {
//        return @"模拟器";
//    }
//#endif
    
    return self.userInfo.userNickName;

}

- (NSString *)avatar
{
#if TARGET_IPHONE_SIMULATOR
    
    return @"http://img2.tigerinsky.com/msgpic/1645ee92-7b65-48da-9e29-9b10eb4986d2.jpg@200h";
    
#else
        
    return self.userInfo.avatar;
    
#endif
    
}

- (BOOL)needBind
{
    return self.userInfo.needBind;
}

/*
 * 是否是默认用户 审核时用
 */
- (BOOL)isDefaultUser
{
    return _userInfo.isDefaultUser;
}


- (void)wxlogin:(void(^)(bool success))completion
{
    [[TKWeChatLoginHelper sharedInstance] doLogin:^(TKWexinUserInfo *wxUserInfo) {
        
        NSDictionary *dict = [wxUserInfo toDictionary];
        
        self.userInfo = [[TKUserInfo alloc]initWithDictionary:dict error:nil];
        self.authInfo = [[TKWeChatLoginHelper sharedInstance]authInfo];
                
//        self.wxUserInfo.accessToken = self.authInfo.accessToken;
//        self.wxUserInfo.refreshToken = self.authInfo.refreshToken;
//        self.wxUserInfo.expiresIn = [NSString stringWithFormat:@"%@",self.authInfo.expiresIn];
                
        [self save];
        if (completion) {
            completion(true);
        }
    }];
}

-(void)syncLogin
{
    [self syncLogin:nil];
}

-(void)syncLogin:(void(^)(BOOL success))done
{
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:true];
    TKUserInfo *userInfo = [[TKAccountManager sharedInstance]userInfo];
    [[TKRequestHandler sharedInstance]loginWithWxUserInfo:userInfo finish:^(BOOL success, NSString *avatar, NSString *nickName, NSString *uid, NSString *token ,bool hasInterest, bool needBind) {
        
        if (success) {
            userInfo.avatar = avatar;
            userInfo.headimgurl = avatar;
            userInfo.userNickName = nickName;
            userInfo.uid = uid;
            userInfo.nickname = nickName;
            userInfo.needBind = needBind;
            userInfo.token = token;
            
            hud.label.text = @"登录成功";
            [hud hideAnimated:true afterDelay:0.5];
            
            [self save];
            
        }else{
            hud.label.text = @"登录失败";
            [hud hideAnimated:true afterDelay:0.7];
        }
        
        if(done){
            done(success);
        }
        
        
    }];
}

- (void)save {
    
    if (self.authInfo) {
        NSData *data = [self.authInfo toJSONData];
        [data writeToFile:[self authPath] atomically:YES];
    }
    
    if (self.userInfo) {
        NSData *data = [self.userInfo toJSONData];
        [data writeToFile:[self userinfoPath] atomically:YES];

    }
    
}

- (void)logout {
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = [self authPath];
    [fm removeItemAtPath:path error:nil];
    [fm removeItemAtPath:[self userinfoPath] error:nil];
    
    self.authInfo = nil;
    //clear user info
    self.userInfo = [[TKUserInfo alloc]init];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kLogoutNotification object:nil];    
}


-(NSString *)authPath
{
    return [[TKFileUtil docPath] stringByAppendingPathComponent:@"wxauth"];
}

-(NSString *)userinfoPath
{
    return [[TKFileUtil docPath]stringByAppendingPathComponent:@"wxuser"];
}


@end


NSString *const kLogoutNotification = @"_LogoutNotification";
NSString *const kLoginDoneNotification = @"_LoginDoneNotification";
