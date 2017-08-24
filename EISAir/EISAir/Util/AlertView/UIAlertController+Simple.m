//
//  UIAlertController+Simple.m
//
//  Created by DoubleHH
//

#import "UIAlertController+Simple.h"
#import "EABaseViewController.h"

@implementation UIAlertController (Simple)

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
           actionBlock:(void (^)(NSUInteger index))actionBlock
     cancelButtonTitle:(NSString *)cancelButtonTitle
     otherButtonTitles:(NSString *)titles,... {
    NSMutableArray *titlesArray = [[NSMutableArray alloc] initWithCapacity:0];
    va_list argList;
    if(titles){
        [titlesArray addObject:titles];
        va_start(argList, titles);
        NSString *arg;
        while ((arg = va_arg(argList, NSString *))) {
            [titlesArray addObject:arg];
        }
    }
    va_end(argList);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction;
    if(cancelButtonTitle.length > 0) {
        cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            !actionBlock ?: actionBlock(0);
        }];
    }
    [alertController addAction:cancelAction];
    [titlesArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            !actionBlock ?: actionBlock(idx + 1);
        }];
        [alertController addAction:action];
    }];
    [[EABaseViewController currentNavigationController] presentViewController:alertController animated:YES completion:nil];
}

@end



