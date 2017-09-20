//
//  EAUserDataModel+Pinyin.h
//  EISAir
//
//  Created by chunhui on 2017/9/20.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAUserModel.h"

@interface EAUserDataModel (Pinyin)

-(NSDictionary *)userPinyinDict;

+(NSDictionary *)userPinyinDictForList:(NSArray<EAUserDataListModel *>*)list;

@end
