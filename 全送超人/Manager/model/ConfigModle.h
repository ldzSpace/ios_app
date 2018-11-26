//
//  ConfigModle.h
//  全送超人
//
//  Created by admin on 2018/11/16.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UtilsMacros.h"
NS_ASSUME_NONNULL_BEGIN

#define configInstance  [ConfigModle sharedConfigModle]

@interface ConfigModle : NSObject
//单例
SINGLETON_FOR_HEADER(ConfigModle)

@property (nonatomic, strong) NSString * helpUrl;
@property (nonatomic, strong) NSString * weixin;

@end



NS_ASSUME_NONNULL_END
