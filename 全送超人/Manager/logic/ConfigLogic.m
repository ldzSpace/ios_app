//
//  ConfigLogic.m
//  全送超人
//
//  Created by admin on 2018/11/15.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "ConfigLogic.h"
#import "GetAppConfig.h"
#import "MJExtension.h"
#import "Status.h"
#import "ConfigModle.h"
#import "UtilsMacros.h"
@implementation ConfigLogic

-(instancetype)init{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)loadData
{
    GetAppConfig * req = [GetAppConfig new];
    NSLog(@"url=%@",req.requestUrl);
    [req startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSString * respStr = request.responseString;
        Status * status = [Status mj_objectWithKeyValues:respStr];
        int code  = status.code;
        NSLog(@"code = %d",code);
        NSLog(@"data = %@",status.data);
        if(code == 0){
            // 访问成功
            [configInstance setHelpUrl:status.data[@"helpUsUrl"]];
            [configInstance setWeixin:status.data[@"weixin"]];
            NSLog(@"解析后：%@,%@",configInstance.helpUrl,configInstance.weixin);
        } else {
            // 访问失败
            
        }
      
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"error=%@,%@",request.error,request.responseData);
    }];
    
}

@end
