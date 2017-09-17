//
//  EAUserModel.h
//  EISAir
//
//  Created by chunhui on 2017/9/17.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol EAUserDataListModel<NSObject>

@end


@interface  EAUserDataListModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *name;
@property (nonatomic, copy , nullable) NSString *uid;

@end


@interface  EAUserDataModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *pageNum;
@property (nonatomic, copy , nullable) NSString *pageSize;
@property (nonatomic, strong , nullable) NSArray<EAUserDataListModel> *list;
@property (nonatomic, assign) BOOL firstPage;
@property (nonatomic, assign) BOOL lastPage;
@property (nonatomic, copy , nullable) NSString *total;
@property (nonatomic, copy , nullable) NSString *pages;

@end


@interface  EAUserModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *errorCode;
@property (nonatomic, copy , nullable) NSString *msg;
@property (nonatomic, copy , nullable) NSString *detailMsg;
@property (nonatomic, strong , nullable) EAUserDataModel *data ;
@property (nonatomic, assign) BOOL success;

@end
