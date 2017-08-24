//
//  UIAlertController+Simple.h
//
//  Created by DoubleHH
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Simple)

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
           actionBlock:(void (^)(NSUInteger index))actionBlock
     cancelButtonTitle:(NSString *)cancelButtonTitle
     otherButtonTitles:(NSString *)titles,... NS_REQUIRES_NIL_TERMINATION;

@end
