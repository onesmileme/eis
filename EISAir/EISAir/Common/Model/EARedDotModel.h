//
//  FASystemMsgModel.h
//  FunApp
//
//  Created by chunhui on 2016/8/10.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "JSONModel.h"

@interface  EARedDotDataModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *sysNum;
@property (nonatomic, copy , nullable) NSString *fansNum;
@property (nonatomic, copy , nullable) NSString *mineNum;
@property (nonatomic, copy , nullable) NSString *momentsNum;
@property (nonatomic, copy , nullable) NSString *tweetNum;
@property (nonatomic, copy , nullable) NSString *pmsg;

@end


@interface  EARedDotModel  : JSONModel

@property (nonatomic, copy , nullable) NSString *dErrno;
@property (nonatomic, strong , nullable) EARedDotDataModel *data ;
@property (nonatomic, copy , nullable) NSString *errmsg;

@end

