//
//  ProductListArrays.h
//  dky
//
//  Created by cosmos on 2018/11/8.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@class CateListData;
@interface CateListData : NSObject <NSCopying,NSMutableCopying>
@property (assign, nonatomic) unsigned int weight;
@property (copy, nonatomic) NSString *updateAt;
@property (copy, nonatomic) NSString *bannerImgSrc;
@property (copy, nonatomic) NSString *descriptionx;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *_id;

-(void)show;
-(id)copyWithZone:(NSZone *)zone;

@end

@interface AmountListData : NSObject <NSCopying,NSMutableCopying>
@property (assign, nonatomic) unsigned int min;
@property (assign, nonatomic) unsigned int max;
@property (copy, nonatomic) NSString *txt;

-(void)show;
-(id)copyWithZone:(NSZone *)zone;

@end

@interface ProductListArrays : NSObject
@property (strong, nonatomic) NSArray *productList;
@property (strong, nonatomic) NSArray *cateList;
@property (strong, nonatomic) NSArray *amountList;

-(void)show;

@end

NS_ASSUME_NONNULL_END
