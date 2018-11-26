//
//  RecommendProductCell.m
//  全送超人
//
//  Created by admin on 2018/11/9.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "RecommendProductCell.h"
#import "FontAndColorMacros.h"
#import "UtilsMacros.h"
#import "UIImageView+WebCache.h"
#import "NSString+URL.h"
#import "DetailPageController.h"
#import "KMTagListView.h"

@interface RecommendProductCell()

@property (strong, nonatomic) UIImageView * logoImg;
@property (strong, nonatomic) UIView * cView;
@property (strong, nonatomic) ProductModel * data;
@property (strong, nonatomic) KMTagListView *tagList;

@end

@implementation RecommendProductCell

- (id)init
{
    self = [super init];
    if (self)
    {
        _cView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 90)];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 355, 90)];
        [img setImage:[UIImage imageNamed:@"icon_menu_go"]];
        [_cView addSubview:img];
        
        _logoImg = [[UIImageView alloc] initWithFrame:CGRectMake(25, 25, 60, 60)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_logoImg.bounds byRoundingCorners:(UIRectCornerBottomLeft |UIRectCornerBottomRight | UIRectCornerTopLeft |UIRectCornerTopRight) cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _logoImg.bounds;
        maskLayer.path = maskPath.CGPath;
        _logoImg.layer.mask = maskLayer;
        [_cView addSubview:_logoImg];
        
        _toplabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 25, 200, 20)];
        _toplabel.textColor = [UIColor whiteColor];
        _toplabel.font = [UIFont systemFontOfSize:16];
        [_cView addSubview:_toplabel];
        
        _subtitle = [[UILabel alloc] initWithFrame:CGRectMake(95, 45, 200, 20)];
        _subtitle.textColor = [UIColor whiteColor];
        _subtitle.font = [UIFont systemFontOfSize:12];

        [_cView addSubview:_subtitle];
        
        _tagList = [[KMTagListView alloc]initWithFrame:CGRectMake(95, 65, 300, 0)];
        _tagList.delegate_ = self;
    
        [_cView addSubview:_tagList];
        
        [self.contentView addSubview:_cView];
        
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_cView addGestureRecognizer:tapGesturRecognizer];
    }
    
    return self;
}

-(void)setRecommendData:(ProductModel*)data{
    _data = data;
    _toplabel.text = data.name;
    _subtitle.text = [NSString stringWithFormat:@"%@%d-%d%@ · %@%@",@"可借",data.maxAmount,data.minAmount,@"万元",data.speed,@"放款"];
    NSLog(@"图片%@",data.logo);
    [_logoImg sd_setImageWithURL:[NSURL URLWithString: [data.logo URLEncodedString]] placeholderImage:[UIImage imageNamed:@"icon_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"图片加载完成");
    }];
    
    //[_tagsFrame setTagsArray:data.tags FontSize:12];
    
//    UIView *backView = [[UIView alloc] init];
//    backView.frame = CGRectMake(95, 60, 200, 20);
//    [_cView addSubview:backView];
//
//    for (NSInteger i=0; i< data.tags.count; i++) {
//        UIButton *tagsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [tagsBtn setTitle:data.tags[i] forState:UIControlStateNormal];
//        [tagsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        tagsBtn.titleLabel.font = TagsTitleFont;
//        tagsBtn.backgroundColor = CTagBgColor;
//        tagsBtn.layer.cornerRadius = 10;
//        tagsBtn.layer.masksToBounds = YES;
//        tagsBtn.frame = CGRectFromString(_tagsFrame.tagsFrames[i]);
//        [backView addSubview:tagsBtn];
//    }
   
        [_tagList setupSubViewsWithTitles:data.tags TagBgColor:CTagBgColor TagTextColor:[UIColor whiteColor] BordColor:CTagBgColor BorderCornus:10 BorderSize:0 TextSize:10];
        CGRect rect = _tagList.frame;
        rect.size.height = _tagList.contentSize.height;
        _tagList.frame = rect;
    
   
}

-(void)tapAction:(id)tap
{
    if(_data){
         [self.delegate clickWithRecommendProductBtn:_data._id];
        NSLog(@"有效点击");
    }
    NSLog(@"点击了tapView");
}

@end
