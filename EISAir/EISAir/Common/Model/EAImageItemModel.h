//
//  EACmageItemModel.h
//  WeRead
//
//  Created by chunhui on 16/5/28.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "EABaseImageModel.h"

@protocol EAImageItemModel <NSObject>


@end

@interface EAImageItemModel : JSONModel

@property(nonatomic , strong , nullable) EABaseImageModel * n ;
@property(nonatomic , strong , nullable) EABaseImageModel * s ;
@property(nonatomic , strong , nullable) EABaseImageModel * t ;

@end
