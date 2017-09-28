//
//  EAEnergyModel.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/28.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EAEnergyNodesModel : JSONModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *measure;
@end


@interface EAEnergyLinksModel : JSONModel
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *targetId;
@property (nonatomic, strong) NSString *target;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *measure;
@end


@protocol EAEnergyNodesModel
@end
@protocol EAEnergyLinksModel
@end
@interface EAEnergyDataModel : JSONModel
@property (nonatomic, strong) NSArray<EAEnergyNodesModel> *nodes;
@property (nonatomic, strong) NSArray<EAEnergyLinksModel> *links;
@end


@interface EAEnergyModel : JSONModel
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) NSString *detailMsg;
@property (nonatomic, strong) EAEnergyDataModel *data;
@property (nonatomic, assign) BOOL success;
@end
