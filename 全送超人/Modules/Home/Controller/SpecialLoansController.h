//
//  SpecialLoansController.h
//  dky
//
//  Created by cosmos on 2018/11/12.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductListReq.h"
#import "ProductListLogic.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "CateModel.h"
#import "RootViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface SpecialLoansController : RootViewController


-(id)initWithCateID:(CateModel*)cate;

@end

NS_ASSUME_NONNULL_END
