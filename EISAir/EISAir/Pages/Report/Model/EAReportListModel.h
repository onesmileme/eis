//
//  EAReportListModel.h
//  EISAir
//
//  Created by iwm on 2017/9/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EAReportListListModel : JSONModel
@property (nonatomic, strong) NSString *reportName;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *createUserName;
@property (nonatomic, strong) NSString *createUserId;
@property (nonatomic, strong) NSString *reportType;
@property (nonatomic, strong) NSArray *receivePersonIds;
@property (nonatomic, strong) NSArray *receivePersonNames;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *generateCount;
@end


@protocol EAReportListListModel
@end
@interface EAReportListDataModel : JSONModel
@property (nonatomic, strong) NSNumber *pageNum;
@property (nonatomic, strong) NSNumber *pageSize;
@property (nonatomic, strong) NSArray<EAReportListListModel> *list;
@property (nonatomic, assign) BOOL firstPage;
@property (nonatomic, assign) BOOL lastPage;
@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSNumber *pages;
@end

@interface EAReportListModel : JSONModel
@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *detailMsg;
@property (nonatomic, strong) EAReportListDataModel *data;
@property (nonatomic, assign) BOOL success;
@end
