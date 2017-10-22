//
//  EANetworkQueueManager.h
//  EISAir
//
//  Created by chunhui on 2017/10/22.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EATaskItemDataModel;

@interface EANetworkQueueManager : NSObject

DEF_SINGLETON;

-(void)addTaskEditItem:(EATaskItemDataModel *)item;


@end
