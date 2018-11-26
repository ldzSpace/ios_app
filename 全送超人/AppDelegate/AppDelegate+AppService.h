//
//  AppDelegate+AppService.h
//  全送超人
//
//  Created by ldzspace on 2018/11/5.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "AppDelegate.h"

#define ReplaceRootViewController(vc) [[AppDelegate shareAppDelegate] replaceRootViewController:vc]

@interface AppDelegate(AppService)

// 初始化服务
-(void)initService;

// 初始化window
-(void)initWindow;

// 初始化UMeng
-(void)initUMeng;

// 初始化用户系统
-(void)initUserManager;

// 初始化应用配置
- (void)initUserConfig;

// 监听网络状态
-(void)monitorNetWorkStatue;

// 初始化网络配置
-(void)initNetWorkConfig;

// 单例
+(AppDelegate *)shareAppDelegate;

// 当前顶层控制器
-(UIViewController*) getCurrentVC;

-(UIViewController*) getCurrentUIVC;

@end
