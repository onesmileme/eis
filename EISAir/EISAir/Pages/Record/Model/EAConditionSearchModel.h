//
//  EAConditionSearchModel.h
//  EISAir
//
//  Created by iwm on 2017/9/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EAConditionSearchListModel : JSONModel
@property (nonatomic, strong) NSString *assetType;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *assetTypeName;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *hasChildren;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *children;
@property (nonatomic, strong) NSString *hasRelationalMeter;
@property (nonatomic, strong) NSString *priorityNum;
@property (nonatomic, strong) NSString *orgId;
@property (nonatomic, strong) NSString *parentId;
@property (nonatomic, strong) NSString *siteId;
@property (nonatomic, strong) NSString *spaceType;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@end


@protocol EAConditionSearchListModel
@end
@interface EAConditionSearchDataModel : JSONModel
@property (nonatomic, strong) NSNumber *pageNum;
@property (nonatomic, strong) NSNumber *pageSize;
@property (nonatomic, strong) NSArray<EAConditionSearchListModel> *list;
@property (nonatomic, assign) BOOL firstPage;
@property (nonatomic, assign) BOOL lastPage;
@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSNumber *pages;
@end


@interface EAConditionSearchModel : JSONModel
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) NSString *detailMsg;
@property (nonatomic, strong) EAConditionSearchDataModel *data;
@property (nonatomic, assign) BOOL success;
@end
