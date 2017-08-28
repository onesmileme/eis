//
//  TKRequestHandler+Config.h
//  EISAir
//
//  Created by chunhui on 2017/8/28.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler.h"

@interface TKRequestHandler (Config)

/*
 * 拉取主页tab 名称
 */
-(NSURLSessionDataTask *)loadHomeConfCompletion:(void (^)(NSURLSessionDataTask * task , NSDictionary *dict , NSError *error))completion;

/*
 * 获取时间配置
 * dict 
 *  "yesterday": "昨天",
 *  "week": "本周",
 *  "month": "本月",
 *  "today": "今天",
 *  "fixed": "选择日期",
 *  "section": "日期区间"
 */
-(NSURLSessionDataTask *)loadDateConfCompletion:(void (^)(NSURLSessionDataTask * task , NSDictionary *dict , NSError *error))completion;

/*
 * 获取消息启用配置
 * dict
 *  "enable": "启用",
 *  "disable": "禁用"
 */
-(NSURLSessionDataTask *)loadMsgAbleListCompletion:(void (^)(NSURLSessionDataTask * task , NSDictionary *dict , NSError *error))completion;

/*
 * 获取消息类型
 * dict
 *  "EIS_MSG_TYPE_NOTICE": "通知",
 *  "EIS_MSG_TYPE_ALARM": "报警",
 *  "EIS_MSG_TYPE_RECORD": "人工记录",
 *  "EIS_MSG_TYPE_EXCEPTION": "异常"
 */
-(NSURLSessionDataTask *)loadMsgTypeListCompletion:(void (^)(NSURLSessionDataTask * task , NSDictionary *dict , NSError *error))completion;

/*
 * 获取提醒时间
 * dict
 *  "120": "提前两小时",
 *  "180": "提前三小时",
 *  "240": "提前三小时"
 */
-(NSURLSessionDataTask *)loadReminderTimeListCompletion:(void (^)(NSURLSessionDataTask * task , NSDictionary *dict , NSError *error))completion;

/*
 * 获取任务状态
 * dcit
 *  "wait": "待执行",
 *  "invalid": "已失效",
 *  "finish": "已完成",
 *  "execute": "执行中"
 */
-(NSURLSessionDataTask *)loadTaskStatusListCompletion:(void (^)(NSURLSessionDataTask * task , NSDictionary *dict , NSError *error))completion;

/**
 * 获取任务类型
 * dict
 *  "check": "临时",
 *  "plan": "计划"
 */
-(NSURLSessionDataTask *)loadTaskTypeListCompletion:(void (^)(NSURLSessionDataTask * task , NSDictionary *dict , NSError *error))completion;
@end
