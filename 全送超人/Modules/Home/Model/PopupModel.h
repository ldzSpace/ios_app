//
//  PopupModel.h
//  全送超人
//
//  Created by admin on 2018/11/8.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopupModel : NSObject
@property(nonatomic)int position;
@property(nonatomic)int linkType;
@property(copy,nonatomic)NSString * jumpProduct;
@property(copy,nonatomic)NSString * updateAt;
@property(copy,nonatomic)NSString * remark;
@property(copy,nonatomic)NSString * imgSrc;
@property(copy,nonatomic)NSString * url;
@property(copy,nonatomic)NSString * name;
@property(copy,nonatomic)NSString * _id;
@end

NS_ASSUME_NONNULL_END
