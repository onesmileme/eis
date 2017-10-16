//
//  WMDingYueChartModel.h
//  EISAir
//
//  Created by DoubleHH on 2017/10/16.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WMDingYueChartStatusdescModel : JSONModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *id;
@end


@interface WMDingYueChartDisvaluesModel : JSONModel
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *tagid;
@property (nonatomic, strong) NSString *value;
@end


@interface WMDingYueChartContrastdisvaluesModel : JSONModel
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *tagid;
@property (nonatomic, strong) NSString *value;
@end


@protocol WMDingYueChartStatusdescModel
@end
@protocol WMDingYueChartDisvaluesModel
@end
@protocol WMDingYueChartContrastdisvaluesModel
@end
@interface WMDingYueChartDataModel : JSONModel
@property (nonatomic, strong) NSArray<WMDingYueChartStatusdescModel> *statusDesc;
@property (nonatomic, strong) NSArray<WMDingYueChartDisvaluesModel> *disValues;
@property (nonatomic, strong) NSArray<WMDingYueChartContrastdisvaluesModel> *contrastDisValues;
@property (nonatomic, strong) NSString *objId;
@property (nonatomic, strong) NSString *objName;
@end


@protocol WMDingYueChartDataModel
@end
@interface WMDingYueChartModel : JSONModel
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) NSString *detailMsg;
@property (nonatomic, strong) NSArray<WMDingYueChartDataModel> *data;
@property (nonatomic, assign) BOOL success;
@end
