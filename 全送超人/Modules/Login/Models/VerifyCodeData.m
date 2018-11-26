//
//  VerifyCodeData.m
//  
//
//  Created by cosmos on 2018/11/14.
//  Copyright © 2018年 WHJ. All rights reserved.
//

#import "VerifyCodeData.h"
#import <UIKit/UIKit.h>
@implementation VerifyCodeData
-(id)initWithStuff
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    _app = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    _appPkgName = [[NSBundle mainBundle] bundleIdentifier];
    _version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    _systemVersion = [[UIDevice currentDevice] systemVersion];
    _brand = [[UIDevice currentDevice] model];
    _platform = @"iOS";
    _channelCode = @"AppStore";
    return self;
}

-(void)show
{
    NSLog(@"-----------------------------------------");
    NSLog(@"VerifyCodeData app = %@\n", _app);
    NSLog(@"VerifyCodeData appPkgName = %@\n", _appPkgName);
    NSLog(@"VerifyCodeData version = %@\n", _version);
    NSLog(@"VerifyCodeData systemVersion = %@\n", _systemVersion);
    NSLog(@"VerifyCodeData brand = %@\n", _brand);
    NSLog(@"VerifyCodeData platform = %@\n", _platform);
    NSLog(@"VerifyCodeData channelCode = %@\n", _channelCode);
    NSLog(@"VerifyCodeData deviceToken = %@\n", _deviceToken);
    NSLog(@"VerifyCodeData mobile = %@\n", _mobile);
    NSLog(@"VerifyCodeData ticket = %@\n", _ticket);
    NSLog(@"VerifyCodeData randstr = %@\n", _randstr);
    NSLog(@"-----------------------------------------");
    
}

@end
