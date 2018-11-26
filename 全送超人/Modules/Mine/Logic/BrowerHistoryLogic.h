//
//  BrowerHistoryLogic.h
//  全送超人
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol BrowerHistoryLogicDelegate<NSObject>

/**
 请求数据完成
 */
- (void)requestDataCompleted;

@end

@interface BrowerHistoryLogic : NSObject
@property (nonatomic, strong) id<BrowerHistoryLogicDelegate>delegate;
@property (nonatomic, strong) NSMutableArray * productArray; // 产品数据
-(void)loadData;

@end

NS_ASSUME_NONNULL_END
