//
//  WMContactUtil.h
//  WaiMai
//
//  Created by DoubleHH on 2017/6/20.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMContactUtil : NSObject

// 分页获取通讯录
+ (void)contactListWithPage:(NSInteger)page completionBlock:(void (^)(NSDictionary *result))completionBlock;

@end
