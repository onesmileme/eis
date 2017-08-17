//
//  WRBaseImageModel.h
//  WeRead
//
//  Created by chunhui on 16/5/26.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "JSONModel.h"

@interface EABaseImageModel : JSONModel

@property(nonatomic , copy)   NSString * url;
@property(nonatomic , strong) NSNumber * h;
@property(nonatomic , strong) NSNumber * w;

@end
