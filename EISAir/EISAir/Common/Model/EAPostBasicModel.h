//
//  EAPostBasicModel.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/26.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EAPostBasicModel : JSONModel
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) NSString *detailMsg;
@property (nonatomic, assign) BOOL success;
@end
