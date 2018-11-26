//
//  ProductListReq.h
//  
//
//  Created by cosmos on 2018/11/7.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import "VerifyCodeData.h"

NS_ASSUME_NONNULL_BEGIN

@interface VerifyCodeReq : YTKRequest

-(id)initWithVerifyCodeData:(VerifyCodeData *)data;

@end

NS_ASSUME_NONNULL_END
