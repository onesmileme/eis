//
//  EATaskFilterModel.h
//  EISAir
//
//  Created by chunhui on 2017/9/3.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface  EATaskFilterModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *startDate;
@property (nonatomic, copy , nullable) NSString *endDate;
@property (nonatomic, copy , nullable) NSString *pageSize;
@property (nonatomic, copy , nullable) NSString *keyword;
@property (nonatomic, strong , nullable) NSArray *taskTypes;
@property (nonatomic, copy , nullable) NSString *personId;
@property (nonatomic, strong , nullable) NSArray *authObjList;
@property (nonatomic, strong , nullable) NSArray *objList;
@property (nonatomic, copy , nullable) NSString *order;
@property (nonatomic, copy , nullable) NSString *siteId;
@property (nonatomic, copy , nullable) NSString *orgId;
@property (nonatomic, strong , nullable) NSArray *productArray;
@property (nonatomic, copy , nullable) NSString *pageNum;
@property (nonatomic, copy , nullable) NSString *sorts;
@property (nonatomic, strong , nullable) NSArray *taskStatus;
@property (nonatomic, copy , nullable) NSString *dateType;
@property (nonatomic, copy , nullable) NSString *isMyTask;

@end
