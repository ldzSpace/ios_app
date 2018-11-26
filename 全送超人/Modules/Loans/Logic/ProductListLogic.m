//
//  ProductListLogic.m
//  dky
//
//  Created by cosmos on 2018/11/8.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import "ProductListLogic.h"
#import "ProductListReq.h"
#import "Status.h"
#import "MJExtension.h"
#import "ProductListArrays.h"
#import "ProductModel.h"
//#import "MJExtensionConfig.h"

@interface ProductListLogic()

@end

@implementation ProductListLogic

-(instancetype)init{
    self = [super init];
    if (self) {
        _productList = @[].mutableCopy;
        _cateList = @[].mutableCopy;
        _amountList = @[].mutableCopy;
        //[MJExtensionConfig load];
    }
    return self;
}

- (void)loadData:(NSString*)cateId Min:(int)min Max:(int)max
{
    ProductListReq *api = [[ProductListReq alloc] initWithCateId:cateId Min:min Max:max];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request)
    {
        NSString * respStr = request.responseString;
        Status * body = [Status mj_objectWithKeyValues:respStr];
        int code  = body.code;
        if(code == 0)
        {
            [[self productList] removeAllObjects];
            [[self cateList] removeAllObjects];
            [[self amountList] removeAllObjects];
            NSArray *productArray = body.data[@"productList"];
            for (NSDictionary * productDict in productArray) {
                ProductModel * model = [ProductModel mj_objectWithKeyValues:productDict];
                [self.productList addObject:model];
            }
            
   
            NSArray *cateArray = body.data[@"cateList"];
            for (NSDictionary * cateDict in cateArray) {
                CateListData *cate = [CateListData mj_objectWithKeyValues:cateDict];
                [cate show];
                [self.cateList addObject:cate];
            }
            
            
            NSArray *amountArray = body.data[@"amountList"];
            for (NSDictionary * amountDict in amountArray) {
                AmountListData *amountData = [AmountListData mj_objectWithKeyValues:amountDict];
                [self.amountList addObject:amountData];
            }
        
        } else {
            // 访问失败
            
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestDataCompleted)])
        {
            [self.delegate requestDataCompleted];
        }
    }
    failure:^(YTKBaseRequest *request)
    {
        NSLog(@"failed = %@\n", request.error);
    }];
}

@end
