//
//  EAReportPageListModel.h
//  EISAir
//
//  Created by iwm on 2017/9/24.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EAReportPageListDataModel : JSONModel
@property (nonatomic, strong) NSString *reportName;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *createUserName;
@property (nonatomic, strong) NSString *siteId;
@property (nonatomic, strong) NSString *createUserId;
@property (nonatomic, strong) NSString *orgId;
@property (nonatomic, strong) NSString *reportId;
@property (nonatomic, strong) NSArray *receivePersonIds;
@property (nonatomic, strong) NSString *reportType;
@property (nonatomic, strong) NSArray *receivePersonNames;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, assign) BOOL isRead;
@end


@protocol EAReportPageListDataModel
@end
@interface EAReportPageListModel : JSONModel
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) NSString *detailMsg;
@property (nonatomic, strong) NSArray<EAReportPageListDataModel> *data;
@property (nonatomic, assign) BOOL success;
@end
