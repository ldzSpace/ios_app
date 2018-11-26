//
//  TagView.m
//  全送超人
//
//  Created by admin on 2018/11/12.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "KMTag.h"
#import "UIColor+YYAdd.h"

@implementation KMTag

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setupWithText:(NSString*)text TextSize:(UIFont*)textFont{
    
    self.text = text;
    self.font = textFont;
    UIFont* font = self.font;
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: font}];
    CGRect frame = self.frame;
    frame.size = CGSizeMake(size.width + 5, size.height + 10);
    
    self.frame = frame;
}


- (void)setFontColor:(UIColor*) color{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange range1 = [[str string] rangeOfString:self.text];
    [str addAttribute:NSForegroundColorAttributeName value:color range:range1];
    self.attributedText = str;
}

- (void)setBorder:(UIColor*)color cornerRadius:(int)cornerRadius BorderWidth:(int)width{
    if(width){
        self.layer.borderWidth = width;
    }
    if(color){
        self.layer.borderColor = color.CGColor;
    }
    if(cornerRadius){
        self.layer.cornerRadius = cornerRadius;
    }
  
}


- (void)setTagBackgroudColor:(UIColor*)color{
    
    self.layer.backgroundColor = color.CGColor;
    
}
@end
