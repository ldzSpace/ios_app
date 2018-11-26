//
//  VerifyCodeReq.m
//  
//
//  Created by cosmos on 2018/11/7.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import "VerifyCodeReq.h"
#import "URLMacros.h"
@interface VerifyCodeReq ()

@property (assign, nonatomic) VerifyCodeData *vcData;

@end

@implementation VerifyCodeReq

-(id)initWithVerifyCodeData:(VerifyCodeData *)data
{
    self = [super init];
    if (self) {
        _vcData = data;
    }
    return self;
}

- (NSString *)requestUrl
{
    return URL_verify;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    [_vcData show];
    return @{
             @"app": _vcData.app,
             @"appPkgName": _vcData.appPkgName,
             @"version": _vcData.version,
             @"systemVersion": _vcData.systemVersion,
             @"brand": _vcData.brand,
             @"platform": _vcData.platform,
             @"channelCode": _vcData.channelCode,
             @"deviceToken": _vcData.deviceToken,
             @"mobile": _vcData.mobile,
             @"ticket": _vcData.ticket,
             @"randstr": _vcData.randstr,
             };
}

@end
