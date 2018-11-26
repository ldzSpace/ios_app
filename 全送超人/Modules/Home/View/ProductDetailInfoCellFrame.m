//
//  ProductDetailInfoCellFrame.m
//  全送超人
//
//  Created by admin on 2018/11/12.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "ProductDetailInfoCellFrame.h"
#import "UtilsMacros.h"

@implementation ProductDetailInfoCellFrame

- (void)setProductInfoData:(ProductModel *)pdata Type:(NSInteger)type
{
    _data = pdata;

    // 设置主label的frame
    CGFloat mainLabelX = 15;
    CGSize mainLabelSize = [self sizeWithString:pdata.name font:[UIFont systemFontOfSize:18] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat mainLabelH = mainLabelSize.height;
    CGFloat mainLabelW = mainLabelSize.width;
    CGFloat mainLabelY = 15;
    self.titleFrame = CGRectMake(mainLabelX, mainLabelY, mainLabelW+50, mainLabelH);
    
    //设置副标题
    // 计算文字的宽高
    CGFloat contentY =  mainLabelH;
    CGFloat origcontentY = contentY;
    
    NSArray * array;
    switch (type) {
        case 0:
            array = pdata.conditions;
            break;
        case 1:
            array = pdata.datum;
            break;
        case 2:
            array = pdata.introduction;
            break;
    }
    _contentCellFrame = [[NSMutableArray alloc] init];
    for (NSString* str in array) {
        CGRect rectFrame = CGRectMake(0, contentY, KScreenWidth, 20);
        NSValue *frameValue = [NSValue value:&rectFrame withObjCType:@encode(CGRect)];
        [_contentCellFrame addObject:frameValue];
        CGSize mainLabelSize = [self sizeWithString:str font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        contentY += (mainLabelSize.height + 5);
    }
    contentY += 40;
    self.contentFrame = CGRectMake(mainLabelX, origcontentY, KScreenWidth, contentY - origcontentY);
    self.cellHight = contentY;
    
   
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

