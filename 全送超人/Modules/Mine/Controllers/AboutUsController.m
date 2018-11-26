//
//  AboutUsController.m
//  Setting
//
//  Created by cosmos on 2018/11/15.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import "AboutUsController.h"
#import <Masonry/Masonry.h>

static const CGFloat kLgnWH = 90.f;
static const CGFloat kLgnTop = 140.f;
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface AboutUsController ()
@property (nonatomic, strong) UIImageView *logoImgView;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UILabel *partnerLabel;
@end

@implementation AboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - About UI
- (void)setupUI{
    
    /** 设置self.view */
    NSDictionary *titleTextAttDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil, NSShadowAttributeName, nil];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 30, 40);
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    [self.navigationItem setLeftBarButtonItem: leftBarButtonItem];
    [self.navigationController.navigationBar setTitleTextAttributes:titleTextAttDict];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.view.backgroundColor = [UIColor colorWithRed:241.0/255 green:242.0/255 blue:246.0/255 alpha:1.0];
    [self.navigationItem setTitle:@"关于我们"];
    
    self.view.backgroundColor = [UIColor colorWithRed:241.0/255 green:242.0/255 blue:246.0/255 alpha:1.0];
    
    NSString *imagePath=[[NSBundle mainBundle] pathForResource:@"登录全送超人" ofType:@"png"];
    UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
    NSLog(@"%@",image);
    
    /** 设置logo */
    self.logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"登录全送超人"]];
    [self.view addSubview:self.logoImgView];

    self.versionLabel = [[UILabel alloc] init];
    self.versionLabel.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
    self.versionLabel.font = [UIFont systemFontOfSize:12];
    self.versionLabel.adjustsFontSizeToFitWidth = NO;
    NSString *version = [NSString stringWithFormat:@"版本信息：V%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    self.versionLabel.text = version;
    self.versionLabel.textAlignment = NSTextAlignmentCenter;
    NSLog(@"self.versionLabel.text = %@\n", self.versionLabel.text);
    [self.view addSubview:self.versionLabel];
    
    self.partnerLabel = [[UILabel alloc] init];
    self.partnerLabel.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
    self.versionLabel.adjustsFontSizeToFitWidth = NO;
    self.partnerLabel.font = [UIFont systemFontOfSize:12];
    self.partnerLabel.text = @"商务合作：daikuanshop@163.com";
    self.partnerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.partnerLabel];
    /** 布局 */
    [self make_layout];
}

- (void)make_layout{

    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kLgnWH);
        make.height.mas_equalTo(kLgnWH);
        make.top.mas_equalTo(self.view.mas_top).with.offset(kLgnTop);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.partnerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH);
        make.height.mas_equalTo(kLgnWH);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-10);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH);
        make.height.mas_equalTo(kLgnWH);
        make.bottom.mas_equalTo(self.partnerLabel.mas_bottom).with.offset(-30);
        make.centerX.mas_equalTo(self.view);
    }];
}


-(void)backBtnClicked:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
