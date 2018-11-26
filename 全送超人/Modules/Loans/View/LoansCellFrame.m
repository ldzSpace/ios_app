//
//   LC1Frame.m
//  dky
//
//  Created by cosmos on 2018/11/8.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoansCellFrame.h"
#import "URLMacros.h"
#import "UtilsMacros.h"

@implementation LoansCellFrame

-(id)init
{
    _data = [[ProductModel alloc] init];
    return self;
}

- (void)setProductListData:(ProductModel *)pdata
{
    _data = pdata;//[pdata copy];
    // 设置头像的frame
    CGFloat iconViewX = 15;
    CGFloat iconViewY = 12;
    CGFloat iconViewW = 50;
    CGFloat iconViewH = 50;
    self.iconF = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    // 设置主label的frame
    // 主label的x = 头像最大的x + 间隙
    CGFloat mainLabelX = CGRectGetMaxX(self.iconF) + 10;
    // 计算文字的宽高
    CGSize mainLabelSize = [self sizeWithString:pdata.name font:LCMainFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    CGFloat mainLabelH = mainLabelSize.height;
    CGFloat mainLabelW = mainLabelSize.width;
    CGFloat mainLabelY = 15;
    self.mainLabelF = CGRectMake(mainLabelX, mainLabelY, mainLabelW, mainLabelH);
    
    //设置副标题
    // 计算文字的宽高
    CGSize subLabelSize = [self sizeWithString:pdata.subtitle font:LCSubFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat subLabelH = subLabelSize.height;
    CGFloat subLabelW = subLabelSize.width;
    CGFloat subLabelY = 15 + mainLabelSize.height + 6;
    self.subLabelF = CGRectMake(mainLabelX, subLabelY, subLabelW, subLabelH);
    
    NSString *apllyLabelText = @"";
    if (pdata.applyPersonCount < 10000)
    {
        apllyLabelText = [NSString stringWithFormat:@"%d万人申请", pdata.applyPersonCount];
    }
    else
    {
        apllyLabelText = [NSString stringWithFormat:@"%.1f万人申请", pdata.applyPersonCount/10000.0];
    }
    
    CGSize applyLabelSize = [self sizeWithString:apllyLabelText font:LCApplyFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat applyLabelX = KScreenWidth - applyLabelSize.width - 15;
    CGFloat applyLabelY = 12;
    CGFloat applyLabelH = subLabelSize.height;
    CGFloat applyLabelW = subLabelSize.width;
    self.applyLabelF = CGRectMake(applyLabelX, applyLabelY, applyLabelW, applyLabelH);
    
    CGFloat applyButtonX = KScreenWidth - 75 - 15;
    CGFloat applyButtonY = 12 + applyLabelSize.height + 8;
    CGFloat applyButtonW = 75;
    CGFloat applyButtonH = 26;
    self.applyButtonF = CGRectMake(applyButtonX, applyButtonY, applyButtonW, applyButtonH);
    
    CGFloat splitLineX = 15;
    CGFloat splitLineY = 74;
    CGFloat splitLineW = KScreenWidth - 15;
    CGFloat splitLineH = 1;
    self.splitLineF = CGRectMake(splitLineX, splitLineY, splitLineW, splitLineH);

    NSString *sMinA = @"";
    if (pdata.minAmount%10000 != 0)
    {
        sMinA = [NSString stringWithFormat:@"%.1f", pdata.minAmount/10000.0];
    }
    else
    {
        sMinA = [NSString stringWithFormat:@"%d", pdata.minAmount/10000];
    }
    NSString *sMaxA = @"";
    if (pdata.minAmount%10000 != 0)
    {
        sMaxA = [NSString stringWithFormat:@"%.1f", pdata.maxAmount/10000.0];
    }
    else
    {
        sMaxA = [NSString stringWithFormat:@"%d", pdata.maxAmount/10000];
    }
    NSString *amountRange = [NSString stringWithFormat:@"%@-%@万", sMinA, sMaxA];
    CGSize amountRangeLabelSize = [self sizeWithString:amountRange font:LCApplyFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat amountRangeLabelX = 15;
    CGFloat amountRangeLabelY = 74+1+12.5;
    CGFloat amountRangeLabelH = amountRangeLabelSize.height;
    CGFloat amountRangeLabelW = amountRangeLabelSize.width;
    self.amountRangeF = CGRectMake(amountRangeLabelX, amountRangeLabelY, amountRangeLabelW, amountRangeLabelH);
    
    CGSize amountLabelSize = [self sizeWithString:@"额度" font:LCApplyFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat amountLabelX = 15;
    CGFloat amountLabelY = 121.5 - amountLabelSize.height;
    CGFloat amountLabelH = amountLabelSize.height;
    CGFloat amountLabelW = amountLabelSize.width;
    self.amountF = CGRectMake(amountLabelX, amountLabelY, amountLabelW, amountLabelH);
    
    NSString *rateNum = @"";
    NSString *rate = @"";
    if (pdata.rateUnit == 1)
    {
        rateNum = [NSString stringWithFormat:@"%d", pdata.dayRate];
        rate = @"日利率（%）";
    }
    else if (pdata.rateUnit == 2)
    {
        rateNum = [NSString stringWithFormat:@"%d", pdata.monthRate];
        rate = @"月利率（%）";
    }
    
    CGSize rateNumLabelSize = [self sizeWithString:rateNum font:LCApplyFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat rateNumLabelX = 15 + KScreenWidth/4;
    CGFloat rateNumLabelY = 74+1+12.5;
    CGFloat rateNumLabelH = rateNumLabelSize.height;
    CGFloat rateNumLabelW = rateNumLabelSize.width;
    self.rateNumF = CGRectMake(rateNumLabelX, rateNumLabelY, rateNumLabelW, rateNumLabelH);
    
    CGSize rateLabelSize = [self sizeWithString:rate font:LCApplyFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat rateLabelX = 15 + KScreenWidth/4;
    CGFloat rateLabelY = 121.5 - rateLabelSize.height;
    CGFloat rateLabelH = rateLabelSize.height;
    CGFloat rateLabelW = rateLabelSize.width;
    self.rateF = CGRectMake(rateLabelX, rateLabelY, rateLabelW, rateLabelH);
    
    CGSize speedNumLabelSize = [self sizeWithString:pdata.speed font:LCSubFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat speedNumLabelX = 15 + KScreenWidth/2;
    CGFloat speedNumLabelY = 74+1+10.5;
    CGFloat speedNumLabelH = speedNumLabelSize.height;
    CGFloat speedNumLabelW = speedNumLabelSize.width;
    self.speedNumF = CGRectMake(speedNumLabelX, speedNumLabelY, speedNumLabelW, speedNumLabelH);
    
    CGSize speedLabelSize = [self sizeWithString:@"下款速度" font:LCApplyFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat speedLabelX = 15 + KScreenWidth/2;
    CGFloat speedLabelY = 121.5 - speedLabelSize.height;
    CGFloat speedLabelH = speedLabelSize.height;
    CGFloat speedLabelW = speedLabelSize.width;
    self.speedF = CGRectMake(speedLabelX, speedLabelY, speedLabelW, speedLabelH);
    
    CGSize passingRateNumLabelSize = [self sizeWithString:[NSString stringWithFormat:@"%d%%", pdata.passingRate] font:LCSubFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat passingRateNumLabelX = 15 + KScreenWidth*3/4;
    CGFloat passingRateNumLabelY = 74+1+10.5;
    CGFloat passingRateNumLabelH = passingRateNumLabelSize.height;
    CGFloat passingRateNumLabelW = passingRateNumLabelSize.width;
    self.passingRateNumF = CGRectMake(passingRateNumLabelX, passingRateNumLabelY, passingRateNumLabelW, passingRateNumLabelH);
    
    CGSize passingRateLabelSize = [self sizeWithString:@"通过率" font:LCApplyFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat passingRateLabelX = 15 + KScreenWidth*3/4;
    CGFloat passingRateLabelY = 121.5-passingRateLabelSize.height;//74+1+10.5 + passingRateNumLabelSize.height + 7;
    CGFloat passingRateLabelH = passingRateLabelSize.height;
    CGFloat passingRateLabelW = passingRateLabelSize.width;
    self.passingRateF = CGRectMake(passingRateLabelX, passingRateLabelY, passingRateLabelW, passingRateLabelH);
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
