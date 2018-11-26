//
//  ProductDetailCellInfo.m
//  全送超人
//
//  Created by admin on 2018/11/12.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "ProductDetailInfoCell.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "ZJPickerView.h"
#import "ProductDetailInfoCellFrame.h"

@interface ProductDetailInfoCell()

@property (nonatomic, strong) ProductDetailInfoCellFrame * pdFrame;
@property (nonatomic, strong) ProductModel * data;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *textLable;

@end

@implementation ProductDetailInfoCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
 
    static NSString *identifier = @"ProductDetailInfoCell";
    // 1.缓存中取
    ProductDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (!cell)
    {
        cell = [[ProductDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
/*
 *  构造方法(在初始化对象的时候会调用)
 *  一般在这个方法中添加需要显示的子控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 0.创建背景
         _cview =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 0)];
         _cview.backgroundColor = [UIColor whiteColor];

        // 2.创建主label
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = CNavBgColor;
        [_cview addSubview:_titleLabel];
        
     
        //创建额度数据
        _textLable = [[UIView alloc] init];
        [_cview addSubview:_textLable];

        
        [self.contentView addSubview:_cview];
        self.contentView.backgroundColor = [UIColor colorWithRed:241.0/255 green:242.0/255 blue:246.0/255 alpha:1.0];
       
    }
    return self;
}


#pragma mark -------- 设置数据 -----------
- (void)setInfoData:(ProductModel*)data Type:(NSInteger)type
{
    NSLog(@"xxssss");
    ProductDetailInfoCellFrame* pdFrame = [[ProductDetailInfoCellFrame alloc] init];
    [pdFrame setProductInfoData:data Type:type];
    self.textLable.frame = pdFrame.contentFrame ;
    self.titleLabel.frame = pdFrame.titleFrame;
    _cview.frame = CGRectMake(0, 0, KScreenWidth,pdFrame.cellHight);
    NSLog(@"frame = %f",pdFrame.cellHight);
  
    NSArray * dataArray;
    switch (type) {
        case 0:
            dataArray = data.conditions;
            self.titleLabel.text = @"申请资格";
            break;
        case 1:
            dataArray = data.datum;
            self.titleLabel.text = @"需要资料";
            break;
        case 2:
            dataArray = data.introduction;
             self.titleLabel.text = @"产品介绍";
            break;
    }
    int i = 0;
    for (NSString* str in dataArray) {
        NSValue *frame =pdFrame.contentCellFrame[i++];
        UILabel * lable = [[UILabel alloc]initWithFrame:[frame CGRectValue]];
        lable.text = str;
        lable.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
        lable.font = [UIFont systemFontOfSize:16];
        [_textLable addSubview:lable];
    }
 
}




/**
 *  计算文本的宽高
 *
 *  @param str     需要计算的文本
 *  @param font    文本显示的字体
 *  @param maxSize 文本显示的范围
 *
 *  @return 文本占用的真实宽高
 */
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}
@end
