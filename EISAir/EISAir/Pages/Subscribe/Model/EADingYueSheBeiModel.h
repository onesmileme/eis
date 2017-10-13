//
//  EADingYueSheBeiModel.h
//  EISAir
//
//  Created by DoubleHH on 2017/10/13.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EADingYueSheBeiDataModel : JSONModel
@property (nonatomic, strong) NSString *classificationParentName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *id;
@end


@protocol EADingYueSheBeiDataModel
@end
@interface EADingYueSheBeiModel : JSONModel
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) NSString *detailMsg;
@property (nonatomic, strong) NSArray<EADingYueSheBeiDataModel> *data;
@property (nonatomic, assign) BOOL success;
@end
