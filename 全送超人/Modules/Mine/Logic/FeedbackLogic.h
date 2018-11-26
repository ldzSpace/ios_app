//
//  FeedbackLogic.h
//  全送超人
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^HttpRequestCallBack)(BOOL success,NSString *error);

@interface FeedbackLogic : NSObject


- (void)loadData:(NSString*)content CompletionBlock:(HttpRequestCallBack)completion;

@end

NS_ASSUME_NONNULL_END
