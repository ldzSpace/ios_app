//
//  TokenModel.h
//  dky
//
//  Created by cosmos on 2018/11/8.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface TokenDataModel : NSObject
@property (strong, nonatomic) NSString *token;

-(void)show;

@end

@interface TokenModel : NSObject
@property (assign, nonatomic) unsigned int code;
@property (strong, nonatomic) TokenDataModel *data;
@property (strong, nonatomic) NSString *msg;

-(void)show;

@end

NS_ASSUME_NONNULL_END
