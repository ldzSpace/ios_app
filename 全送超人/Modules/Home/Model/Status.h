//
//  Status.h
//  全送超人
//
//  Created by admin on 2018/11/8.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Status : NSObject

@property(assign,nonatomic)int code;

@property(strong,nonatomic)NSDictionary * data;


@end

NS_ASSUME_NONNULL_END
