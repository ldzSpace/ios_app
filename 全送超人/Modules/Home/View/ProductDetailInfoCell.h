//
//  ProductDetailCellInfo.h
//  全送超人
//
//  Created by admin on 2018/11/12.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailInfoCell : UITableViewCell
@property (nonatomic, assign) CGFloat cellHight;
@property (nonatomic, strong) UITextField * moneyInput;
@property (nonatomic, strong) UITextField * dayInput;
@property (nonatomic, strong) UIView * cview;

- (void)setInfoData:(ProductModel*)data Type:(NSInteger)type;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (id)init;
@end

NS_ASSUME_NONNULL_END
