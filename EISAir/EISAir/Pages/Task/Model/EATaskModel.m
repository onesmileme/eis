//
//  EATaskModel.m
//  EISAir
//
//  Created by chunhui on 2017/9/3.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskModel.h"

@implementation  EATaskDataListModel

+(JSONKeyMapper *)keyMapper
{
    NSDictionary *dict = @{@"tid":@"id"};
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:dict];
}

@end


@implementation  EATaskModel
@end


@implementation  EATaskDataModel
@end



