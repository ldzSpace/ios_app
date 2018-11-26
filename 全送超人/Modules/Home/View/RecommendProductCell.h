//
//  RecommendProductCell.h
//  全送超人
//
//  Created by admin on 2018/11/9.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ProductModel.h"
#import "HomePageControllerViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol RecommendProductDelegate<NSObject>

- (void)clickWithRecommendProductBtn:(NSString*)productId;

@end

@interface RecommendProductCell : UITableViewCell

@property(strong, nonatomic) id<RecommendProductDelegate> delegate;

@property (strong, nonatomic) UILabel *toplabel;

@property (strong, nonatomic) UILabel *subtitle;

@property (strong, nonatomic) UIImageView * logo;


-(void)setRecommendData:(ProductModel*)data;

@end

NS_ASSUME_NONNULL_END
