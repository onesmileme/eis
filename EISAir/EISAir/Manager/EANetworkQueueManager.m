//
//  EANetworkQueueManager.m
//  EISAir
//
//  Created by chunhui on 2017/10/22.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EANetworkQueueManager.h"
#import "EATaskItemModel.h"
#import "TKNetworkManager.h"
#import "TMCache.h"
#import "TKRequestHandler+Task.h"

@interface EANetworkQueueManager()

@property(nonatomic , strong) NSMutableArray *taskEditItems;
@property(nonatomic , assign) NSInteger editTaskReTryCount ;

@end

@implementation EANetworkQueueManager

IMP_SINGLETON

-(instancetype)init
{
    self = [super init];
    if (self) {
        _taskEditItems = [NSMutableArray new];
        
        [NotificationCenter addObserver:self selector:@selector(onNetworkChangeNotfication:) name:kTKNetworkChangeNotification object:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self resumeRequest];
        });
    }
    return self;
}

-(void)dealloc
{
    [NotificationCenter removeObserver:self];
}

-(void)addTaskEditItem:(EATaskItemDataModel *)item
{
    [_taskEditItems addObject:item];
    [self synTaskItems];
}

-(void)synTaskItems
{
    TMCache *cacher = [TMCache sharedCache];
    NSString *key = @"_task_edit_item_";
    if (_taskEditItems.count > 0) {
        [cacher setObject:_taskEditItems forKey:key];
    }else{
        [cacher removeObjectForKey:key];
    }
}

-(void)resumeEditTask
{
    if (_taskEditItems.count == 0) {
        return;
    }
    
    EATaskItemDataModel *item = [_taskEditItems firstObject];
    if (item) {
        __weak typeof(self) wself = self;
        [[TKRequestHandler sharedInstance] savePointData:item.tagid createDate:item.meterDate value:item.readCount completion:^(NSURLSessionDataTask *task, BOOL success, NSError *error) {
            
            if (error && error.code == -1009) {
                //not reachable
                wself.editTaskReTryCount = 0;
                return;
            }
            
            [wself.taskEditItems removeObjectAtIndex:0];
            if (!success) {
                [wself.taskEditItems addObject:item];
                wself.editTaskReTryCount++;
                if (wself.editTaskReTryCount > 5) {
                    //too much retry
                    return;
                }
            }else{
                [wself synTaskItems];
            }
            if (wself.taskEditItems.count > 0) {
                [wself resumeEditTask];
            }
        }];
    }
}

-(void)resumeRequest
{
    if (_taskEditItems.count > 0) {
        self.editTaskReTryCount = 0;
        [self resumeEditTask];
    }
}

-(void)onNetworkChangeNotfication:(NSNotification *)notification
{
    NSDictionary *statusInfo = notification.userInfo;
    NetworkStatus status = [statusInfo[@"status"] integerValue];
    
    if (status != NotReachable) {
        
    }
}

-(void)logoutNotfication:(NSNotification *)notfication
{
    [self.taskEditItems removeAllObjects];
}

@end
