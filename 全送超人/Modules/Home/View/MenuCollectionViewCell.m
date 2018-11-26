//
//  MenuCollectionViewCell.m
//  全送超人
//
//  Created by admin on 2018/11/7.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "MenuCollectionViewCell.h"

@implementation MenuCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
       
        _toplabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 50)];
        _toplabel.textAlignment =  NSTextAlignmentCenter;
        _toplabel.textColor = [UIColor whiteColor];
        _toplabel.font = [UIFont boldSystemFontOfSize:14];
        
        
        _botlabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, 100, 50)];
        _botlabel.textAlignment = NSTextAlignmentCenter;
        _botlabel.textColor = [UIColor whiteColor];
        _botlabel.font = [UIFont systemFontOfSize:13];
        
        [self.contentView addSubview:_toplabel];
        [self.contentView addSubview:_botlabel];
    }
    
    return self;
}

@end
