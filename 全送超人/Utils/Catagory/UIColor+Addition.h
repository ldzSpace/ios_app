//
//  UIColor+Addition.h
//  全送超人
//
//  Created by admin on 2018/11/6.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Addition)
//设置RGB颜色
+ (UIColor *)red:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;
//将颜色转换成RGB
+ (NSArray *)convertColorToRGB:(UIColor *)color;
//设置十六进制颜色
+ (UIColor *)colorWithHex:(NSInteger)hex;
+ (UIColor*)colorWithHexString:(NSString *)hexString;
@end

NS_ASSUME_NONNULL_END
