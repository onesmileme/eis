//
//  TKWeChatLoginHelper.h
//  ToolKit
//
//  Created by chunhui on 16/1/30.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKWexinUserAuthoInfo.h"
#import "TKWexinUserInfo.h"

@interface TKWeChatLoginHelper : NSObject

@property(nonatomic , strong) NSString *appId;
@property(nonatomic , strong) NSString *appSecret;

@property(nonatomic , strong , readonly) TKWexinUserInfo *wxUserInfo;
@property(nonatomic , strong , readonly) TKWexinUserAuthoInfo *authInfo;

+(TKWeChatLoginHelper *)sharedInstance;

-(void)doLogin:(void(^)(TKWexinUserInfo *userInfo))completion;

-(void)checkRefreshToken:(TKWexinUserAuthoInfo *)authInfo completion:(void (^)(TKWexinUserAuthoInfo *refreshAuthInfo))completion;

-(BOOL)handleUrl:(NSURL *)url;

@end
