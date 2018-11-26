//
//  KMTagListView.h
//  全送超人
//
//  Created by admin on 2018/11/12.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class KMTagListView;
@protocol KMTagListViewDelegate<NSObject>

- (void)ptl_TagListView:(KMTagListView*)tagListView didSelectTagViewAtIndex:(NSInteger)index selectContent:(NSString *)content;

@end

@interface KMTagListView : UIScrollView

@property (nonatomic, weak)id<KMTagListViewDelegate> delegate_;

- (void)setupSubViewsWithTitles:(NSArray *)titles TagBgColor:(UIColor*)bgColor TagTextColor:(UIColor*)textColor BordColor:(UIColor*)borderColoer BorderCornus:(int)borderCornus  BorderSize:(int)borderSize TextSize:(int)textSize;

@end
NS_ASSUME_NONNULL_END
