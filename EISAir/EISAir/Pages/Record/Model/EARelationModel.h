//
//  EARelationModel.h
//  EISAir
//
//  Created by iwm on 2017/9/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EARelationDataModel : JSONModel
@property (nonatomic, strong) NSString *Meter_Meter_Apply;
@property (nonatomic, strong) NSString *Space_Space_Contain;
@property (nonatomic, strong) NSString *Meter_Meter_Target;
@property (nonatomic, strong) NSString *Asset_Meter_InWater;
@property (nonatomic, strong) NSString *Asset_Meter_Fixed;
@property (nonatomic, strong) NSString *Meter_Meter_SetAndFeedBack;
@property (nonatomic, strong) NSString *Space_Space_Topology;
@property (nonatomic, strong) NSString *Asset_Meter_InWind;
@property (nonatomic, strong) NSString *Meter_Meter_ControlMonitor;
@property (nonatomic, strong) NSString *Space_Asset_Fixed;
@property (nonatomic, strong) NSString *Space_Meter_Contain;
@property (nonatomic, strong) NSString *Asset_Asset_InControlNet;
@property (nonatomic, strong) NSString *Asset_Asset_Meterage;
@property (nonatomic, strong) NSString *Asset_Asset_Join;
@property (nonatomic, strong) NSString *Asset_Space_InService;
@end


@interface EARelationModel : JSONModel
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) NSString *detailMsg;
@property (nonatomic, strong) EARelationDataModel *data;
@property (nonatomic, assign) BOOL success;
@end
