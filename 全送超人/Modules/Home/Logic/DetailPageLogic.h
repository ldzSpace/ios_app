//
//  DetailPageLogic.h
//  全送超人
//
//  Created by admin on 2018/11/10.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol DetailPageLogicDelegate<NSObject>

/**
 请求数据完成
 */
- (void)requestDataCompleted;

@end

@interface DetailPageLogic : NSObject
@property(nonatomic, strong) id<DetailPageLogicDelegate> delegate;
@property(nonatomic, strong) ProductModel * product;

- (void)loadData:(NSString*)productID;

@end

NS_ASSUME_NONNULL_END
