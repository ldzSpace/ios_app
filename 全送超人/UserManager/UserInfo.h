//
//  UserInfo.h
//  全送超人
//
//  Created by admin on 2018/11/15.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,UserGender){
    UserGenderUnKnow = 0,
    UserGenderMale, //男
    UserGenderFemale //女
};

@interface UserInfo : NSObject

@property (nonatomic,assign)long long userid;   //用户ID
@property (nonatomic,copy) NSString * idcard;   //展示用的用户ID
@property (nonatomic,copy) NSString * photo;    //头像
@property (nonatomic,copy) NSString * nickname; //昵称
@property (nonatomic, assign) UserGender sex;   //性别
@property (nonatomic, copy) NSString * telephone; // 手机
@property (nonatomic,assign) NSInteger  degreeId;//用户等级
@property (nonatomic,copy) NSString * signature; //个性签名
@property (nonatomic,copy) NSString * token;    //用户登录后分配的登录Token


@end

NS_ASSUME_NONNULL_END
