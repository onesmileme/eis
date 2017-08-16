//
//  FAConstellationUtil.m
//  FunApp
//
//  Created by wangyan on 16/7/13.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "FAConstellationUtil.h"

@implementation FAConstellationUtil

+(UIImage *)getConstellation:(NSDate *)date isWhiteStyle:(BOOL)isWhite
{
    
    UIImage *conImage;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    int month = 0;
    NSString *theMonth = [dateFormat stringFromDate:date];
    if([[theMonth substringToIndex:0] isEqualToString:@"0"]) {
        month = [[theMonth substringFromIndex:1] intValue];
    } else {
        month = [theMonth intValue];
    }
    
    [dateFormat setDateFormat:@"dd"];
    int day = 0;
    NSString *theDay = [dateFormat stringFromDate:date];
    if([[theDay substringToIndex:0] isEqualToString:@"0"]) {
        day = [[theDay substringFromIndex:1] intValue];
    } else {
        day = [theDay intValue];
    }
    NSString * image = nil;
    switch (month) {
        case 1:
            if(day>=20 && day<=31){
                //                retStr=@"水瓶座";
                image = @"Aquarius";
            }
            if(day>=1 && day<=19){
                //                retStr=@"摩羯座";
                image = @"Capricorn";
            }
            break;
        case 2:
            if(day>=1 && day<=18){
                //                retStr=@"水瓶座";
                image = @"Aquarius";
            }
            if(day>=19 && day<=31){
                //                retStr=@"双鱼座";
                image = @"Pisces";
            }
            break;
        case 3:
            if(day>=1 && day<=20){
                //                retStr=@"双鱼座";
                image = @"Pisces";
            }
            if(day>=21 && day<=31){
                image = @"Aries";
            }
            break;
        case 4:
            if(day>=1 && day<=19){
                image = @"Aries";
            }
            if(day>=20 && day<=31){
                //                retStr=@"金牛座";
                image = @"Taurus";
            }
            break;
        case 5:
            if(day>=1 && day<=20){
                //                retStr=@"金牛座";
                image = @"Taurus";
            }
            if(day>=21 && day<=31){
                //                retStr=@"双子座";
                image = @"Gemini";
            }
            break;
        case 6:
            if(day>=1 && day<=21){
                //                retStr=@"双子座";
                image = @"Gemini";
            }
            if(day>=22 && day<=31){
                //                retStr=@"巨蟹座";
                image = @"seat";
            }
            break;
        case 7:
            if(day>=1 && day<=22){
                //                retStr=@"巨蟹座";
                image = @"seat";
            }
            if(day>=23 && day<=31){
                image = @"Leo";
            }
            break;
        case 8:
            if(day>=1 && day<=22){
                image = @"Leo";
            }
            if(day>=23 && day<=31){
                //                retStr=@"处女座";
                image = @"virgo";
            }
            break;
        case 9:
            if(day>=1 && day<=22){
                //                retStr=@"处女座";
                image = @"virgo";
            }
            if(day>=23 && day<=31){
                //                retStr=@"天秤座";
                image = @"libra";
            }
            break;
        case 10:
            if(day>=1 && day<=23){
                //                retStr=@"天秤座";
                image = @"libra";
            }
            
            if(day>=24 && day<=31){
                //                retStr=@"天蝎座";
                image = @"Scorpio";
            }
            break;
        case 11:
            if(day>=1 && day<=21){
                //                retStr=@"天蝎座";
                image = @"Scorpio";
            }
            if(day>=22 && day<=31){
                //                retStr=@"射手座";
                image = @"Sagittarius";
            }
            break;
        case 12:
            if(day>=1 && day<=21){
                //                retStr=@"射手座";
                image = @"Sagittarius";
            }
            if(day>=21 && day<=31){
                //                retStr=@"摩羯座";
                image = @"Capricorn";
            }
            break;
    }
    
    if (isWhite) {
        image = [NSString stringWithFormat:@"%@%@",image,@"_white"];
    }
    
    conImage = [UIImage imageNamed:image];
    
    return conImage;
}

+(UIImage *)getConstellation:(NSDate *)date
{
    
    UIImage *conImage = [self getConstellation:date isWhiteStyle:false];
        
    return conImage;
}

+(NSString *)constellationNameForDate:(NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    int month = 0;
    NSString *theMonth = [dateFormat stringFromDate:date];
    if([[theMonth substringToIndex:0] isEqualToString:@"0"]) {
        month = [[theMonth substringFromIndex:1] intValue];
    } else {
        month = [theMonth intValue];
    }
    
    [dateFormat setDateFormat:@"dd"];
    int day = 0;
    NSString *theDay = [dateFormat stringFromDate:date];
    if([[theDay substringToIndex:0] isEqualToString:@"0"]) {
        day = [[theDay substringFromIndex:1] intValue];
    } else {
        day = [theDay intValue];
    }
    switch (month) {
        case 1:
            if(day>=20 && day<=31){
                return @"水瓶座";
                
            }
            if(day>=1 && day<=19){
                return @"摩羯座";

            }
            break;
        case 2:
            if(day>=1 && day<=18){
                return @"水瓶座";
            }
            if(day>=19 && day<=31){
                return @"双鱼座";
            }
            break;
        case 3:
            if(day>=1 && day<=20){
                return @"双鱼座";
            }
            if(day>=21 && day<=31){
                return @"白羊座";
            }
            break;
        case 4:
            if(day>=1 && day<=19){
                return @"白羊座";
            }
            if(day>=20 && day<=31){
                return @"金牛座";
            }
            break;
        case 5:
            if(day>=1 && day<=20){
                return @"金牛座";
            }
            if(day>=21 && day<=31){
                return @"双子座";
            }
            break;
        case 6:
            if(day>=1 && day<=21){
                return @"双子座";
            }
            if(day>=22 && day<=31){
                return @"巨蟹座";
            }
            break;
        case 7:
            if(day>=1 && day<=22){
                return @"巨蟹座";
            }
            if(day>=23 && day<=31){
                return @"狮子座";
            }
            break;
        case 8:
            if(day>=1 && day<=22){
                return @"狮子座";
            }
            if(day>=23 && day<=31){
                return @"处女座";
            }
            break;
        case 9:
            if(day>=1 && day<=22){
                return @"处女座";
            }
            if(day>=23 && day<=31){
                return @"天秤座";
            }
            break;
        case 10:
            if(day>=1 && day<=23){
                return @"天秤座";
            }
            
            if(day>=24 && day<=31){
                return @"天蝎座";
            }
            break;
        case 11:
            if(day>=1 && day<=21){
                return @"天蝎座";
            }
            if(day>=22 && day<=31){
                return @"射手座";
            }
            break;
        case 12:
            if(day>=1 && day<=21){
                return @"射手座";
            }
            if(day>=21 && day<=31){
                return @"摩羯座";
            }
            break;
    }
    return nil;

}


@end
