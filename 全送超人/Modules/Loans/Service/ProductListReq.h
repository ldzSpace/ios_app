//
//  ProductListReq.h
//  dky
//
//  Created by cosmos on 2018/11/7.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import "YTKRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductListReq : YTKRequest

-(id)initWithCateId:(NSString *)cateId Min:(int)min Max:(int)max;

@end

NS_ASSUME_NONNULL_END
