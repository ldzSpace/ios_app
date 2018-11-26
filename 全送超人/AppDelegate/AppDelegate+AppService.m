//
//  AppDelegate+AppService.m
//  全送超人
//
//  Created by ldzspace on 2018/11/5.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "MBProgressHUD+XY.h"
#import "MainTabBarController.h"
#import "CommonMacros.h"
#import "URLMacros.h"
#import "UtilsMacros.h"
#import "ConfigLogic.h"
#import "UserManager.h"
#import "OpenUDID.h"
#import "LoginViewController.h"
#import "RootNavigationController.h"
#import <MBProgressHUD.h>
#import <YTKNetwork.h>

@implementation AppDelegate(AppService)

#pragma mark =================  初始化服务 =====================
-(void)initService
{
    // 注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:KNotificationLoginStateChange object:nil];
    
    // 网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStateChange:) name:KNotificationNetWorkStateChange object:nil];
}

#pragma mark =================  初始化window =====================
-(void)initWindow
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KWhiteColor;
    [self.window makeKeyAndVisible];
    [[UIButton appearance] setExclusiveTouch:YES];
    //[UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:[MBProgressHUD class]].color = KWhiteColor;
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance]setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    self.mainTabBar = [MainTabBarController new];
    self.window.rootViewController = self.mainTabBar;
}

#pragma mark =================  初始化网络配置 =====================
-(void)initNetWorkConfig
{
    YTKNetworkConfig * config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = URL_main;
}


#pragma mark ================= 应用配置 ===================
- (void)initUserConfig{
    ConfigLogic * logic = [ConfigLogic new];
    [logic loadData];
}


#pragma mark ————— 初始化用户系统 —————
-(void)initUserManager{
    DLog(@"设备IMEI ：%@",[OpenUDID value]);
    
    if([userManager loadUserInfo]){
        //如果有本地数据，先展示TabBar 随后异步自动登录
        self.mainTabBar = [MainTabBarController new];
        self.window.rootViewController = self.mainTabBar;
        
        //自动登录
//        [userManager autoLoginToServer:^(BOOL success, NSString *des) {
//            if (success) {
                [MBProgressHUD showSuccessMessage:@"自动登录成功"];
                KPostNotification(KNotificationAutoLoginSuccess, nil);
//            }else{
//                [MBProgressHUD showErrorMessage:NSStringFormat(@"自动登录失败：%@",des)];
//            }
//        }];
        
    }else{
        //没有登录过，展示登录页面
        KPostNotification(KNotificationLoginStateChange, @NO)
        [MBProgressHUD showErrorMessage:@"需要登录"];
    }
}



#pragma mark =================  登录状态处理 =====================
-(void)loginStateChange:(NSNotification*)notification
{
    BOOL loginSuccess = [notification.object boolValue];
    
    if (loginSuccess) {//登陆成功加载主窗口控制器
        
        //为避免自动登录成功刷新tabbar
        if (!self.mainTabBar || ![self.window.rootViewController isKindOfClass:[MainTabBarController class]]) {
            self.mainTabBar = [MainTabBarController new];
            
            CATransition *anima = [CATransition animation];
            anima.type = @"cube";//设置动画的类型
            anima.subtype = kCATransitionFromRight; //设置动画的方向
            anima.duration = 0.3f;
            
            self.window.rootViewController = self.mainTabBar;
            
            [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
            
        }
        
    }else {//登陆失败加载登陆页面控制器
        
//        self.mainTabBar = nil;
//        RootNavigationController *loginNavi =[[RootNavigationController alloc] initWithRootViewController:[LoginViewController new]];
//
//        CATransition *anima = [CATransition animation];
//        anima.type = @"fade";//设置动画的类型
//        anima.subtype = kCATransitionFromRight; //设置动画的方向
//        anima.duration = 0.3f;
//
//        self.window.rootViewController = loginNavi;
//        [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
        if (!self.mainTabBar || ![self.window.rootViewController isKindOfClass:[MainTabBarController class]]) {
            self.mainTabBar = [MainTabBarController new];
            
            CATransition *anima = [CATransition animation];
            anima.type = @"cube";//设置动画的类型
            anima.subtype = kCATransitionFromRight; //设置动画的方向
            anima.duration = 0.3f;
            
            self.window.rootViewController = self.mainTabBar;
            
            [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
            
        }
        
     
        
    }
    //展示FPS
    //[AppManager showFPS];

}

#pragma mark =================  网络状态处理 =====================
-(void)netWorkStateChange:(NSNotification*)notification
{
    BOOL isNetWork = [notification.object boolValue];
    
    if (isNetWork) {//有网络
        if ([userManager loadUserInfo] && !isLogin) {//有用户数据 并且 未登录成功 重新来一次自动登录
//            [userManager autoLoginToServer:^(BOOL success, NSString *des) {
//                if (success) {
//                    DLog(@"网络改变后，自动登录成功");
//                    [MBProgressHUD showSuccessMessage:@"网络改变后，自动登录成功"];
                    KPostNotification(KNotificationAutoLoginSuccess, nil);
//                }else{
//                    [MBProgressHUD showErrorMessage:NSStringFormat(@"自动登录失败：%@",des)];
//                }
//            }];
        }
        
    }else {//登陆失败加载登陆页面控制器
        [MBProgressHUD showTopTipMessage:@"网络状态不佳" isWindow:YES];
    }
}

// 实例
+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


-(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}



@end
