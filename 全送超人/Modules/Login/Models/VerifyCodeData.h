//
//  VerifyCodeData.h
//  
//
//  Created by cosmos on 2018/11/14.
//  Copyright © 2018年 WHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerifyCodeData : NSObject

@property (nonatomic, strong) NSString *app;
@property (nonatomic, strong) NSString *appPkgName;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *systemVersion;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *platform;
@property (nonatomic, strong) NSString *channelCode;
@property (nonatomic, strong) NSString *deviceToken;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *ticket;
@property (nonatomic, strong) NSString *randstr;

-(id)initWithStuff;

-(void)show;
@end

NS_ASSUME_NONNULL_END
