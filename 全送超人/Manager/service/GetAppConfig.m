//
//  GetAppConfig.m
//  全送超人
//
//  Created by admin on 2018/11/15.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "GetAppConfig.h"
#import "URLMacros.h"

@implementation GetAppConfig

// 首页请求地址
- (NSString *)requestUrl {
    return URL_config;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}


@end
