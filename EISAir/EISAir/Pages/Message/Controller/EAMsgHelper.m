//
//  EAMsgHelper.m
//  EISAir
//
//  Created by chunhui on 2017/9/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAMsgHelper.h"
#import "EADefines.h"

@implementation EAMsgHelper

+(UIColor *)colorForMsgType:(NSString *)msgtype
{
    
    UIColor *color = nil;
    /*
     #define EIS_MSG_TYPE_NOTICE @"EIS_MSG_TYPE_NOTICE" //"通知"
     #define EIS_MSG_TYPE_ALARM @"EIS_MSG_TYPE_ALARM" //"报警"
     #define EIS_MSG_TYPE_RECORD @"EIS_MSG_TYPE_RECORD" // "人工记录",
     #define EIS_MSG_TYPE_EXCEPTION @"EIS_MSG_TYPE_EXCEPTION"// "异常"
     */
    
    if ([msgtype isEqualToString:EIS_MSG_TYPE_NOTICE]) {
        color = HexColor(0x28CFC1);
    }else if ([msgtype isEqualToString:EIS_MSG_TYPE_ALARM]){
        color = HexColor(0xFFB549);
    }else if ([msgtype isEqualToString:EIS_MSG_TYPE_RECORD]){
        color = HexColor(0x00B0CE);
    }else if ([msgtype isEqualToString:EIS_MSG_TYPE_EXCEPTION]){
        color = HexColor(0xFF6663);
    }
    
    return color;
}

+(NSString *)detailTagForMsgType:(NSString *)msgType
{
    /*
     <string name="tag_msg_warn">报警\n标签</string>
     <string name="tag_msg_error">异常\n标签</string>
     <string name="tag_msg_notice">通知\n标签</string>
     <string name="tag_msg_record">人工\n记录</string>

     */
    NSString *title = nil;
    if ([msgType isEqualToString:EIS_MSG_TYPE_NOTICE]) {
        title = @"通知\n标签";
    }else if ([msgType isEqualToString:EIS_MSG_TYPE_ALARM]){
        title = @"报警\n标签";
    }else if ([msgType isEqualToString:EIS_MSG_TYPE_RECORD]){
        title = @"人工\n记录";
    }else if ([msgType isEqualToString:EIS_MSG_TYPE_EXCEPTION]){
        title = @"异常\n标签";
    }
    
    
    return title;
}

@end
