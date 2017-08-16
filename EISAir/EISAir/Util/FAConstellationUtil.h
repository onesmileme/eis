//
//  FAConstellationUtil.h
//  FunApp
//
//  Created by wangyan on 16/7/13.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAConstellationUtil : NSObject

+(UIImage *)getConstellation:(NSDate *)date isWhiteStyle:(BOOL)isWhite;
+(UIImage *)getConstellation:(NSDate *)date;

+(NSString *)constellationNameForDate:(NSDate *)date;

@end
