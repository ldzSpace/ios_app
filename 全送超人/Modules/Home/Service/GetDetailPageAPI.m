//
//  GetDetailPageAPI.m
//  全送超人
//
//  Created by admin on 2018/11/10.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "GetDetailPageAPI.h"
#import "URLMacros.h"

@implementation GetDetailPageAPI{
    NSString* productId; // 他不是属于self的变量，只是一个全局变量
}

- (id)initWithID:(NSString*)productID
{
    self = [self init];
    if(self){
        productId = productID;
    }
    return self;
}

// 首页请求地址
- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"%@%@",URL_detail,productId];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}


@end
