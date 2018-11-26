//
//  ProductModel.h
//  全送超人
//
//  Created by admin on 2018/11/8.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductModel : NSObject
@property(strong,nonatomic)NSArray * introduction;
@property(strong,nonatomic)NSArray * tags;
@property(assign,nonatomic)int  rateUnit;
@property(assign,nonatomic)int  minAmount;
@property(assign,nonatomic)int  wight;
@property(strong,nonatomic)NSArray * datum;
@property(strong,nonatomic)NSArray * conditions;
@property(assign,nonatomic)int applyPersonCount;
@property(assign,nonatomic)int browserCount;
@property(copy,nonatomic)NSString * updateAt;
@property(assign,nonatomic)BOOL  recommend;
@property(copy,nonatomic)NSString * url;
@property(assign,nonatomic)int maxLoanDays;
@property(assign,nonatomic)int minLoadDays;
@property(assign,nonatomic)int maxAmount;
@property(assign,nonatomic)int termMax;
@property(assign,nonatomic)int termMin;
@property(assign,nonatomic)float dayRate;
@property(assign,nonatomic)int passingRate;
@property(assign,nonatomic)float monthRate;
@property(copy,nonatomic)NSString * speed;
@property(copy,nonatomic)NSString * logo;
@property(copy,nonatomic)NSString * subtitle;
@property(copy,nonatomic)NSString * name;
@property(copy,nonatomic)NSString * _id;
@end

NS_ASSUME_NONNULL_END
