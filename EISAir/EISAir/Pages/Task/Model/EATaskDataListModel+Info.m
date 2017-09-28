//
//  EATaskDataListModel+Info.m
//  EISAir
//
//  Created by chunhui on 2017/9/28.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EATaskDataListModel+Info.h"

@implementation EATaskDataListModel (Info)

-(NSString *)objNames
{
    return [self.objNameList componentsJoinedByString:@" "];
}

@end
