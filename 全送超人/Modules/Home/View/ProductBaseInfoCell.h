//
//  ProductBaseInfoCell.h
//  全送超人
//
//  Created by admin on 2018/11/13.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProductBaseInfoCell : UITableViewCell

@property (strong, nonatomic) UIView * infoView;
@property (strong, nonatomic) UITextField *moneyInput;
@property (strong, nonatomic) UITextField *dayInput;
@property (strong, nonatomic) UILabel * interstLabel;
-(void)setDelegate:(id)delegate;
-(void)setInfoData:(ProductModel*)product;

@end

NS_ASSUME_NONNULL_END
