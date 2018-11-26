//
//  URLMacros.h
//  全送超人
//
//  Created by ldzspace on 2018/11/5.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#ifndef URLMacros_h
#define URLMacros_h


//内部版本号 每次发版递增
#define KVersionCode 1

/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever    1
#define TestSever       0
#define ProductSever    0

#if DevelopSever

/**开发服务器*/
#define URL_main @"http://lmtest.honzhi.com"

#elif TestSever

/**测试服务器*/
#define URL_main @"http://lmtest.honzhi.com"

#elif ProductSever

/**生产服务器*/
#define URL_main @"http://lmtest.honzhi.com"

#endif



#pragma mark - ——————— 详细接口地址 ————————
// 首页地址
#define URL_home @"/c/api/ios/home/index"

// 应用配置
#define URL_config @"/c/api/ios/config"

// 产品详情
#define URL_detail @"/c/api/ios/product/detail?id="

// 找贷款
#define URL_loads @"/c/api/ios/product/list"

// 登录
#define URL_login @"/c/api/ios/loanUser/login"

// 验证码
#define URL_verify @"/c/api/ios/verify/check"

// 提交反馈信息
#define URL_feedback @"c/api/ios/feedback/create"

// 获取浏览记录
#define URL_browerList @"c/api/ios/loanBrowser/list"

#pragma mark - ——————— 用户相关 ————————
//自动登录
#define URL_user_auto_login @"/api/autoLogin"
//登录
#define URL_user_login @"/api/login"
//用户详情
#define URL_user_info_detail @"/api/user/info/detail"
//修改头像
#define URL_user_info_change_photo @"/api/user/info/changephoto"
//注释
#define URL_user_info_change @"/api/user/info/change"


#endif /* URLMacros_h */
