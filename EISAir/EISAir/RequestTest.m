//
//  RequestTest.m
//  EISAir
//
//  Created by chunhui on 2017/9/3.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "RequestTest.h"
#import "EAMsgFilterModel.h"
#import "EATaskFilterModel.h"
#import "TKAccountManager.h"
#import "TKRequestHandler.h"

@implementation RequestTest

+(void)load
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        RequestTest *tester = [[RequestTest alloc]init];
//        [tester msgTest];
//        
//    });
}

-(void)msgTest
{
    //GET /eis/open/task/findTaskResultByTaskId
    //POST /eis/open/msg/findMsgTitleList
#if kOnLine
    NSString *path = [NSString stringWithFormat:@"%@/eis/open/msg/findMsgTitleList",AppHost];
#else
    NSString *path = [NSString stringWithFormat:@"%@/app/eis/open/msg/findMsgTitleList",AppHost];
#endif
    NSLog(@"path is: \n%@\n\n",path);
    
    EAMsgFilterModel *model = [[EAMsgFilterModel alloc]init];
    
    
    
    EALoginUserInfoDataModel *udata = [TKAccountManager sharedInstance].loginUserInfo;
    NSDictionary *param = nil;//@{@"personId":udata.personId?:@"",@"orgId":udata.orgId?:@"",@"siteId":udata.siteId?:@"",@"pageSize":@"20",@"pageNum":@"0"};
    
    model.personId = udata.personId;
    model.orgId = udata.orgId;
    model.siteId = udata.siteId;
    
    model.pageNum = @"0";
    model.pageSize = @"100";
    
    /*
     *  "EIS_MSG_TYPE_NOTICE": "通知",
     *  "EIS_MSG_TYPE_ALARM": "报警",
     *  "EIS_MSG_TYPE_RECORD": "人工记录",
     *  "EIS_MSG_TYPE_EXCEPTION": "异常"
     */
    model.msgTypes = @[@"EIS_MSG_TYPE_NOTICE",@"EIS_MSG_TYPE_ALARM"];
    
    param = [model toDictionary];
    
    //@{@"msgId":@"AV48ho8x0f-qWHUcq9_2"};//
    
    //@{@"id":@""};//
    //    @{@"username":@"lisi",@"password":@"123456",@"grant_type":@"password",@"prod":@"EIS"};
    //@"personId":udata.personId?:@"",
    
    //    TKRequestHandler *handler = [TKRequestHandler sharedInstance];
    //    [handler setAuthorizationHeaderFieldWithUsername:@"lisi" password:@"123456"];
    
    //siteId=4028e6eb5bec80c2015bec871ee30012&pageSize=20&pageNum=1&orgId=4028e6eb5bec6d12015bec6e38bd0021
    
    NSLog(@"param is: %@\n\n",param);
    
    
    [[TKRequestHandler sharedInstance]postRequestForPath:path param:param finish:^(NSURLSessionDataTask * _Nullable sessionDataTask, id  _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error is: \n%@\n\n",error);
            NSData *d = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSString *info = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
            NSLog(@"info is: \n%@\n",info);
        }
        
        if (response) {
            NSLog(@"response is:\n%@\n\n",response);
            NSData *data = [NSJSONSerialization dataWithJSONObject:response options:kNilOptions error:nil];
            NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"json is:\n\n%@\n\n",json);
        }
    }];
}

@end
