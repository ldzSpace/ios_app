//
//  AdAlertView.m
//  全送超人
//
//  Created by admin on 2018/11/14.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "AdAlertView.h"
#import "NSString+URL.h"
#import "DetailPageController.h"
#import "WebViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define DEFAULT_MAX_HEIGHT SCREEN_HEIGHT/4*2

/** App id */
#define APP_ID @"11111111"

/** RGB */
#define SELColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/** 屏幕高度 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//屏幕适配
/**当前设备对应375的比例*/
#define Ratio_375 (SCREEN_WIDTH/375.0)
/**转换成当前比例的数*/
#define Ratio(x) ((int)((x) * Ratio_375))

/** 入场出场动画时间 */
UIKIT_EXTERN const CGFloat SELAnimationTimeInterval;

/** 更新内容显示字体大小 */
UIKIT_EXTERN const CGFloat SELDescriptionFont;

/** 更新内容最大显示高度 */
UIKIT_EXTERN const CGFloat SELMaxDescriptionHeight;

/** 入场出场动画时间 */
const CGFloat SELAnimationTimeInterval = 0.6f;

/** 更新内容显示字体大小 */
const CGFloat SELDescriptionFont = 16;

/** 更新内容最大显示高度 */
const CGFloat SELMaxDescriptionHeight;

@interface AdAlertView()

@property (nonatomic, strong) PopupModel * popup;

@end

@implementation AdAlertView


/**
 添加版本更新提示
 @param version 版本号
 @param descriptions 版本更新内容（数组）
 
 descriptions 格式如 @[@"1.xxxxxx",@"2.xxxxxx"]
 */
//+ (void)showUpdateAlertWithVersion:(NSString *)version Descriptions:(NSArray *)descriptions
//{
//    if (!descriptions || descriptions.count == 0) {
//        return;
//    }
//    
//    //数组转换字符串，动态添加换行符\n
//    NSString *description = @"";
//    for (NSInteger i = 0;  i < descriptions.count; ++i) {
//        id desc = descriptions[i];
//        if (![desc isKindOfClass:[NSString class]]) {
//            return;
//        }
//        description = [description stringByAppendingString:desc];
//        if (i != descriptions.count-1) {
//            description = [description stringByAppendingString:@"\n"];
//        }
//    }
//    NSLog(@"====%@",description);
//    AdAlertView *updateAlert = [[AdAlertView alloc]initBgURL:bgImageURL LinkURL:linkURL];
//    [[UIApplication sharedApplication].delegate.window addSubview:updateAlert];
//}


+ (void)showUpdateAlertWithPop:(PopupModel *)pop
{

}

- (instancetype)initWithPopup:(PopupModel *)pop
{
    self = [super init];
    if (self) {
        self.popup =  pop;
        
        [self _setupUI];
    }
    return self;
}

- (void)_setupUI
{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5/1.0];
    
    //获取更新内容高度
//    CGFloat descHeight = [self _sizeofString:self.desc font:[UIFont systemFontOfSize:SELDescriptionFont] maxSize:CGSizeMake(self.frame.size.width - Ratio(80) - Ratio(56), 1000)].height;
    
    //bgView实际高度
    //CGFloat realHeight = descHeight + Ratio(314);
    
    //bgView最大高度
    CGFloat maxHeight = DEFAULT_MAX_HEIGHT;
    //更新内容可否滑动显示
    //BOOL scrollEnabled = NO;
    
    //重置bgView最大高度 设置更新内容可否滑动显示
    //if (realHeight > DEFAULT_MAX_HEIGHT) {
        //scrollEnabled = YES;
        //descHeight = DEFAULT_MAX_HEIGHT - Ratio(314);
    //}else
    //{
       // maxHeight = realHeight;
    //}
 
    
    //backgroundView
    UIView *bgView = [[UIView alloc]init];
    bgView.center = self.center;
    bgView.bounds = CGRectMake(0, 0, self.frame.size.width - Ratio(40), maxHeight+Ratio(88));
    [self addSubview:bgView];
    
    //添加更新提示
    UIImageView* bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Ratio(30), Ratio(18), bgView.frame.size.width - Ratio(60), maxHeight)];
    [bgImageView sd_setImageWithURL:[NSURL URLWithString:[_popup.imgSrc URLEncodedString]] placeholderImage:[UIImage imageNamed:@"icon_placeholder"]];
    bgImageView.layer.masksToBounds = YES;
    bgImageView.layer.cornerRadius = 7.0f;
    bgImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [bgImageView addGestureRecognizer:singleTap];
    
  
    [bgView addSubview:bgImageView];
    

    
    //20+166+10+28+10+descHeight+20+40+20 = 314+descHeight 内部元素高度计算bgView高度
//    UIImageView *updateIcon = [[UIImageView alloc]initWithFrame:CGRectMake((updateView.frame.size.width - Ratio(178))/2, Ratio(20), Ratio(178), Ratio(166))];
//    updateIcon.image = [UIImage imageNamed:@"icon_menu_blue1"];
//    [updateView addSubview:updateIcon];
    
//    //版本号
//    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Ratio(10) + CGRectGetMaxY(updateIcon.frame), updateView.frame.size.width, Ratio(28))];
//    versionLabel.font = [UIFont boldSystemFontOfSize:18];
//    versionLabel.textAlignment = NSTextAlignmentCenter;
//    versionLabel.text = [NSString stringWithFormat:@"发现新版本 V%@",self.version];
//    [updateView addSubview:versionLabel];
    
    //更新内容
//    UITextView *descTextView = [[UITextView alloc]initWithFrame:CGRectMake(Ratio(28), Ratio(10) + CGRectGetMaxY(versionLabel.frame), updateView.frame.size.width - Ratio(56), descHeight)];
//    descTextView.font = [UIFont systemFontOfSize:SELDescriptionFont];
//    descTextView.textContainer.lineFragmentPadding = 0;
//    descTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    descTextView.text = self.desc;
//    descTextView.editable = NO;
//    descTextView.selectable = NO;
//    descTextView.scrollEnabled = scrollEnabled;
//    descTextView.showsVerticalScrollIndicator = scrollEnabled;
//    descTextView.showsHorizontalScrollIndicator = NO;
//    [updateView addSubview:descTextView];
    
    //if (scrollEnabled) {
        //若显示滑动条，提示可以有滑动条
        //[descTextView flashScrollIndicators];
   // }
    
    //更新按钮
//    UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    updateButton.backgroundColor = SELColor(34, 153, 238);
//    updateButton.frame = CGRectMake(Ratio(25), CGRectGetMaxY(descTextView.frame) + Ratio(20), updateView.frame.size.width - Ratio(50), Ratio(40));
//    updateButton.clipsToBounds = YES;
//    updateButton.layer.cornerRadius = 2.0f;
//    [updateButton addTarget:self action:@selector(updateVersion) forControlEvents:UIControlEventTouchUpInside];
//    [updateButton setTitle:@"立即更新" forState:UIControlStateNormal];
//    [updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [updateView addSubview:updateButton];
    
    //取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    // 右上角
    //cancelButton.center = CGPointMake(CGRectGetMaxX(bgImageView.frame), CGRectGetMinY(bgImageView.frame));
    cancelButton.center = CGPointMake(CGRectGetMaxX(bgImageView.frame)/2, CGRectGetMaxY(bgImageView.frame) + Ratio(50));
    cancelButton.bounds = CGRectMake(0, 0, Ratio(36), Ratio(36));
    [cancelButton setImage:[[UIImage imageNamed:@"icon_popup_cancel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cancelButton];
    
    //显示更新
    [self showWithAlert:bgView];
}

/** 更新按钮点击事件 跳转AppStore更新 */
- (void)updateVersion
{
//    NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@", APP_ID];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}


#pragma mark -------- 处理点击事件 -------------------

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    if(self.delegate){
        [self dismissAlert];
        [self.delegate clickWithImageBg:_popup];
    }
}

/** 取消按钮点击事件 */
- (void)cancelAction
{
    [self dismissAlert];
}

/**
 添加Alert入场动画
 @param alert 添加动画的View
 */
- (void)showWithAlert:(UIView*)alert{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = SELAnimationTimeInterval;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [alert.layer addAnimation:animation forKey:nil];
}


/** 添加Alert出场动画 */
- (void)dismissAlert{
    
    [UIView animateWithDuration:SELAnimationTimeInterval animations:^{
        self.transform = (CGAffineTransformMakeScale(1.5, 1.5));
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
    
}

/**
 计算字符串高度
 @param string 字符串
 @param font 字体大小
 @param maxSize 最大Size
 @return 计算得到的Size
 */
- (CGSize)_sizeofString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize
{
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
}

@end

