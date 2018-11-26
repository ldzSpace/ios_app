//
//  HomePageLogic.m
//  全送超人
//
//  Created by admin on 2018/11/7.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "HomePageLogic.h"
#import "PPNetworkHelper.h"
#import "GetHomePageListAPI.h"
#import "MJExtension.h"
#import "Status.h"
#import "BannerModel.h"
#import "CateModel.h"
#import "ProductModel.h"
#import "PopupModel.h"

@interface HomePageLogic()

@end

@implementation HomePageLogic

-(instancetype)init{
    self = [super init];
    if (self) {
        _bannerArray = @[].mutableCopy;
        _cateArray = @[].mutableCopy;
        _productArray = @[].mutableCopy;
        _popUpArray = @[].mutableCopy;
    }
    return self;
}

- (void)loadData
{
    GetHomePageListAPI * req = [GetHomePageListAPI new];
    NSLog(@"url=%@",req.requestUrl);
    [req startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSString * respStr = request.responseString;
        Status * status = [Status mj_objectWithKeyValues:respStr];
        int code  = status.code;
        NSLog(@"code = %d",code);
        if(code == 0){
            // 访问成功
            NSDictionary * bannerList = status.data[@"bannerList"];
            for (BannerModel * ban in bannerList) {
                BannerModel * bannerData = [BannerModel mj_objectWithKeyValues:ban];
                [_bannerArray addObject:bannerData];
            }
            NSDictionary * cateList = status.data[@"cateList"];
            for (CateModel * cate in cateList) {
                CateModel * cateData = [CateModel mj_objectWithKeyValues:cate];
                [_cateArray addObject:cateData];
            }
            
            NSDictionary * productList = status.data[@"productList"];
            for (ProductModel * product in productList) {
                ProductModel * productData = [ProductModel mj_objectWithKeyValues:product];
                [_productArray addObject:productData];
            }
            
            NSDictionary * popUpList = status.data[@"popup"];
            for (PopupModel * popup in popUpList) {
                PopupModel * popupData = [PopupModel mj_objectWithKeyValues:popup];
                [_popUpArray addObject:popupData];
            }
        } else {
            // 访问失败
            
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestDataCompleted)]) {
            [self.delegate requestDataCompleted];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
          NSLog(@"error=%@,%@",request.error,request.responseData);
    }];
    
}

@end
