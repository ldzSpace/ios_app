//
//  UserManager.m
//  全送超人
//
//  Created by admin on 2018/11/15.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "UserManager.h"
#import "UtilsMacros.h"
#import "CommonMacros.h"
#import "YYCache.h"
#import "MBProgressHUD+XY.h"
#import "PPNetWorkHelper.h"
#import "URLMacros.h"
#import "NSObject+YYModel.h"
#import "Status.h"
#import "CommonMacros.h"

//#import <UMSocialCore/UMSocialCore.h>

@implementation UserManager

SINGLETON_FOR_CLASS(UserManager);

-(instancetype)init{
    self = [super init];
    if (self) {
        //被踢下线
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onKick)
                                                     name:KNotificationOnKick
                                                   object:nil];
    }
    return self;
}

#pragma mark ————— 三方登录 —————
-(void)login:(UserLoginType )loginType completion:(loginBlock)completion{
    [self login:loginType params:nil completion:completion];
}

#pragma mark ————— 带参数登录 —————
-(void)login:(UserLoginType )loginType params:(NSDictionary *)params completion:(loginBlock)completion{
    //登录到服务器
    [self loginToServer:params completion:completion];
}

#pragma mark ————— 手动登录到服务器 —————
-(void)loginToServer:(NSDictionary *)params completion:(loginBlock)completion{
    [MBProgressHUD showActivityMessageInView:@"登录中..."];
    [PPNetworkHelper openLog];
    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_login) parameters:params success:^(id responseObject) {
        NSLog(@"登录请求返回成功");
        [MBProgressHUD hideHUD];
        [self LoginSuccess:responseObject Params:params Completion:completion];
    } failure:^(NSError *error) {
        NSLog(@"登录请求出错");
        [MBProgressHUD hideHUD];
        if (completion) {
            completion(NO,error.localizedDescription);
        }
    }];
}

#pragma mark ————— 自动登录到服务器 —————
-(void)autoLoginToServer:(loginBlock)completion{

}

#pragma mark ————— 登录成功处理 —————
-(void)LoginSuccess:(id)responseObject Params:(NSDictionary*) params Completion:(loginBlock)completion{
    if (ValidDict(responseObject)) {
        NSLog(@"response= %@",responseObject);
            int code = (int) responseObject[@"code"];
            NSLog(@"code = %d",code);
            //存储数据
            if (ValidDict(responseObject[@"data"])) {
                NSDictionary *data =responseObject[@"data"];
                NSLog(@"登录data%@",data);
                if (ValidStr(data[@"token"])) {
                    UserInfo *info = [[UserInfo alloc]init];
                    self.curUserInfo = info;
                    self.curUserInfo.token = data[@"token"];
                    self.curUserInfo.telephone = params[@"mobile"];
                    NSLog(@"infotoken%@" ,self.curUserInfo.token);
                    [self saveUserInfo];
                    if(completion){
                        completion(YES,@"登录成功");
                    }
                }else{
                    if (completion) {
                        completion(NO,@"登录返回数据异常");
                    }
                    KPostNotification(KNotificationLoginStateChange, @NO);
                }
                
            } else {
                if (completion) {
                    completion(NO,@"登录失败，code 错误");
                }
                KPostNotification(KNotificationLoginStateChange, @NO);
            }
    }else{
         NSLog(@"登录code fail2");
        if (completion) {
            completion(NO,@"登录返回数据异常");
        }
        KPostNotification(KNotificationLoginStateChange, @NO);
    }
    
}

#pragma mark ————— 储存用户信息 —————
-(void)saveUserInfo{
    if (self.curUserInfo) {
        YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
        NSDictionary *dic = [self.curUserInfo modelToJSONObject];
        [cache setObject:dic forKey:KUserModelCache];
    }
}

#pragma mark ————— 加载缓存的用户信息 —————
-(BOOL)loadUserInfo{
    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
    NSDictionary * userDic = (NSDictionary *)[cache objectForKey:KUserModelCache];
    if (userDic) {
        NSLog(@"成功cache%@",userDic);
        // 获取到用户数据模型
        self.curUserInfo = [UserInfo modelWithJSON:userDic];
        NSLog(@"---cache %@,%@",self.curUserInfo.token,self.curUserInfo.telephone);
        return YES;
    }
    NSLog(@"失败获取cache");
    return NO;
}

#pragma mark ————— 被踢下线 —————
-(void)onKick{
    [self logout:nil];
}


#pragma mark ————— 退出登录 —————
- (void)logout:(void (^)(BOOL, NSString *))completion{
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//    
//    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
//    
    //[[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLogout object:nil];//被踢下线通知用户退出直播间
    
    self.curUserInfo = nil;
    self.isLogined = NO;
    
    //移除缓存
    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
    [cache removeObjectForKey:KUserModelCache];
    [cache removeAllObjectsWithBlock:^{
        if (completion) {
            completion(YES,nil);
        }
    }];
    
    KPostNotification(KNotificationLoginStateChange, @NO);
}
@end
