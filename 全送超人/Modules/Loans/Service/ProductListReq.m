//
//  ProductListReq.m
//  dky
//
//  Created by cosmos on 2018/11/7.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import "ProductListReq.h"
#import "URLMacros.h"

@interface ProductListReq ()

@property (assign, nonatomic) NSString *cateId;
@property (assign, nonatomic) int min;
@property (assign, nonatomic) int max;

@end

@implementation ProductListReq

-(id)initWithCateId:(NSString*)cateId Min:(int)min Max:(int)max
{
    self = [super init];
    if (self) {
        _cateId = cateId;
        _min = min;
        _max = max;
    }
    return self;
}

- (NSString *)requestUrl
{
    return URL_loads;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"cateId": _cateId,
             @"min": @(_min),
             @"max": @(_max)
             };
}

@end
