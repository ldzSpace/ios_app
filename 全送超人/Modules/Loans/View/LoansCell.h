//
//  LoansCell1.h
//  dky
//
//  Created by cosmos on 2018/11/8.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LoansCellFrame.h"
#import "ProductModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol LoadsProductDelegate<NSObject>

- (void)clickWithLoadBtn:(ProductModel*)product;

- (void)clickWithLoadView:(ProductModel*)product;

@end

@class LoansCellFrame;
@interface LoansCell : UITableViewCell
@property (nonatomic, weak) id<LoadsProductDelegate> delegate;
@property (nonatomic, strong) LoansCellFrame *lcFrame;

+(instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setData:(ProductModel*)data;

@end

NS_ASSUME_NONNULL_END
