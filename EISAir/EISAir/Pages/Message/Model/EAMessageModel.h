//
//  EAMessageModel.h
//  EISAir
//
//  Created by chunhui on 2017/8/31.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol EAMessageDataListModel<NSObject>

@end


@protocol EAMessageDataListMessageFollowersModel<NSObject>

@end


@interface  EAMessageDataListMessageFollowersModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *readStatus;
@property (nonatomic, copy , nullable) NSString *personName;
@property (nonatomic, copy , nullable) NSString *personId;
@property (nonatomic, copy , nullable) NSString *siteId;
@property (nonatomic, copy , nullable) NSString *orgId;

@end


@interface  EAMessageDataListModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *msgObject;
@property (nonatomic, copy , nullable) NSString *msgTarget;
@property (nonatomic, strong , nullable) NSArray<EAMessageDataListModel> *eisMessageContentVos;
@property (nonatomic, copy , nullable) NSString *msgContent;
@property (nonatomic, strong , nullable) NSArray *objectIdList;
@property (nonatomic, copy , nullable) NSString *createDate;
@property (nonatomic, copy , nullable) NSString *msgTitle;
@property (nonatomic, copy , nullable) NSString *msgSource;
@property (nonatomic, copy , nullable) NSString *pointId;
@property (nonatomic, copy , nullable) NSString *msgType;
@property (nonatomic, strong , nullable) NSArray *objectTypeList;
@property (nonatomic, copy , nullable) NSString *orgId;
@property (nonatomic, strong , nullable) NSArray<EAMessageDataListMessageFollowersModel> *messageFollowers;
@property (nonatomic, copy , nullable) NSString *taskId;
@property (nonatomic, copy , nullable) NSString *address;
@property (nonatomic, copy , nullable) NSString *siteId;
@property (nonatomic, copy , nullable) NSString *mid;
@property (nonatomic, copy , nullable) NSString *pointName;

@end


@interface  EAMessageDataModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *orderBy;
@property (nonatomic, assign) BOOL isLastPage;
@property (nonatomic, copy , nullable) NSString *pageNum;
@property (nonatomic, assign) BOOL hasNextPage;
@property (nonatomic, copy , nullable) NSString *navigatePages;
@property (nonatomic, copy , nullable) NSString *prePage;
@property (nonatomic, copy , nullable) NSString *size;
@property (nonatomic, strong , nullable) NSArray<EAMessageDataListModel> *list;
@property (nonatomic, copy , nullable) NSString *firstPage;
@property (nonatomic, copy , nullable) NSString *startRow;
@property (nonatomic, copy , nullable) NSString *lastPage;
@property (nonatomic, assign) BOOL hasPreviousPage;
@property (nonatomic, copy , nullable) NSString *total;
@property (nonatomic, assign) BOOL isFirstPage;
@property (nonatomic, copy , nullable) NSString *pageSize;
@property (nonatomic, copy , nullable) NSString *navigatepageNums;
@property (nonatomic, copy , nullable) NSString *pages;
@property (nonatomic, copy , nullable) NSString *nextPage;
@property (nonatomic, copy , nullable) NSString *endRow;

@end


@interface  EAMessageModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *errorCode;
@property (nonatomic, copy , nullable) NSString *msg;
@property (nonatomic, copy , nullable) NSString *detailMsg;
@property (nonatomic, strong , nullable) EAMessageDataModel *data ;
@property (nonatomic, assign) BOOL success;

@end
