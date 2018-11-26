//
//  ProductDetailCellFrame.m
//  全送超人
//
//  Created by admin on 2018/11/10.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "ProductDetailCellFrame.h"
#import "LoansCellFrame.h"
#import "URLMacros.h"
#import "UtilsMacros.h"

@implementation ProductDetailCellFrame

- (void)setProductListData:(ProductModel *)pdata
{
    _data = pdata;//[pdata copy];
    // 设置头像的frame
    CGFloat iconViewX = 15;
    CGFloat iconViewY = 25;
    CGFloat iconViewW = 60;
    CGFloat iconViewH = 60;
    self.iconF = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    // 设置主label的frame
    // 主label的x = 头像最大的x + 间隙
    CGFloat mainLabelX = CGRectGetMaxX(self.iconF) + 10;
    CGSize mainLabelSize = [self sizeWithString:pdata.name font:LCMainFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    CGFloat mainLabelH = mainLabelSize.height;
    CGFloat mainLabelW = mainLabelSize.width;
    CGFloat mainLabelY = 25;
    self.mainLabelF = CGRectMake(mainLabelX, mainLabelY, mainLabelW, mainLabelH);
    
    //设置副标题
    // 计算文字的宽高
    CGSize subLabelSize = [self sizeWithString:pdata.subtitle font:LCSubFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat subLabelH = subLabelSize.height;
    CGFloat subLabelW = subLabelSize.width;
    CGFloat subLabelY = 25 + mainLabelSize.height + 3;
    self.subLabelF = CGRectMake(mainLabelX, subLabelY, subLabelW, subLabelH);
    
    NSString *apllyLabelText = @"";
    if (pdata.applyPersonCount < 10000)
    {
        apllyLabelText = [NSString stringWithFormat:@"%d万人申请 · %@放款", pdata.applyPersonCount, pdata.speed];
    }
    else
    {
        apllyLabelText = [NSString stringWithFormat:@"%.1f万人申请 · %@放款", pdata.applyPersonCount/10000.0, pdata.speed];
    }
    
    CGSize applyLabelSize = [self sizeWithString:apllyLabelText font:LCApplyFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat applyLabelY = subLabelY + 20;
    CGFloat applyLabelH = subLabelSize.height;
    CGFloat applyLabelW = applyLabelSize.width;
    self.applyLabelF = CGRectMake(mainLabelX, applyLabelY, applyLabelW, applyLabelH);
    
    CGFloat splitLineY = applyLabelY + 25;
    CGFloat splitLineW = KScreenWidth;
    CGFloat splitLineH = 1;
    self.splitLineF = CGRectMake(0, splitLineY, splitLineW, splitLineH);
    
    CGFloat tagsLableY = splitLineY + 28;
    CGFloat tagsLableW = KScreenWidth;
    CGFloat tagsLableH = 40;
    self.tags = CGRectMake(iconViewX, tagsLableY, tagsLableW,tagsLableH);
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
