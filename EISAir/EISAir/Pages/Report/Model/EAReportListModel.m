//
//  EAReportListModel.m
//  EISAir
//
//  Created by iwm on 2017/9/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAReportListModel.h"

@implementation EAReportListListModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"description": @"desc",
                                                                  }];
}
@end


@implementation EAReportListDataModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end


@implementation EAReportListModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
