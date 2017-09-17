//
//  EATaskStatusModel.h
//  EISAir
//
//  Created by chunhui on 2017/9/17.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol EATaskStatusDataModel<NSObject>

@end


@interface  EATaskStatusDataModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *taskId;
@property (nonatomic, copy , nullable) NSString *deliveryTime;
@property (nonatomic, copy , nullable) NSString *personId;
@property (nonatomic, copy , nullable) NSString *anewStatus;
@property (nonatomic, copy , nullable) NSString *createDate;
@property (nonatomic, copy , nullable) NSString *taskExecuteDesc;
@property (nonatomic, copy , nullable) NSString *transferPersonId;
@property (nonatomic, copy , nullable) NSString *taskResult;
@property (nonatomic, copy , nullable) NSString *taskName;
@property (nonatomic, copy , nullable) NSString *tid;

@end


@interface  EATaskStatusModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *errorCode;
@property (nonatomic, copy , nullable) NSString *msg;
@property (nonatomic, copy , nullable) NSString *detailMsg;
@property (nonatomic, strong , nullable) NSArray<EATaskStatusDataModel> *data;
@property (nonatomic, assign) BOOL success;

@end
