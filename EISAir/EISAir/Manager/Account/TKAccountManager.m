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
    
    return self.userInfo.accessToken.length > 0 && self.userInfo.tokenType.length > 0;
}

- (NSString *)uid
{
    return self.userInfo.uid;
}

- (NSString *)myName
{
    return self.userInfo.userNickName;

}

- (NSString *)avatar
{
    return self.userInfo.avatar;
}

- (BOOL)needBind
{
    return self.userInfo.needBind;
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
