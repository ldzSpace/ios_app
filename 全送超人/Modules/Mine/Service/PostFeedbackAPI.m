//
//  PostFeedbackAPI.m
//  全送超人
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "PostFeedbackAPI.h"
#import "URLMacros.h"

@interface PostFeedbackAPI()
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * token;
@end

@implementation PostFeedbackAPI

-(id)initWithContent:(NSString *)content  Token:(NSString*)token
{
    self = [super init];
    if (self) {
        _content = content;
        _token = token;
    }
    return self;
}

// 首页请求地址
- (NSString *)requestUrl {
    return URL_feedback;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    NSString * authorization =[NSString stringWithFormat:@"%@ %@",@"Bearer",_token];
    return @{@"Content-Type":@"application/json",
             @"Authorization": authorization};
}


- (id)requestArgument {
    NSLog(@"_content = %@\n", _content);
  
    return @{
             @"content": _content
            };
}

@end
