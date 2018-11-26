//
//  BrowerHistoryLogic.m
//  全送超人
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "BrowerHistoryLogic.h"
#import "BrowerHistoryAPI.h"
#import "MJExtension.h"
#import "Status.h"
#import "UserManager.h"
#import "GetHomePageListAPI.h"
#import "ProductModel.h"

@implementation BrowerHistoryLogic

-(instancetype)init{
    self = [super init];
    if (self) {
        _productArray = @[].mutableCopy;
    }
    return self;
}


-(void)loadData{
    //BrowerHistoryAPI * browerApi = [[BrowerHistoryAPI alloc] initWithToken:userManager.curUserInfo.token];
    GetHomePageListAPI * browerApi = [GetHomePageListAPI new];
   
    NSLog(@"url =%@",browerApi.requestUrl);
    [browerApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSString * respStr = request.responseString;
        Status * status = [Status mj_objectWithKeyValues:respStr];
        int code  = status.code;
        NSLog(@"BrowerHistoryAPI code = %d",code);
        NSLog(@"data=%@",respStr);
        if(code == 0){
            // 访问成功
            NSDictionary * productList = status.data[@"productList"];
            for (ProductModel * product in productList) {
                ProductModel * productData = [ProductModel mj_objectWithKeyValues:product];
                [_productArray addObject:productData];
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestDataCompleted)]) {
                [self.delegate requestDataCompleted];
            }
        } else {
            // 访问失败
        
        }
    
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
        
}

@end
