//
//  ProductCell.m
//  全送超人
//
//  Created by admin on 2018/11/9.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "ProductDetailCell.h"
#import "UtilsMacros.h"
#import "ProductModel.h"
#import "ProductDetailCellFrame.h"
#import "NSString+URL.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "KMTagListView.h"

@interface ProductDetailCell ()
@property (nonatomic, strong) ProductDetailCellFrame *tframe;
@property (nonatomic, weak) ProductModel *data;
@property (nonatomic, strong) UIView * view;
@property (nonatomic, strong) KMTagListView * tagView;
@property (nonatomic, weak) UIImageView *iconView; //iCon
@property (nonatomic, weak) UILabel *mainLabel; //主标题
@property (nonatomic, weak) UILabel *subLabel; //副标题
@property (nonatomic, weak) UILabel *applyLabel; //申请人数
@property (nonatomic, weak) UIButton *applyButton; //申请按钮
@property (nonatomic, weak) UIView *splitLine; //分割线
@property (nonatomic, weak) UILabel *amountRange; //额度数据
@property (nonatomic, weak) UILabel *amount; //额度
@property (nonatomic, weak) UILabel *rateNum; //利率数字
@property (nonatomic, weak) UILabel *rate; //利率
@property (nonatomic, weak) UILabel *speedNum; //速度数字
@property (nonatomic, weak) UILabel *speed; //speed
@property (nonatomic, weak) UILabel *passingRateNum; //通过率数字
@property (nonatomic, weak) UILabel *passingRate; //通过率

@end

@implementation ProductDetailCell

/**
 *  构造方法(在初始化对象的时候会调用)
 *  一般在这个方法中添加需要显示的子控件
 */
- (id)init
{
    self = [super init];
    if (self) {
        // 0.创建背景
        _view =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 160)];
        _view.backgroundColor = [UIColor whiteColor];
        
        // 1.创建图标
        UIImageView *iconView = [[UIImageView alloc] init];
        self.iconView = iconView;
        [_view addSubview:iconView];
        
        // 2.创建主label
        UILabel *mainLabel = [[UILabel alloc] init];
        mainLabel.font = LCMainFont;
        mainLabel.adjustsFontSizeToFitWidth=YES;
        mainLabel.textColor = [UIColor blackColor];
        self.mainLabel = mainLabel;
        [_view addSubview:mainLabel];
        
        // 3.创建副label
        UILabel *subLabel = [[UILabel alloc] init];
        subLabel.font = LCSubFont;
        subLabel.adjustsFontSizeToFitWidth=YES;
        subLabel.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
        self.subLabel = subLabel;
        [_view addSubview:subLabel];
        
        // 4.创建次级label
        UILabel *applyLabel = [[UILabel alloc] init];
        applyLabel.font = LCApplyFont;
        applyLabel.adjustsFontSizeToFitWidth=YES;
        applyLabel.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
        self.applyLabel = applyLabel;
        [_view addSubview:applyLabel];
        
        
        //创建分割线
        UIView *splitLine = [[UIView alloc] initWithFrame:CGRectMake(0, 110, KScreenWidth, 1)];
        splitLine.backgroundColor = [UIColor colorWithRed:232.0/255 green:232.0/255 blue:232.0/255 alpha:1.0];
        splitLine.userInteractionEnabled = YES;
        [_view addSubview:splitLine];
        
        // tags
        _tagView = [[KMTagListView alloc]initWithFrame:CGRectZero];
        _tagView.delegate_ = self;

        [_view addSubview:_tagView];
        [self.contentView addSubview:_view];
    }
    return self;
}

#pragma mark -------- 设置数据 -----------
- (void)setProductData:(ProductModel*)data
{
    if (!_tframe)
    {
        _tframe = [ProductDetailCellFrame new];
       
    }
    //_data = data;
    [_tframe setProductListData:data];
    
    // 1.给子控件赋值数据
    [self settingData:data];
    // 2.设置frame
    [self settingFrame];
}

/**
 *  设置子控件的数据
 */
- (void)settingData:(ProductModel *)pdata
{
    // 设置头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[pdata.logo URLEncodedString]] placeholderImage:[UIImage imageNamed:@"icon_placeholder"]];
    // 设置主label
    self.mainLabel.text = pdata.name;
    // 设置副label
    self.subLabel.text = pdata.subtitle;
    // 设置applyLabel
    if (pdata.applyPersonCount < 10000)
    {
        self.applyLabel.text = [NSString stringWithFormat:@"%d万人申请 · %@放款", pdata.applyPersonCount, pdata.speed];
    }
    else
    {
        self.applyLabel.text = [NSString stringWithFormat:@"%.1f万人申请 · %@放款", pdata.applyPersonCount/10000.0, pdata.speed];;
    }
    
    [_tagView setupSubViewsWithTitles:pdata.tags TagBgColor:[UIColor whiteColor] TagTextColor:[UIColor orangeColor] BordColor:[UIColor orangeColor] BorderCornus:4 BorderSize:1 TextSize:14];
    CGRect rect = _tagView.frame;
    rect.size.height = _tagView.contentSize.height;
    _tagView.frame = rect;
    
}

/**
 *  设置子控件的frame
 */
- (void)settingFrame
{
    self.iconView.frame = _tframe.iconF;
    self.mainLabel.frame = _tframe.mainLabelF;
    self.tagView.frame = _tframe.tags;
    self.subLabel.frame = _tframe.subLabelF;
    self.applyLabel.frame = _tframe.applyLabelF;
    self.applyButton.frame = _tframe.applyButtonF;
    self.splitLine.frame = _tframe.splitLineF;
    self.amountRange.frame = _tframe.amountRangeF;
    self.amount.frame = _tframe.amountF;
    self.rateNum.frame = _tframe.rateNumF;
    self.rate.frame = _tframe.rateF;
    self.speedNum.frame = _tframe.speedNumF;
    self.speed.frame = _tframe.speedF;
    self.passingRateNum.frame = _tframe.passingRateNumF;
    self.passingRate.frame = _tframe.passingRateF;
}


@end
