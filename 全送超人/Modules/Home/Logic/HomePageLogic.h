//
//  HomePageLogic.h
//  全送超人
//
//  Created by admin on 2018/11/7.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomePageLogicDelegate<NSObject>

/**
 请求数据完成
 */
- (void)requestDataCompleted;

@end

@interface HomePageLogic : NSObject

@property (nonatomic,weak) id <HomePageLogicDelegate> delegate;
@property (nonatomic,strong) NSMutableArray * bannerArray;// banner数据
@property (nonatomic,strong) NSMutableArray * cateArray;  // cate数据
@property (nonatomic,strong) NSMutableArray * productArray; // 产品数据
@property (nonatomic,strong) NSMutableArray * popUpArray; // 弹框数据

- (void)loadData;

@end

NS_ASSUME_NONNULL_END
