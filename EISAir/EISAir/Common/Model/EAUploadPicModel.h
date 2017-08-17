//
//  EAUploadPicModel.h
//  FunApp
//
//  Created by chunhui on 16/6/28.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "JSONModel.h"
#import "EAImageItemModel.h"

@interface  EAUploadPicDataModel  : JSONModel

@property(nonatomic , strong) EAImageItemModel * img ;

@end

@interface EAUploadPicModel : JSONModel

@property(nonatomic , strong) NSNumber * dErrno;
@property(nonatomic , strong) EAUploadPicDataModel * data ;
@property(nonatomic , copy)   NSString * errmsg;

@end
