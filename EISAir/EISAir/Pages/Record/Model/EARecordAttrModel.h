//
//  EARecordAttrModel.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/25.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EARecordAttrDataModel : JSONModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *id;
@end


@protocol EARecordAttrDataModel
@end
@interface EARecordAttrModel : JSONModel
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) NSString *detailMsg;
@property (nonatomic, strong) NSArray<EARecordAttrDataModel> *data;
@property (nonatomic, assign) BOOL success;
@end
