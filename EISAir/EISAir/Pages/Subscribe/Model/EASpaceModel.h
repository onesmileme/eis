//
//  EASpaceModel.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EASpaceBuildlistModel : JSONModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *id;
@end

@protocol EASpaceBuildlistModel
@end
@interface EASpaceRoomlistModel : JSONModel
@property (nonatomic, assign) BOOL isHaveException;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, assign) BOOL isHaveAlarm;
@property (nonatomic, strong) NSArray<EASpaceBuildlistModel> *devices;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *disInstantValue;
@property (nonatomic, strong) NSString *endValue;
@property (nonatomic, strong) NSString *disStatusValue;
@property (nonatomic, strong) NSString *startValue;
@end


@protocol EASpaceRoomlistModel
@end
@interface EASpaceFloorlistModel : JSONModel
@property (nonatomic, strong) NSArray<EASpaceRoomlistModel> *roomList;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *id;
@end


@protocol EASpaceFloorlistModel
@end
@interface EASpaceDataModel : JSONModel
@property (nonatomic, strong) NSString *lowId;
@property (nonatomic, strong) NSString *lowValue;
@property (nonatomic, strong) NSString *lowName;
@property (nonatomic, strong) NSString *siteName;
@property (nonatomic, strong) NSArray<EASpaceBuildlistModel> *buildList;
@property (nonatomic, strong) NSString *highName;
@property (nonatomic, strong) NSString *highId;
@property (nonatomic, strong) NSString *highValue;
@property (nonatomic, strong) NSArray<EASpaceFloorlistModel> *floorList;
@end


@interface EASpaceModel : JSONModel
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) NSString *detailMsg;
@property (nonatomic, strong) EASpaceDataModel *data;
@property (nonatomic, assign) BOOL success;
@end
