//
//  GetHomePageListAPI.m
//  全送超人
//
//  Created by admin on 2018/11/7.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "GetHomePageListAPI.h"
#import "URLMacros.h"
#import "YTKRequest.h"
@implementation GetHomePageListAPI

// 首页请求地址
- (NSString *)requestUrl {
    return URL_home;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
