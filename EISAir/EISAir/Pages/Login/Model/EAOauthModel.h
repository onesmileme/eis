//
//  EAOauthModel.h
//  EISAir
//
//  Created by chunhui on 2017/8/25.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface  EAOauthModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *accessToken;
@property (nonatomic, copy , nullable) NSString *tokenType;
@property (nonatomic, copy , nullable) NSString *expiresIn;
@property (nonatomic, copy , nullable) NSString *refreshToken;
@property (nonatomic, copy , nullable) NSString *scope;
@property (nonatomic, copy , nullable) NSString *errorDescription;
//


@end
