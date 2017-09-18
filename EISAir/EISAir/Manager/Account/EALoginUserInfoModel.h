//
//  EALoginUserInfoModel.h
//  EISAir
//
//  Created by chunhui on 2017/8/30.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol EALoginUserInfoDataSitesModel<NSObject>

@end


@protocol EALoginUserInfoDataSitesProductsModel<NSObject>

@end


@interface  EALoginUserInfoDataSitesProductsModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *code;
@property (nonatomic, copy , nullable) NSString *desc;
@property (nonatomic, copy , nullable) NSString *orgName;
@property (nonatomic, copy , nullable) NSString *createDate;
@property (nonatomic, copy , nullable) NSString *siteName;
@property (nonatomic, copy , nullable) NSString *orgId;
@property (nonatomic, copy , nullable) NSString *updateDate;
@property (nonatomic, copy , nullable) NSString *createUser;
@property (nonatomic, copy , nullable) NSString *siteId;
@property (nonatomic, copy , nullable) NSString *pid;
@property (nonatomic, copy , nullable) NSString *name;

@end


@interface  EALoginUserInfoDataSitesModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *desc;
@property (nonatomic, copy , nullable) NSString *city;
@property (nonatomic, copy , nullable) NSString *code;
@property (nonatomic, copy , nullable) NSString *name;
@property (nonatomic, copy , nullable) NSString *buildingYear;
@property (nonatomic, copy , nullable) NSString *orgName;
@property (nonatomic, copy , nullable) NSString *buildingType;
@property (nonatomic, copy , nullable) NSString *createDate;
@property (nonatomic, copy , nullable) NSString *area;
@property (nonatomic, copy , nullable) NSString *numberOfMember;
@property (nonatomic, copy , nullable) NSString *numberOfEngineer;
@property (nonatomic, copy , nullable) NSString *cost;
@property (nonatomic, copy , nullable) NSString *orgId;
@property (nonatomic, copy , nullable) NSString *floor;
@property (nonatomic, copy , nullable) NSString *createUser;
@property (nonatomic, copy , nullable) NSString *address;
@property (nonatomic, strong , nullable) NSArray<EALoginUserInfoDataSitesProductsModel> *products;
@property (nonatomic, copy , nullable) NSString *pm;
@property (nonatomic, copy , nullable) NSString *startDate;
@property (nonatomic, copy , nullable) NSString *sid;
@property (nonatomic, copy , nullable) NSString *updateDate;
@property (nonatomic, copy , nullable) NSString *status;

@end


@protocol EALoginUserInfoDataOrgsModel<NSObject>

@end


@protocol EALoginUserInfoDataOrgsProductsModel<NSObject>

@end


@interface  EALoginUserInfoDataOrgsProductsModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *code;
@property (nonatomic, copy , nullable) NSString *desc;
@property (nonatomic, copy , nullable) NSString *orgName;
@property (nonatomic, copy , nullable) NSString *createDate;
@property (nonatomic, copy , nullable) NSString *siteName;
@property (nonatomic, copy , nullable) NSString *orgId;
@property (nonatomic, copy , nullable) NSString *updateDate;
@property (nonatomic, copy , nullable) NSString *createUser;
@property (nonatomic, copy , nullable) NSString *siteId;
@property (nonatomic, copy , nullable) NSString *pid;
@property (nonatomic, copy , nullable) NSString *name;

@end


@interface  EALoginUserInfoDataOrgsModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *code;
@property (nonatomic, copy , nullable) NSString *desc;
@property (nonatomic, copy , nullable) NSString *createDate;
@property (nonatomic, copy , nullable) NSString *address;
@property (nonatomic, strong , nullable) NSArray<EALoginUserInfoDataOrgsProductsModel> *products;
@property (nonatomic, copy , nullable) NSString *createUser;
@property (nonatomic, copy , nullable) NSString *oid;
@property (nonatomic, copy , nullable) NSString *name;
@property (nonatomic, copy , nullable) NSString *status;
@property (nonatomic, copy , nullable) NSString *updateDate;

@end


@interface  EALoginUserInfoDataModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *loginName;
@property (nonatomic, copy , nullable) NSString *personId;
@property (nonatomic, copy , nullable) NSString *userId;
@property (nonatomic, strong , nullable) NSArray<EALoginUserInfoDataSitesModel> *sites;
@property (nonatomic, copy , nullable) NSString *siteId;
@property (nonatomic, copy , nullable) NSString *personName;
@property (nonatomic, assign) BOOL isAdmin;
@property (nonatomic, copy , nullable) NSString *orgId;
@property (nonatomic, copy , nullable) NSString *mobile;
@property (nonatomic, strong , nullable) NSArray<EALoginUserInfoDataOrgsModel> *orgs;
@property (nonatomic, strong , nullable) NSArray *productArray;
@property (nonatomic, copy , nullable) NSString *roleName;
@property (nonatomic, copy , nullable) NSString *email;


@end


@interface  EALoginUserInfoModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *msg;
@property (nonatomic, copy , nullable) NSString *errorCode;
@property (nonatomic, copy , nullable) NSString *detailMsg;
@property (nonatomic, strong , nullable) EALoginUserInfoDataModel *data ;
@property (nonatomic, assign) BOOL success;

@end
