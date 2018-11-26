//
//  UITabBar+CustomBadge.m
//  全送超人
//
//  Created by admin on 2018/11/6.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "UITabBar+CustomBadge.h"
#import <objc/runtime.h>

static NSString * const kBadgeViewInitedKey = @"kBadgeViewInited";
static NSString * const kBadgeDotViewsKey = @"kBadgeDotViewsKey";
static NSString * const kBadgeNumberViewsKey = @"kBadgeNumberViewsKey";
static NSString * const kTabIconWidth = @"kTabIconWidth";
static NSString * const kBadgeTop = @"kBadgeTop";

// UITabBar 中包含多个UITabBarItem，我们是用UITabBarController添加UITabBars
@implementation UITabBar (CustomBadge)


/**
 设置图片的宽度

 @param width 图片宽度
 */
-(void)setTabIconWidth:(CGFloat)width{
    [self setValue:@(width) forUndefinedKey:kTabIconWidth];
}


/**
 设置小红点的高度

 @param top 高度值
 */
-(void)setBadgeTop:(CGFloat)top{
    [self setValue:@(top) forUndefinedKey:kBadgeTop];
}


/**
 设置小红点的类型

 @param type 类型
 @param badgeValue <#badgeValue description#>
 @param index <#index description#>
 */
-(void)setBadgeStyle:(CustomBadgeType)type value:(NSInteger)badgeValue atIndex:(NSInteger)index{
    // 判断bageView 是否初始化
    if( ![[self valueForKey:kBadgeViewInitedKey] boolValue] ){
        // 进行初始化
        [self setValue:@(YES) forKey:kBadgeViewInitedKey];
        [self addBadgeViews];
    }
    NSMutableArray *badgeDotViews = [self valueForKey:kBadgeDotViewsKey];
    NSMutableArray *badgeNumberViews = [self valueForKey:kBadgeNumberViewsKey];
    
    [badgeDotViews[index] setHidden:YES];
    [badgeNumberViews[index] setHidden:YES];
    
    // 纯红点模式
    if(type == kCustomBadgeStyleRedDot){
        [badgeDotViews[index] setHidden:NO];
    // 红点内部包含数值模式
    }else if(type == kCustomBadgeStyleNumber){
        [badgeNumberViews[index] setHidden:NO];
        UILabel *label = badgeNumberViews[index];
        [self adjustBadgeNumberViewWithLabel:label number:badgeValue];
        
    }else if(type == kCustomBadgeStyleNone){
    }
}


/**
 添加提示小红点
 */
-(void)addBadgeViews{
    // 拿到icon的宽度
    id idIconWith = [self valueForKey:kTabIconWidth];
    CGFloat tabIconWidth = idIconWith ? [idIconWith floatValue] : 32;
    // 拿到badge的高度
    id idBadgeTop = [self valueForKey:kBadgeTop];
    CGFloat badgeTop = idBadgeTop ? [idBadgeTop floatValue] : 11;
    
    // tabbar的个数
    NSInteger itemsCount = self.items.count;
    CGFloat itemWidth = self.bounds.size.width / itemsCount;
    
    //dot views
    NSMutableArray *badgeDotViews = [NSMutableArray new];
    for(int i = 0;i < itemsCount;i ++){
        UIView *redDot = [UIView new];
        redDot.bounds = CGRectMake(0, 0, 10, 10);
        // 计算每个dotView 的中心位置
        redDot.center = CGPointMake(itemWidth*(i+0.5)+tabIconWidth/2, badgeTop);
        redDot.layer.cornerRadius = redDot.bounds.size.width/2;
        redDot.clipsToBounds = YES;
        redDot.backgroundColor = [UIColor redColor];
        redDot.hidden = YES;
        [self addSubview:redDot];
        [badgeDotViews addObject:redDot];
    }
    [self setValue:badgeDotViews forKey:kBadgeDotViewsKey];
    
    // 添加带数值的红点
    NSMutableArray *badgeNumberViews = [NSMutableArray new];
    for(int i = 0;i < itemsCount;i ++){
        UILabel *redNum = [UILabel new];
        redNum.layer.anchorPoint = CGPointMake(0, 0.5);
        redNum.bounds = CGRectMake(0, 0, 20, 14);
        redNum.center = CGPointMake(itemWidth*(i+0.5)+tabIconWidth/2-10, badgeTop);
        redNum.layer.cornerRadius = redNum.bounds.size.height/2;
        redNum.clipsToBounds = YES;
        redNum.backgroundColor = [UIColor redColor];
        redNum.hidden = YES;
        
        redNum.textAlignment = NSTextAlignmentCenter;
        redNum.font = [UIFont systemFontOfSize:12];
        redNum.textColor = [UIColor whiteColor];
        
        [self addSubview:redNum];
        [badgeNumberViews addObject:redNum];
    }
    [self setValue:badgeNumberViews forKey:kBadgeNumberViewsKey];
}


/**
 适配小红点内部的数值，根据值得不同控制不同得大小

 @param label 内部文本空间
 @param number 具体数值
 */
-(void)adjustBadgeNumberViewWithLabel:(UILabel *)label number:(NSInteger)number{
    [label setText:(number > 99 ? @"..." : @(number).stringValue)];
    if(number < 10){
        label.bounds = CGRectMake(0, 0, 14, 14);
    }else if(number < 99){
        label.bounds = CGRectMake(0, 0, 20, 14);
    }else{
        label.bounds = CGRectMake(0, 0, 20, 14);
    }
}


/**
 通过key 获取value
 @param key <#key description#>
 @return <#return value description#>
 */
-(id)valueForUndefinedKey:(NSString *)key{
    return objc_getAssociatedObject(self, (__bridge const void *)(key));
}

/**
 设置关联

 @param value 
 @param key
 */
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    objc_setAssociatedObject(self, (__bridge const void *)(key), value, OBJC_ASSOCIATION_COPY);
}

@end
