//
//  EANetworkManager.m
//  FunApp
//
//  Created by chunhui on 16/6/1.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "EANetworkManager.h"
#import "TKRequestHandler.h"
#import "TKAppInfo.h"
//#import "FAConfigManager.h"
#import "UIDevice+Hardware.h"
#import "Reachability.h"
#import "TKAccountManager.h"
#import "TKNetworkManager.h"
#import "CHKeychain.h"
#import "EAPushManager.h"

NSString * const KEY_USERNAME_PASSWORD = @"com.company.app.usernamepassword";
NSString * const KEY_PASSWORD = @"com.company.app.password";

#define kOnLine  1

#if kOnLine 

#define AppBaseHost @""

#else

#define AppBaseHost @""


#endif


@interface EANetworkManager()<TKRequestHandlerDelegate>

@property(nonatomic , strong) NSMutableDictionary *extraInfo;
@property(nonatomic , strong) NSString *cuid;

@end

@implementation EANetworkManager

IMP_SINGLETON

-(instancetype)init
{
    self = [super init];
    if (self) {
        _extraInfo = [[NSMutableDictionary alloc]init];
        
        //TODO 获取网络状态
        _extraInfo[@"net"] = @"1";
        __weak typeof(self) wself = self;
        TKRequestHandler *handler = [TKRequestHandler sharedInstance];
        handler.delegate = self;
        handler.baseParam = [self baseParam];
        handler.extraInfoBlock = ^(){
            return [wself extraParam];
        };
        
        [self fetchUUID];
//        handler.codeSignBlock = ^(NSDictionary *dic){
//            return [CSCodeSignHelper signWithDictionary:dic];
//        };
        NSString *notificatioName = kTKNetworkChangeNotification;
        [NotificationCenter addObserver:self selector:@selector(networkChangeNotification:) name:notificatioName object:nil];
        
    }
    return self;
}


+(NSString *)appHost
{
    return @"";
//    return [[FAConfigManager sharedInstance]host];
}


-(NSDictionary *)baseParam
{
    NSString *mb = [[UIDevice currentDevice]hwMachineName];
    NSString *osv = [[UIDevice currentDevice]systemVersion];
    NSString *appVersion = [TKAppInfo appVersion];
//    NSString *appKey = [[FAConfigManager sharedInstance]appKey];
    
    return @{@"mb" : mb, @"ov":osv, @"os":@"ios" ,
            @"sv":appVersion ,
             };    
}

-(NSDictionary *)extraParam
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param addEntriesFromDictionary:_extraInfo];
    TKUserInfo *userinfo = [[TKAccountManager sharedInstance]userInfo];
    NSString *uid = userinfo.uid;
    if (uid && ![uid isKindOfClass:[NSString class]]) {
        uid = [NSString stringWithFormat:@"%@",uid];
    }
    if (uid.length > 0) {
        param[@"uid"] = uid;
    }
    NSString *token = userinfo.token;
    if (token.length > 0) {
        param[@"token"] = token;
    }
    return param;
}

#pragma mark - request handler
-(void)checkError:(NSInteger)errNo responseData:(NSDictionary *_Nullable)response forRequest:(NSURLRequest *_Nonnull)request
{
    //处理token失效等通用错误
    if (errNo  > 0) {
        switch (errNo) {
            case 10011:
            case 20002:
            case 20003:
            {
                [[EAPushManager sharedInstance]handleOpenUrl:@"appfac://show_login"];
            }
                break;
                
            default:
                break;
        }
    }
    
}

-(NSError *)convertError:(NSError *)error
{
    NSError *err = nil;
    switch (error.code) {
        case kCFURLErrorNotConnectedToInternet:
        case kCFURLErrorUnknown:
        case kCFURLErrorTimedOut:
        case kCFURLErrorCannotConnectToHost:
        case kCFURLErrorResourceUnavailable:
        case kCFURLErrorNetworkConnectionLost:
        {
            err = [NSError errorWithDomain:kRequestNetErrorTip code:error.code userInfo:nil];
        }
            break;
            
        default:
            if (error.userInfo) {
                NSString *msg = error.userInfo[NSLocalizedRecoverySuggestionErrorKey];
                if (msg.length == 0) {
                    msg = error.userInfo[NSLocalizedFailureReasonErrorKey];
                }
                if (msg) {
                    error = [NSError errorWithDomain:msg code:error.code userInfo:error.userInfo];
                }else{
                    error = [NSError errorWithDomain:kRequestFailedTip code:error.code userInfo:error.userInfo];
                }
            }
            
            err = error;
            break;
    }
    
    
    return err;
}


#pragma mark - net work status callback
/**
 *  网络状态
 *   @"0"  未连接
 *   @"1"   wifi连接
 *   @"2"   移动连接
 */
-(void)networkChangeNotification:(NSNotification *)notification
{
    
    NSDictionary *statusInfo = notification.userInfo;
    NetworkStatus status = [statusInfo[@"status"] integerValue];
    NSString *statusTag = nil;
    
    if (status == NotReachable) {
        statusTag = @"0";
    }else if (status == ReachableViaWiFi){
        statusTag = @"1";
    }else{
        statusTag = @"2";
    }
    _extraInfo[@"net"] = statusTag;
    
}


#pragma mark - uuid Keychain使用
- (void)fetchUUID
{
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[CHKeychain load:KEY_USERNAME_PASSWORD];
    NSString *uuidString = [usernamepasswordKVPairs objectForKey:KEY_PASSWORD];
    
    if (!uuidString || uuidString.length == 0)
    {
        uuidString = [self creatUuid];
        NSMutableDictionary *uuidMutableDic = [[NSMutableDictionary alloc] initWithCapacity:3];
        [uuidMutableDic setObject:uuidString forKey:KEY_PASSWORD];
        [CHKeychain save:KEY_USERNAME_PASSWORD data:uuidMutableDic];
    }
    
    self.cuid = uuidString;
}

- (NSString*) creatUuid
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

@end
