//
//  EAMsgFilterTagModel.h
//  EISAir
//
//  Created by chunhui on 2017/9/12.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface  EAMsgFilterTagModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *errorCode;
@property (nonatomic, copy , nullable) NSString *msg;
@property (nonatomic, copy , nullable) NSString *detailMsg;
@property (nonatomic, strong , nullable) NSArray *data;
@property (nonatomic, assign) BOOL success;

@end
