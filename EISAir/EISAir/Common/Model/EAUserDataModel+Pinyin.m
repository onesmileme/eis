//
//  EAUserDataModel+Pinyin.m
//  EISAir
//
//  Created by chunhui on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAUserDataModel+Pinyin.h"
#import "NSString+pinyin.h"

@implementation EAUserDataModel (Pinyin)

-(NSDictionary *)userPinyinDict
{
    return [[self class] userPinyinDictForList:self.list];
}
+(NSDictionary *)userPinyinDictForList:(NSArray<EAUserDataListModel *>*)list
{
    if (list.count == 0) {
        return nil;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    for (EAUserDataListModel * user in list) {
        NSString *py = [user.name pinyinString];
        if (py.length > 0) {
            NSString *cap = [[py substringWithRange:NSMakeRange(0, 1)] uppercaseString];
            NSMutableArray *array = dict[cap];
            if (array == nil) {
                array = [NSMutableArray new];
                dict[cap] = array;
            }
            [array addObject:user];
        }
    }
 
    return dict;
}

@end
