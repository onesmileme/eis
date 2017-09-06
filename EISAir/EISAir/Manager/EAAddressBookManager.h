//
//  EAAddressBookManager.h
//  EISAir
//
//  Created by chunhui on 2017/8/29.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EAAddressBookManager : NSObject

DEF_SINGLETON;

-(void)chooseContact:(UIViewController *)controller completion:(void(^)(NSString *name , NSString *phone))completion;

@end
