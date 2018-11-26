//
//  LoginReq.m
//  
//
//  Created by cosmos on 2018/11/14.
//  Copyright © 2018年 WHJ. All rights reserved.
//

#import "LoginReq.h"
#import "URLMacros.h"

@interface LoginReq ()

@property (strong, nonatomic) NSString *phoneNum;
@property (strong, nonatomic) NSString *verifyCode;

@end

@implementation LoginReq

-(id)initWithPhone:(NSString *)phoneNum vCode:(NSString*)vCode
{
    self = [super init];
    if (self) {
        _phoneNum = phoneNum;
        _verifyCode = vCode;
    }
    return self;
}

- (NSString *)requestUrl
{
    return URL_login;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    NSLog(@"phone = %@\n", _phoneNum);
    NSLog(@"smsCode = %@\n", _verifyCode);
    return @{
             @"mobile": _phoneNum,
             @"smsCode": _verifyCode
             };
}

@end
