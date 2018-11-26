//
//  DetailPageLogic.m
//  全送超人
//
//  Created by admin on 2018/11/10.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "DetailPageLogic.h"
#import "GetDetailPageAPI.h"
#import "Status.h"
#import "MJExtension.h"


@implementation DetailPageLogic

- (void)loadData:(NSString*)productID
{
    GetDetailPageAPI * req = [[GetDetailPageAPI alloc] initWithID:productID];
    NSLog(@"url=%@",req.requestUrl);
    [req startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSString * respStr = request.responseString;
        Status * status = [Status mj_objectWithKeyValues:respStr];
        int code  = status.code;
        NSLog(@"code = %d",code);
        NSLog(@"data=%@",respStr);
        if(code == 0){
            // 访问成功
           _product = [ProductModel mj_objectWithKeyValues:status.data];
            [self.delegate  requestDataCompleted];
        } else {
            // 访问失败
            
        }
//        if (self.delegate && [self.delegate respondsToSelector:@selector(requestDataCompleted)]) {
//            [self.delegate requestDataCompleted];
//        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"error=%@,%@",request.error,request.responseData);
    }];
    
}
@end
