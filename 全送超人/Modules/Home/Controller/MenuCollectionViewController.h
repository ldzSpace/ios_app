//
//  MenuCollectionViewController.h
//  全送超人
//
//  Created by admin on 2018/11/7.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CateModel.h"
@protocol MenuCollectionViewDelegate<NSObject>

- (void)popToCateList:(CateModel*)cate;

@end


NS_ASSUME_NONNULL_BEGIN

@interface MenuCollectionViewController : UICollectionViewController
@property (strong, nonatomic) id<MenuCollectionViewDelegate>delegate;

-(void)setMenuData:(NSMutableArray*) dataArray;

-(void)removeMenuData;

@end

NS_ASSUME_NONNULL_END
