//
//  PostFeedbackAPI.h
//  全送超人
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequestAPI.h"
NS_ASSUME_NONNULL_BEGIN

@interface PostFeedbackAPI : YTKRequest

-(id)initWithContent:(NSString *)content  Token:(NSString*)token;
- (id)requestArgument;

@end

NS_ASSUME_NONNULL_END
