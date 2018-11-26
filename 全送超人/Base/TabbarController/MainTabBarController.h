//
//  MainTabBarController.h
//  全送超人
//
//  Created by admin on 2018/11/6.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 底部控制Tabbar
 */
@interface MainTabBarController : UITabBarController

/**
 设置红点

 @param index tabbar下标
 @param isShow 是否隐藏
 */
-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
