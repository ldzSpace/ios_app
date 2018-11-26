//
//  ProductListArrays.m
//  dky
//
//  Created by cosmos on 2018/11/8.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import "ProductListArrays.h"

@implementation CateListData

-(void)show
{
    NSLog(@"----------------------------------------\n");
    NSLog(@"    CateListData weight = %d\n", [self weight]);
    NSLog(@"    CateListData updateAt = %@\n", [self updateAt]);
    NSLog(@"    CateListData bannerImgSrc = %@\n", [self bannerImgSrc]);
    NSLog(@"    CateListData description = %@\n", [self descriptionx]);
    NSLog(@"    CateListData name = %@\n", [self name]);
    NSLog(@"    CateListData _id = %@\n", [self _id]);
    NSLog(@"----------------------------------------\n");
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"descriptionx":@"description"
             };
}

-(id)copyWithZone:(NSZone *)zone;
{
    CateListData *newIns = [[CateListData alloc] init];
    newIns.weight = self.weight;
    newIns.updateAt = self.updateAt;
    newIns.bannerImgSrc = self.bannerImgSrc;
    newIns.descriptionx = self.descriptionx;
    newIns.name = self.name;
    newIns._id = self._id;
    return newIns;
}

@end

@implementation AmountListData

-(void)show
{
    NSLog(@"----------------------------------------\n");
    NSLog(@"    AmountListData min = %d\n", [self min]);
    NSLog(@"    AmountListData max = %d\n", [self max]);
    NSLog(@"    AmountListData txt = %@\n", [self txt]);
    NSLog(@"----------------------------------------\n");
}

-(id)copyWithZone:(NSZone *)zone;
{
    AmountListData *newIns = [[AmountListData alloc] init];
    newIns.min = self.min;
    newIns.max = self.max;
    newIns.txt = self.txt;
    return newIns;
}

@end

@implementation ProductListArrays

-(void)show
{
    NSLog(@"----------------------------------------");
//    for(ProductListData *obj in [self productList])
//    {
//        [obj show];
//    }
    for(CateListData *obj in [self cateList])
    {
        [obj show];
    }
    for(AmountListData *obj in [self amountList])
    {
        [obj show];
    }
    NSLog(@"----------------------------------------");
}

@end
