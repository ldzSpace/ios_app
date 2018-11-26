//
//  NSString+URL.m
//  全送超人
//
//  Created by admin on 2018/11/8.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

/**
 *  URLEncode
    因为url中出现了中文，url是不允许特殊字符出现的，所以特殊字符都需要经过urlencode
    为了项目需要url需要encode的部分我不匹配 ：和 / ，需要的话自己添加上
 */
- (NSString *)URLEncodedString
{
    NSString *unencodedString = self;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();@&=+$,?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString
{
    NSString *encodedString = self;
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

@end

