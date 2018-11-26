//
//  NetWorkCache.m
//  全送超人
//
//  Created by admin on 2018/11/7.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "PPNetworkCache.h"
#import "YYCache.h"
#import "YYDiskCache.h"
@implementation PPNetworkCache
static NSString *const NetworkResponseCache = @"PPNetworkResponseCache";
static YYCache *_dataCache;


+ (void)initialize {
    _dataCache = [YYCache cacheWithName:NetworkResponseCache];
}


/**
 设置缓存

 @param httpData 缓存的http的数据
 @param URL 请求地址
 @param parameters 请求参数
 */
+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}


/**
 获取缓存

 @param URL 请求地址
 @param parameters 请求参数
 @return 返回缓存数据
 */
+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}


/**
 带回调的获取缓存 【既异步获取】

 @param URL 请求地址
 @param parameters 请求参数与
 @param block 回调
 */
+ (void)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters withBlock:(void(^)(id<NSCoding> object))block {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    [_dataCache objectForKey:cacheKey withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(object);
        });
    }];
}


/**
 获取缓存的大小
 @return <#return value description#>
 */
+ (NSInteger)getAllHttpCacheSize {
    return [_dataCache.diskCache totalCost];
}


/**
 删除所有的http缓存
 */
+ (void)removeAllHttpCache {
    [_dataCache.diskCache removeAllObjects];
}
/**
 将URL 和 参数拼接生成缓存key

 @param NSString <#NSString description#>
 @return <#return value description#>
 */
+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    if(!parameters){return URL;};
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    
    // 将URL与转换好的参数字符串拼接在一起,成为最终存储的KEY值
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",URL,paraString];
    
    return cacheKey;
}


@end

