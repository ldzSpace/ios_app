//
//  TokenModel.m
//  dky
//
//  Created by cosmos on 2018/11/8.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import "TokenModel.h"
@interface TokenModel ()

@end

@implementation TokenDataModel

-(void)show
{
    NSLog(@"----------------------------------------");
    NSLog(@"TokenDataModel token = %@\n", [self token]);
    NSLog(@"----------------------------------------");
}
@end


@implementation TokenModel

-(void)show
{
    NSLog(@"----------------------------------------");
    NSLog(@"TokenModel code = %d\n", [self code]);
    [[self data] show];
    NSLog(@"TokenModel msg = %@\n", [self msg]);
    NSLog(@"----------------------------------------");
}
@end
