//
//  TagView.h
//  全送超人
//
//  Created by admin on 2018/11/12.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KMTag : UILabel


- (void)setupWithText:(NSString*)text TextSize:(UIFont*)textFont;
- (void)setFontColor:(UIColor*) color;
- (void)setBorder:(UIColor*)color cornerRadius:(int)cornerRadius BorderWidth:(int)width;
- (void)setTagBackgroudColor:(UIColor*)color;

@end

NS_ASSUME_NONNULL_END
