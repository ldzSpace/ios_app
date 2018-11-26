//
//  HeaderModel.m
//  全送超人
//
//  Created by admin on 2018/11/7.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "HeaderModel.h"
#import "UtilsMacros.h"
#import <UIApplication+YYAdd.h>

@implementation HeaderModel

-(instancetype)init{
    self = [super init];
    if (self) {
        //self.userid = userManager.curUserInfo.userid;
        //self.imei = [OpenUDID value].length>32 ? [[OpenUDID value] substringToIndex:32] :[OpenUDID value];
        self.os_type = 2;
        self.version = kApplication.appVersion;
        self.channel = @"App Store";
        self.clientId = self.imei;//[OpenUDID value].length>32 ? [[OpenUDID value] substringToIndex:32] :[OpenUDID value];
        //self.versioncode = KVersionCode;
        //self.mobile_model = [UIDevice currentDevice].machineModelName;
        //self.mobile_brand = [UIDevice currentDevice].machineModel;
    }
    return self;
}
@end
