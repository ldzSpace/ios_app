//
//  AdAlertView.h
//  全送超人
//
//  Created by admin on 2018/11/14.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol AdAlertViewDelegate<NSObject>

- (void)clickWithImageBg:(PopupModel*)popup;

@end

@interface AdAlertView : UIView

@property (nonatomic, strong) id<AdAlertViewDelegate> delegate;

/**
 首页弹框
 */
//+ (void)showUpdateAlertWithPop:(PopupModel *)pop;
- (instancetype)initWithPopup:(PopupModel *)pop;

@end

NS_ASSUME_NONNULL_END
