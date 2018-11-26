//
//  ProductBaseInfoCell.m
//  全送超人
//
//  Created by admin on 2018/11/13.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "ProductBaseInfoCell.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "ProductModel.h"
@interface ProductBaseInfoCell()<UITextFieldDelegate>

@property (strong, nonatomic) UILabel * dayRate;
@property (strong, nonatomic) UILabel *amountRange;
@property (strong, nonatomic) UILabel *timeRange;

@end

@implementation ProductBaseInfoCell


/**
 *  构造方法(在初始化对象的时候会调用)
 *  一般在这个方法中添加需要显示的子控件
 */
- (id)init
{
    self = [super init];
    if (self) {
            _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 0)];
            _infoView.backgroundColor = [UIColor whiteColor];
            CGFloat MaginX = 15;
            // 2.创建主label
            UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MaginX, MaginX, 120, 20)];
            titleLabel.font = [UIFont systemFontOfSize:18];
            titleLabel.textColor = CNavBgColor;
            titleLabel.text = @"基本信息";
            [_infoView addSubview:titleLabel];
            
            
            //创建额度数据
            _dayRate = [[UILabel alloc] initWithFrame:CGRectMake(MaginX, MaginX+30, 120, 20)];
            _dayRate.font = [UIFont boldSystemFontOfSize:17];
            _dayRate.adjustsFontSizeToFitWidth=YES;
            _dayRate.textColor = [UIColor blackColor];
            [_infoView addSubview:_dayRate];
            
            //创建额度
            UILabel *dayRateTitle = [[UILabel alloc] initWithFrame:CGRectMake(MaginX, MaginX+60, 120, 20)];
            dayRateTitle.font = LCMainFont;
            dayRateTitle.adjustsFontSizeToFitWidth=YES;
            dayRateTitle.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
            dayRateTitle.text = @"日利率（%）";
            [_infoView addSubview:dayRateTitle];
            
            // 分割线
            UIView *splitLine = [[UIView alloc] initWithFrame:CGRectMake(120, MaginX+30 ,1, 50)];
            splitLine.backgroundColor = [UIColor colorWithRed:232.0/255 green:232.0/255 blue:232.0/255 alpha:1.0];
            splitLine.userInteractionEnabled = YES;
            [_infoView addSubview:splitLine];
            
            //创建额度
            _amountRange = [[UILabel alloc] initWithFrame:CGRectMake(150,MaginX+ 30, KScreenWidth - 150, 20)];
            _amountRange.font =LCSubFont;
            _amountRange.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
            [_infoView addSubview:_amountRange];
            
            //创建期限
            _timeRange = [[UILabel alloc] initWithFrame:CGRectMake(150,MaginX+ 60, KScreenWidth - 150, 20)];
            _timeRange.font = LCSubFont;
            _timeRange.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
            [_infoView addSubview:_timeRange];
            
            
            UILabel * monenyTitle = [[UILabel alloc] initWithFrame:CGRectMake(MaginX, MaginX+100, KScreenWidth - 150, 20)];
            monenyTitle.font = LCSubFont;
            monenyTitle.adjustsFontSizeToFitWidth=YES;
            monenyTitle.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
            monenyTitle.text = @"贷款金额 (元）";
            [_infoView addSubview:monenyTitle];
            
            
            UILabel *timeTitle = [[UILabel alloc] initWithFrame:CGRectMake(150, MaginX+100, 120, 20)];
            timeTitle.font = LCSubFont;
            timeTitle.adjustsFontSizeToFitWidth=YES;
            timeTitle.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
            timeTitle.text = @"时间（天）";
            [_infoView addSubview:timeTitle];
            
            
            UILabel * interestTitle = [[UILabel alloc] initWithFrame:CGRectMake(240,MaginX+ 100, 120, 20)];
            interestTitle.font = LCSubFont;
            interestTitle.adjustsFontSizeToFitWidth=YES;
            interestTitle.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
            interestTitle.text = @"预估利息（元）";
            [_infoView addSubview:interestTitle];
            
            //贷款金额
            _moneyInput = [[UITextField alloc] initWithFrame:CGRectMake(MaginX, MaginX+140, 100, 20)];
            _moneyInput.font = [UIFont boldSystemFontOfSize:24];
            _moneyInput.rightViewMode = UITextFieldViewModeAlways;
            _moneyInput.userInteractionEnabled=YES;
            UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 21, 100, 1)];
            line.backgroundColor=[UIColor lightGrayColor];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
            imageView.image = [UIImage imageNamed:@"icon_edit_money"];
            _moneyInput.rightView = imageView;
            [_moneyInput addSubview:line];
            [_infoView addSubview:_moneyInput];
            
            _dayInput = [[UITextField alloc] initWithFrame:CGRectMake(150, MaginX+140, 60, 20)];
            _dayInput.font =  [UIFont boldSystemFontOfSize:24];
            _dayInput.rightViewMode = UITextFieldViewModeAlways;
            UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
            imageView2.image = [UIImage imageNamed:@"icon_edit_money"];
            _dayInput.rightView = imageView2;
            UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(0, 21, 60, 1)];
            line2.backgroundColor=[UIColor lightGrayColor];
            [_dayInput addSubview:line2];
            [_infoView addSubview:_dayInput];
            
            _interstLabel = [[UILabel alloc] initWithFrame:CGRectMake(240,MaginX+ 140, 120, 20)];
            _interstLabel.font =  [UIFont boldSystemFontOfSize:24];
            _interstLabel.adjustsFontSizeToFitWidth=YES;
            _interstLabel.textColor = [UIColor blackColor];
            [_infoView addSubview:_interstLabel];

    }
    return self;
}



-(void)setInfoData:(ProductModel*)product{
    
    NSLog(@"利率%f",product.dayRate);
    _dayRate.text = [NSString stringWithFormat:@"%0.3f", product.dayRate];
    _amountRange.text = [NSString stringWithFormat:@"%@%d%@%d%@",@"额度范围: ",product.minAmount,@" ~ ", product.maxAmount,@"万"];
    _timeRange.text = [NSString stringWithFormat:@"%@%d%@%d%@",@"期限范围: ",product.termMin,@" ~ ",product.termMax, @"天"];
    _moneyInput.text = [NSString stringWithFormat:@"%d", product.minAmount];
    _dayInput.text = [NSString stringWithFormat:@"%d", product.termMin];
    _interstLabel.text = [NSString stringWithFormat:@"%d", product.minAmount/product.termMin];
}
@end
