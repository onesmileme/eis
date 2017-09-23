//
//  EATaskUpdateModel.h
//  EISAir
//
//  Created by chunhui on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EATaskUpdateModel : JSONModel

@property (nonatomic, strong , nullable) NSArray *transferPersonIds;
@property (nonatomic, copy , nullable) NSString *taskResult;
@property (nonatomic, copy , nullable) NSString *personId;
@property (nonatomic, copy , nullable) NSString *anewStatus;
@property (nonatomic, copy , nullable) NSString *taskId;
@property (nonatomic, copy , nullable) NSString *tid;

@end
