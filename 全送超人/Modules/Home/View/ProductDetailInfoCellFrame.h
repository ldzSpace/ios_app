//
//  ProductDetailInfoCellFrame.h
//  全送超人
//
//  Created by admin on 2018/11/12.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailInfoCellFrame : NSObject

@property (nonatomic, strong) ProductModel * data;
@property (nonatomic, strong) NSMutableArray * contentCellFrame;
@property (nonatomic, assign) CGRect titleFrame; 
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, assign) CGFloat cellHight;

- (void)setProductInfoData:(ProductModel *)pdata Type:(NSInteger)type;
@end

NS_ASSUME_NONNULL_END
