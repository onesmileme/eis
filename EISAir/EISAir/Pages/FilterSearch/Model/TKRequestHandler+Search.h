//
//  TKRequestHandler+Search.h
//  EISAir
//
//  Created by chunhui on 2017/9/16.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "TKRequestHandler.h"
#import "EAMsgSearchTipModel.h"
#import "EAMsgFilterModel.h"


@interface TKRequestHandler (Search)

-(NSURLSessionDataTask *)searchWithFilterParam:(EAMsgFilterModel *)param completion:(void (^)(NSURLSessionDataTask *task , EAMsgSearchTipModel *model , NSError *error))completion;

@end
