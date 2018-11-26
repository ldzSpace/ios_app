//
//  ProductListLogic.h
//  dky
//
//  Created by cosmos on 2018/11/8.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ProductListLogicDelegate<NSObject>

/**
 请求数据完成
 */
- (void)requestDataCompleted;

@end

@interface ProductListLogic : NSObject
@property (nonatomic,weak) id <ProductListLogicDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *productList;
@property (strong, nonatomic) NSMutableArray *cateList;
@property (strong, nonatomic) NSMutableArray *amountList;

- (void)loadData:(NSString*)cateId Min:(int)min Max:(int)max;
@end

NS_ASSUME_NONNULL_END
