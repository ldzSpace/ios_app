//
//  LoginReq.h
//  
//
//  Created by cosmos on 2018/11/14.
//  Copyright © 2018年 WHJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetwork.h>


NS_ASSUME_NONNULL_BEGIN

@interface LoginReq : YTKRequest
-(id)initWithPhone:(NSString *)phoneNum vCode:(NSString*)vCode;
@end

NS_ASSUME_NONNULL_END
