//
//  WMContactUtil.m
//  WaiMai
//
//  Created by DoubleHH on 2017/6/20.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "WMContactUtil.h"
#import <AddressBook/AddressBook.h>
#import "UIAlertController+Simple.h"

// 分页返回
static const NSInteger kContactPageCount = 20;
// 手机号位数
static const NSInteger kContactPhoneLength = 11;

static NSString *const kPrivacyContact = @"App-Prefs:root=Privacy&path=CONTACTS";
static NSString *const kAlertPermissionAlertTitle = @"“EISAir”想访问您的通讯录";
static NSString *const kAlertPermissionAlertMessage = @"帮助您使用相应功能，不会保存您的通讯录内容";

@implementation WMContactUtil

+ (void)contactListWithPage:(NSInteger)page completionBlock:(void (^)(NSDictionary *result))completionBlock {
    if (!completionBlock) {
        return;
    }
    void (^finishedBlock)(void) = ^ {
        CFErrorRef *error1 = NULL;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error1);
        completionBlock([self copyAddressBook:addressBook page:page pageCount:kContactPageCount]);
    };
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            if (!granted) {
                completionBlock(nil);
                return;
            }
            if ([[NSThread currentThread] isMainThread]) {
                finishedBlock();
            } else {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    finishedBlock();
                });
            }
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        finishedBlock();
    }
    else {
        [self showPermissionAlert];
        completionBlock(nil);
    }
}

+ (void)showPermissionAlert {
    [UIAlertController alertWithTitle:kAlertPermissionAlertTitle message:kAlertPermissionAlertMessage actionBlock:^(NSUInteger index) {
        if (index == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kPrivacyContact]];
        }
    } cancelButtonTitle:@"不允许" otherButtonTitles:@"好", nil];
}

+ (NSDictionary *)copyAddressBook:(ABAddressBookRef)addressBook page:(NSInteger)page pageCount:(NSInteger)pageCount {
    NSMutableArray *contactList = [NSMutableArray array];
    CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    NSInteger startIndex = page * pageCount;
    NSInteger endIndex = MIN(startIndex + pageCount, numberOfPeople);
    NSCharacterSet *intervalSet = [NSCharacterSet characterSetWithCharactersInString:@"-()."];
    for (NSInteger i = startIndex; i < endIndex; i++) {
        ABRecordRef person = CFArrayGetValueAtIndex(people, i);
        
        NSString *firstName = (NSString *)CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty)) ?: @"";
        NSString *lastName = (NSString *)CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty)) ?: @"";
        NSString *name = [lastName stringByAppendingString:firstName];
        // 读取电话多值
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        NSMutableArray *phoneArray = [NSMutableArray array];
        for (int k = 0; k < ABMultiValueGetCount(phone); k++) {
            //获取該Label下的电话值
            NSString *tempPhone = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phone, k));
            NSString *phoneNumber = [[tempPhone componentsSeparatedByCharactersInSet:intervalSet] componentsJoinedByString:@""];
            phoneNumber = [self phoneFromString:phoneNumber];
            if (phoneNumber.length) {
                [phoneArray addObject:phoneNumber];
            }
        }
        NSDictionary *dict = @{
                               @"name": name ?: @"",
                               @"phone": phoneArray,
                               };
        [contactList addObject:dict];
    }
    return @{
             @"page": @(page),
             @"contacts": contactList,
             };
}

+ (NSString *)phoneFromString:(NSString *)string {
    if (!string.length) {
        return nil;
    }
    if ([[string substringToIndex:1] isEqualToString:@"0"]) {
        return nil;
    }
    if (string.length > kContactPhoneLength) {
        string = [string substringFromIndex:(string.length - kContactPhoneLength)];
    }
    if (![self isMobileAvailable:string]) {
        return nil;
    }
    return string;
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL)isMobileAvailable:(NSString *)mobile {
    NSString *phoneRegex = @"^1[0-9]{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

@end
