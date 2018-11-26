//
//  FeedbackLogic.m
//  全送超人
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "FeedbackLogic.h"
#import "PostFeedbackAPI.h"
#import "MJExtension.h"
#import "Status.h"
#import "UserManager.h"

@implementation FeedbackLogic

- (void)loadData:(NSString*)content CompletionBlock:(HttpRequestCallBack)completion
{
    PostFeedbackAPI* req = [[PostFeedbackAPI alloc] initWithContent:content Token:userManager.curUserInfo.token];
    
     NSLog(@"url=%@",req.requestUrl);
    
     [req startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSString * respStr = request.responseString;
        Status * status = [Status mj_objectWithKeyValues:respStr];
        int code  = status.code;
        NSLog(@"code = %d",code);
        NSLog(@"data=%@",respStr);
        if(code == 0){
            // 访问成功
            completion ? completion(YES,@"提交成功"):nil;
        } else {
            // 访问失败
            NSArray *detail = status.data[@"detail"];
            if(detail && detail[0]){
                completion ? completion(NO,detail[0][@"message"]):nil;
                return ;
            }
            completion ? completion(NO,@"提交失败"):nil;
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        completion?completion(NO, request.error):nil;
        NSLog(@"error=%@,%@",request.error,request.responseData);
    }];
    
}
@end
