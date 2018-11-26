//
//  LoansCell1.m
//  dky
//
//  Created by cosmos on 2018/11/8.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import "LoansCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ProductModel.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "NSString+URL.h"

@interface LoansCell ()
@property (nonatomic, weak) ProductModel *data;
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

@implementation LoansCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // NSLog(@"cellForRowAtIndexPath");
    static NSString *identifier = @"LoansCell1";
    // 1.缓存中取
    LoansCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (!cell)
    {
        cell = [[LoansCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

/**
 *  构造方法(在初始化对象的时候会调用)
 *  一般在这个方法中添加需要显示的子控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 0.创建背景
        UIView * view =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 140)];
        view.backgroundColor = [UIColor whiteColor];
        
        // 1.创建图标
        UIImageView *iconView = [[UIImageView alloc] init];
        self.iconView = iconView;
        [view addSubview:iconView];
        
        // 2.创建主label
        UILabel *mainLabel = [[UILabel alloc] init];
        mainLabel.font = LCMainFont;
        mainLabel.adjustsFontSizeToFitWidth=YES;
        mainLabel.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        self.mainLabel = mainLabel;
        [view addSubview:mainLabel];
        
        // 3.创建副label
        UILabel *subLabel = [[UILabel alloc] init];
        subLabel.font = LCSubFont;
        subLabel.adjustsFontSizeToFitWidth=YES;
        subLabel.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
        self.subLabel = subLabel;
        [view addSubview:subLabel];
        
        // 4.创建申请人数label
        UILabel *applyLabel = [[UILabel alloc] init];
        applyLabel.font = LCApplyFont;
        applyLabel.adjustsFontSizeToFitWidth=YES;
        applyLabel.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
        self.applyLabel = applyLabel;
        [view addSubview:applyLabel];
        
        // 5.创建按钮
        UIButton *applyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        applyButton.titleLabel.font = LCApplyButtonFont;
        applyButton.backgroundColor = [UIColor colorWithRed:33.0/255 green:91.0/255 blue:1 alpha:1.0];
        applyButton.titleLabel.textColor = [UIColor whiteColor];
        [applyButton setTitle:@"一键申请" forState:UIControlStateNormal];
        [applyButton setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0] forState:UIControlStateNormal];
        applyButton.layer.cornerRadius = 5.0;
        [applyButton addTarget:self action:@selector(allpyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.applyButton = applyButton;
        [view addSubview:applyButton];
        
        //创建分割线
        UIView *splitLine = [[UIView alloc] initWithFrame:CGRectMake(15, 74, KScreenWidth-30, 1)];
        splitLine.backgroundColor = [UIColor colorWithRed:232.0/255 green:232.0/255 blue:232.0/255 alpha:1.0];
        splitLine.userInteractionEnabled = YES;
        [view addSubview:splitLine];
        
        //创建额度数据
        UILabel *amountRange = [[UILabel alloc] init];
        amountRange.font = LCApplyFont;
        amountRange.adjustsFontSizeToFitWidth=YES;
        amountRange.textColor = [UIColor colorWithRed:33.0/255 green:91.0/255 blue:1 alpha:1.0];
        self.amountRange = amountRange;
        [view addSubview:amountRange];
        
        //创建额度
        UILabel *amount = [[UILabel alloc] init];
        amount.font = LCApplyFont;
        amount.adjustsFontSizeToFitWidth=YES;
        amount.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
        amount.text = @"额度";
        self.amount = amount;
        [view addSubview:amount];
        
        //创建利率数据
        UILabel *rateNum = [[UILabel alloc] init];
        rateNum.font = LCApplyFont;
        rateNum.adjustsFontSizeToFitWidth=YES;
        rateNum.textColor = [UIColor colorWithRed:33.0/255 green:91.0/255 blue:1 alpha:1.0];
        self.rateNum = rateNum;
        [view addSubview:rateNum];
        
        //创建利率
        UILabel *rate = [[UILabel alloc] init];
        rate.font = LCApplyFont;
        rate.adjustsFontSizeToFitWidth=YES;
        rate.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
        self.rate = rate;
        [view addSubview:rate];
        
        //创建速度数字
        UILabel *speedNum = [[UILabel alloc] init];
        speedNum.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        speedNum.adjustsFontSizeToFitWidth=YES;
        speedNum.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        self.speedNum = speedNum;
        [view addSubview:speedNum];
        
        //创建速度
        UILabel *speed = [[UILabel alloc] init];
        speed.font = LCApplyFont;
        speed.adjustsFontSizeToFitWidth=YES;
        speed.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
        speed.text = @"下款速度";
        self.speed = speed;
        [view addSubview:speed];
        
        //创建通过率数字
        UILabel *passingRateNum = [[UILabel alloc] init];
        passingRateNum.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        passingRateNum.adjustsFontSizeToFitWidth=YES;
        passingRateNum.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        self.passingRateNum = passingRateNum;
        [view addSubview:passingRateNum];

        //创建通过率
        UILabel *passingRate = [[UILabel alloc] init];
        passingRate.font = LCApplyFont;
        passingRate.adjustsFontSizeToFitWidth=YES;
        passingRate.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
        passingRate.text = @"通过率";
        self.passingRate = passingRate;
        [view addSubview:passingRate];
        
        UITapGestureRecognizer * gestureRecoginer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewClick:)];
        [view addGestureRecognizer:gestureRecoginer];
        self.contentView.backgroundColor = CViewBgColor;
        [self.contentView addSubview:view];
      
    }
    return self;
}

#pragma mark ---- 回调函数 ----------------------
- (void)allpyButtonClick:(UIButton *) button
{
    if(_data){
        [self.delegate clickWithLoadBtn:_data];
    }
}

- (void)bgViewClick:(UIView*)sender
{
    if(_data){
        [self.delegate clickWithLoadView:_data];
    }
}


#pragma mark -------- 设置数据 -----------
- (void)setData:(ProductModel*)data
{
    if (!_lcFrame)
    {
        _lcFrame = [[LoansCellFrame alloc] init];
    }
    _data = data;
    [self.lcFrame setProductListData:data];

    // 1.给子控件赋值数据
    [self settingData:self.lcFrame.data];
    // 2.设置frame
    [self settingFrame];
}

/**
 *  设置子控件的数据
 */
- (void)settingData:(ProductModel *)data
{
    // 设置头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[data.logo URLEncodedString]] placeholderImage:[UIImage imageNamed:@"icon_placeholder"]];
    // 设置主label
    self.mainLabel.text = data.name;
    // 设置副label
    self.subLabel.text = data.subtitle;
    // 设置applyLabel
    if (data.applyPersonCount < 10000)
    {
        self.applyLabel.text = [NSString stringWithFormat:@"%d万人申请", data.applyPersonCount];
    }
    else
    {
        self.applyLabel.text = [NSString stringWithFormat:@"%.1f万人申请", data.applyPersonCount/10000.0];
    }
    
    NSString *sMinA = @"";
    if (data.minAmount%10000 != 0)
    {
        sMinA = [NSString stringWithFormat:@"%.1f", data.minAmount/10000.0];
    }
    else
    {
        sMinA = [NSString stringWithFormat:@"%d", data.minAmount/10000];
    }
    NSString *sMaxA = @"";
    if (data.minAmount%10000 != 0)
    {
        sMaxA = [NSString stringWithFormat:@"%.1f", data.maxAmount/10000.0];
    }
    else
    {
        sMaxA = [NSString stringWithFormat:@"%d", data.maxAmount/10000];
    }
    
    self.amountRange.text = [NSString stringWithFormat:@"%@-%@万", sMinA, sMaxA];
    if (data.rateUnit == 1)
    {
        self.rateNum.text = [NSString stringWithFormat:@"%.3f", data.dayRate];
        self.rate.text = @"日利率（%）";
    }
    else if (data.rateUnit == 2)
    {
        self.rateNum.text = [NSString stringWithFormat:@"%.3f", data.monthRate];
        self.rate.text = @"月利率（%）";
    }
    
    self.speedNum.text = data.speed;
    self.passingRateNum.text = [NSString stringWithFormat:@"%d%%", data.passingRate];
}

/**
 *  设置子控件的frame
 */
- (void)settingFrame
{
    self.iconView.frame = self.lcFrame.iconF;
    self.mainLabel.frame = self.lcFrame.mainLabelF;
    self.subLabel.frame = self.lcFrame.subLabelF;
    self.applyLabel.frame = self.lcFrame.applyLabelF;
    self.applyButton.frame = self.lcFrame.applyButtonF;
    self.splitLine.frame = self.lcFrame.splitLineF;
    self.amountRange.frame = self.lcFrame.amountRangeF;
    self.amount.frame = self.lcFrame.amountF;
    self.rateNum.frame = self.lcFrame.rateNumF;
    self.rate.frame = self.lcFrame.rateF;
    self.speedNum.frame = self.lcFrame.speedNumF;
    self.speed.frame = self.lcFrame.speedF;
    self.passingRateNum.frame = self.lcFrame.passingRateNumF;
    self.passingRate.frame = self.lcFrame.passingRateF;
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
