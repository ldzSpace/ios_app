//
//  BaseRquestAPI.h
//  全送超人
//
//  Created by admin on 2018/11/7.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetwork.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseRequestAPI : YTKBaseRequest

@property(nonatomic,assign)BOOL isOpenAES;//是否开启加密 默认关闭

//自定义属性值
@property(nonatomic,assign)BOOL isSuccess;//是否成功
@property (nonatomic,copy) NSString * message;//服务器返回的信息
@property (nonatomic,copy) NSDictionary * result;//服务器返回的数据 已解密


@end

NS_ASSUME_NONNULL_END
