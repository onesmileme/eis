//
//  UIViewController+InputLimit.m
//  FunApp
//
//  Created by liuzhao on 2016/12/28.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#import "UIViewController+InputLimit.h"

@implementation UIViewController (InputLimit)

- (NSString *)handleInputLimtWithContent:(NSString *)content limitCount:(NSUInteger)limit toast:(NSString *)toast
{
    NSString *retContent;
    NSString *trimContent = [content substringFromIndex:limit-5];
    NSData *data = [trimContent dataUsingEncoding:NSUTF8StringEncoding];
    uint64_t result = lastToWorkEmojiValue(data);
    
    bool show = true;
    if (result >= 0x1f601 ) {
        //是emoji表情
        if ( content.length > limit +1 ) {
            retContent = [content substringToIndex:content.length - 2];//emoji占用两个字符
        }else{
            show = false;
        }
    }else{
        retContent = [content substringToIndex:limit ];
    }
    
    if (show) {
        [FATools showToast:toast];
    }
    return retContent;
}

uint64_t lastToWorkEmojiValue(NSData *data)
{
    
    NSString *content = [NSString stringWithFormat:@"%@",data];
    content = [content stringByReplacingOccurrencesOfString:@"<" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@">" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSInteger length = [content length];
    uint8_t * bytes = (uint8_t *)[content UTF8String];
    
    uint64_t result = 0;
    
    for (NSInteger i = length - 8; i < length; i+=2) {
        uint8_t v = ( hextoint(bytes[i]) << 4 )| (hextoint(bytes[i+1]) & 0xff );
        
        if (i == length - 8 && !((v&0x80) == 0x80)) {
            //非emoji
            return 0;
        }
        
        if (!(v & 0x80)) {
            //高位为0  impossible
            result = result << 7 | (v&0x7f);
        }else if(!(v & 0x40)){
            //第二位为0
            result = result << 6 | (v&0x3f);
        }else if (!(v & 0x20)){
            //第三位为0
            result = result << 5 | (v&0x1f);
        }else if (!(v & 0x10)){
            //第四位为0
            result = result << 4 | (v&0xf);
        }else if (!(v & 0x8)){
            //第五位为0
            result = result << 3 | (v&0x7);
        }else if (!(v & 0x4)){
            //第六位为0 impossible
            result = result << 2 | (v&0x3);
        }
        
    }
    
    return result;
}

uint8_t hextoint(char v)
{
    if (v >= '0' && v <= '9') {
        return  v - '0';
    }else if (v >= 'a' && v <= 'f'){
        return  v - 'a' + 10;
    }else if (v >= 'A' && v <= 'F'){
        return v - 'A' + 10;
    }
    
    return 0;
    
}
@end
