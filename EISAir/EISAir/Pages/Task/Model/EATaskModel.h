//
//  EATaskModel.h
//  EISAir
//
//  Created by chunhui on 2017/9/3.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol EATaskDataListModel<NSObject>

@end


/*
 {
 "success": true,
 "msg": "查询任务成功",
 "detailMsg": "",
 "data": {
 "id": "402881455e50b19b015e50c17070001c",
 "taskName": "xgorgid",
 "taskType": "check",
 "taskStatus": "invalid",
 "taskFrequency": "day",
 "taskDescription": "xgorgid",
 "fillNum": false,
 "startDate": "2017-09-05 14:36:48",
 "endDate": "2017-09-06 14:36:48",
 "finishDate": null,
 "remindTime": 120,
 "msgId": null,
 "orgId": "8a80cb815e03764a015e03c536ca0064",
 "siteId": "8a80cb815e03764a015e03ce4e310076",
 "templateId": null,
 "createDate": "2017-09-05 14:36:48",
 "updateDate": "2017-09-13 10:52:25",
 "createUser": null,
 "createUserId": "zhangda",
 "myExecuteStatus": null
 },
 "errorCode": null
 }
 */

@interface  EATaskDataListModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *startDate;
@property (nonatomic, copy , nullable) NSString *endDate;
@property (nonatomic, strong , nullable) NSArray *objIdList;
@property (nonatomic, assign) BOOL fillNum;
@property (nonatomic, copy , nullable) NSString *taskType;
@property (nonatomic, copy , nullable) NSString *objType;
@property (nonatomic, copy , nullable) NSString *tid;
@property (nonatomic, strong , nullable) NSArray *personIdList;
@property (nonatomic, copy , nullable) NSString *remindTime;
@property (nonatomic, copy , nullable) NSString *createDate;
@property (nonatomic, copy , nullable) NSString *taskStatus;
@property (nonatomic, copy , nullable) NSString *createUserId;
@property (nonatomic, copy , nullable) NSString *taskFrequency;
@property (nonatomic, copy , nullable) NSString *taskName;
@property (nonatomic, copy , nullable) NSString *msgId;
@property (nonatomic, copy , nullable) NSString *executePerson;
@property (nonatomic, copy , nullable) NSString *taskDescription;
@property (nonatomic, copy , nullable) NSString *siteId;
@property (nonatomic, copy , nullable) NSString *createUser;
@property (nonatomic, strong , nullable) NSArray *objNameList;
@property (nonatomic, copy , nullable) NSString *executeStatus;
@property (nonatomic, copy , nullable) NSString *finishDate;
@property (nonatomic, copy , nullable) NSString *orgId;
@property (nonatomic, copy , nullable) NSString *updateDate;
@property (nonatomic, copy , nullable) NSString *templateId;
@property (nonatomic, strong , nullable) NSArray *personNameList;
@property (nonatomic, copy , nullable) NSString *myExecuteStatus;

@end


@interface  EATaskDataModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *pageNum;
@property (nonatomic, copy , nullable) NSString *pageSize;
@property (nonatomic, strong , nullable) NSArray<EATaskDataListModel> *list;
@property (nonatomic, assign) BOOL firstPage;
@property (nonatomic, assign) BOOL lastPage;
@property (nonatomic, copy , nullable) NSString *total;
@property (nonatomic, copy , nullable) NSString *pages;

@end


@interface  EATaskModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *errorCode;
@property (nonatomic, copy , nullable) NSString *msg;
@property (nonatomic, copy , nullable) NSString *detailMsg;
@property (nonatomic, strong , nullable) EATaskDataModel *data ;
@property (nonatomic, assign) BOOL success;

@end


