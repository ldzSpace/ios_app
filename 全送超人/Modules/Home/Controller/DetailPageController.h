//
//  DetailPageController.h
//  全送超人
//
//  Created by admin on 2018/11/10.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailPageController : RootViewController 

@property(assign,nonatomic)int productID;

-(id)initWithProductID:(NSString*)productId;

@end

NS_ASSUME_NONNULL_END
