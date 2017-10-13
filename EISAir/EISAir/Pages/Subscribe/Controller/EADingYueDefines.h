//
//  EADingYueDefines.h
//  EISAir
//
//  Created by DoubleHH on 2017/9/27.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#ifndef EADingYueDefines_h
#define EADingYueDefines_h

typedef enum : int {
    EAKongJianVCTypeKongJian,
    EAKongJianVCTypeSheBei,
} EAKongJianVCType;

typedef NS_ENUM(NSUInteger, EASheBeiState) {
    EASheBeiStateOpen,
    EASheBeiStateClose,
    EASheBeiStateBug,
};

#endif /* EADingYueDefines_h */
