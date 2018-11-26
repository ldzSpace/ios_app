//
//  BrowerHistoryAPI.m
//  全送超人
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "BrowerHistoryAPI.h"
#import "URLMacros.h"
#import "UserManager.h"
#import "YTKNetworkConfig.h"
@interface BrowerHistoryAPI()
@property (nonatomic, copy) NSString * token;
@end

@implementation BrowerHistoryAPI

-(id)initWithToken:(NSString *)token
{
    self = [super init];
    if (self) {
        _token = token;
    }
    return self;
}

// 首页请求地址
- (NSString *)requestUrl {
    return URL_browerList;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}


- (NSDictionary *)requestHeaderFieldValueDictionary {
    NSString * authorization =[NSString stringWithFormat:@"%@ %@",@"Bearer",_token ];
    return @{@"Content-Type":@"application/json",
             @"Authorization": authorization};
}


- (id)requestArgument {
    return @{
             @"token": userManager.curUserInfo.token
             };
}

@end
