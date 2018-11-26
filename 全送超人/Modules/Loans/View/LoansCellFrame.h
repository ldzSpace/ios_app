//
//   LC1Frame.h
//  dky
//
//  Created by cosmos on 2018/11/8.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoansCellFrame : NSObject

@property (nonatomic, assign) CGRect iconF;
@property (nonatomic, assign) CGRect mainLabelF; //主标题
@property (nonatomic, assign) CGRect subLabelF; //副标题
@property (nonatomic, assign) CGRect applyLabelF; //申请人数
@property (nonatomic, assign) CGRect applyButtonF; //申请按钮
@property (nonatomic, assign) CGRect splitLineF; //分割线
@property (nonatomic, assign) CGRect amountRangeF; //额度数据
@property (nonatomic, assign) CGRect amountF; //额度
@property (nonatomic, assign) CGRect rateNumF; //利率数字
@property (nonatomic, assign) CGRect rateF; //利率
@property (nonatomic, assign) CGRect speedNumF; //速度数字
@property (nonatomic, assign) CGRect speedF; //speed
@property (nonatomic, assign) CGRect passingRateNumF; //通过率数字
@property (nonatomic, assign) CGRect passingRateF; //通过率
@property (nonatomic, assign) CGFloat cellHeight; //行高

/**
 *  模型数据
 */
@property (nonatomic, strong) ProductModel *data;

- (void)setProductListData:(ProductModel *)pdata;
@end
NS_ASSUME_NONNULL_END
