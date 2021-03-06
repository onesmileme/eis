//
//  EAMsgFilterModel.h
//  EISAir
//
//  Created by chunhui on 2017/9/3.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface  EAMsgFilterModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *startDate;
@property (nonatomic, strong , nullable) NSArray *msgTypes;
@property (nonatomic, copy , nullable) NSString *endDate;
@property (nonatomic, copy , nullable) NSString *pageSize;
@property (nonatomic, copy , nullable) NSString *keyword;
@property (nonatomic, strong , nullable) NSArray *msgTitles;
@property (nonatomic, copy , nullable) NSString *personId;
@property (nonatomic, strong , nullable) NSArray *objList;//tagid list
@property (nonatomic, copy , nullable) NSString *siteId;
@property (nonatomic, copy , nullable) NSString *personName;
@property (nonatomic, assign) BOOL isAdmin;
@property (nonatomic, copy , nullable) NSString *orgId;
@property (nonatomic, copy , nullable) NSString *objName;
@property (nonatomic, strong , nullable) NSArray *productArray;
@property (nonatomic, copy , nullable) NSString *pageNum;
@property (nonatomic, copy , nullable) NSString *sorts;
@property (nonatomic, copy , nullable) NSString *dateType;
@property (nonatomic, copy , nullable) NSString *order;

@end
