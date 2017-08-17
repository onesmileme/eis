//
//  EABaseImageModel.m
//  WeRead
//
//  Created by chunhui on 16/5/26.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "EABaseImageModel.h"

@implementation EABaseImageModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"url"]) {
        return false;
    }
    return YES;
}

@end
