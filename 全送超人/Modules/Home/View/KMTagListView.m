//
//  KMTagListView.m
//  全送超人
//
//  Created by admin on 2018/11/12.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "KMTagListView.h"
#import "KMTag.h"
#import "FontAndColorMacros.h"
@interface KMTagListView ()

@property (nonatomic,strong)NSMutableArray *tags;


@end

@implementation KMTagListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        self.pagingEnabled = YES;
    }
    return self;
}

- (NSMutableArray *)tags {
    if (_tags == nil) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}


- (void)setupSubViewsWithTitles:(NSArray *)titles TagBgColor:(UIColor*)bgColor TagTextColor:(UIColor*)textColor BordColor:(UIColor*)borderColoer BorderCornus:(int)borderCornus  BorderSize:(int)borderSize TextSize:(int)textSize {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tags removeAllObjects];
    
    for (NSInteger i = 0; i < titles.count; i++) {
        KMTag *tag = [[KMTag alloc] initWithFrame:CGRectZero];
        if(textSize){
             [tag setupWithText:titles[i] TextSize:[UIFont systemFontOfSize:textSize]];
        }else {
             [tag setupWithText:titles[i] TextSize:[UIFont systemFontOfSize:10]];
        }
       
        [self addSubview:tag];
        [self.tags addObject:tag];
        if(bgColor){
            [tag setTagBackgroudColor:bgColor];
        }
        
        [tag setBorder:borderColoer cornerRadius:borderCornus BorderWidth:borderSize];
        
        if(textColor){
            [tag setFontColor:textColor];
        }
        
        // 添加手势
        tag.tag = i;
        UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTagClick:)];
        [tag addGestureRecognizer:pan];
        tag.userInteractionEnabled = YES;
    }
    
    [self setupAllSubViews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setupAllSubViews];
}


- (void)selectTagClick:(UIPanGestureRecognizer *)pan {
    KMTag *tag = (KMTag *)pan.view;
    
    if ([self.delegate_ respondsToSelector:@selector(ptl_TagListView:didSelectTagViewAtIndex:selectContent:)]) {
        [self.delegate_ ptl_TagListView:self didSelectTagViewAtIndex:tag.tag selectContent:tag.text];
    }
}



- (void)setupAllSubViews {
    
    CGFloat marginX = 5;
    CGFloat marginY = 5;
    
    __block CGFloat x = 0;
    __block CGFloat y = 0;
    
    [self.tags enumerateObjectsUsingBlock:^(KMTag *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        CGFloat height = CGRectGetHeight(obj.frame);
        
        if (idx == 0) {
            x = 0;
        }else {
            x = CGRectGetMaxX([self.tags[idx - 1] frame]) + marginX;
            if ( x + CGRectGetWidth(obj.frame) + marginX > CGRectGetWidth(self.frame) ) {
                x = marginX;
                y += height;
                y += marginY;
            }
        }
        CGRect frame = obj.frame;
        frame.origin = CGPointMake(x, y);
        obj.frame = frame;
        
    }];
    
    // 如果只有一行，居中显示
    if (y == 10) {
        
        [self.tags enumerateObjectsUsingBlock:^(KMTag *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CGFloat height = CGRectGetHeight(obj.frame);
            y = CGRectGetHeight(self.frame) / 2 - height / 2.0;
            
            if (idx == 0) {
                x = marginX;
            }else {
                x = CGRectGetMaxX([self.tags[idx - 1] frame]) + marginX;
            }
            CGRect frame = obj.frame;
            frame.origin = CGPointMake(x, y);
            obj.frame = frame;
            
        }];
        
    }
    
    CGFloat contentHeight = CGRectGetMaxY([self.tags.lastObject frame]) + 10;
    if (contentHeight < CGRectGetHeight(self.frame)) {
        contentHeight = 0;
    }
    
    self.contentSize = CGSizeMake(0, contentHeight);
}



@end
