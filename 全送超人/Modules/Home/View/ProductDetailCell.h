//
//  ProductCell.h
//  全送超人
//
//  Created by admin on 2018/11/9.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailCell : UITableViewCell

@property (strong, nonatomic) UILabel *toplabel;

@property (strong, nonatomic) UILabel *subtitle;

@property (strong, nonatomic) UILabel *bottomtitle;

@property (strong, nonatomic) UIImageView * logo;


- (void)setProductData:(ProductModel*)data;


@end

NS_ASSUME_NONNULL_END
