//
//  ViewController.m
//  UserDetail
//
//  Created by Rainy on 16/10/8.
//  Copyright © 2016年 Rainy. All rights reserved.
//



#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


#import "SettingViewController.h"
#import "AboutUsController.h"
#import "UserManager.h"
#import <Masonry.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "MBProgressHUD+XY.h"
#import "FontAndColorMacros.h"
#import "ConfigModle.h"

static const CGFloat kMaxW = 345.f;
static const CGFloat kBtnH = 50.f;

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)UIButton *logoutBtn;
//@property(nonatomic,strong)NSString *number;
@property(nonatomic,strong)NSString *serviceName;
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) AboutUsController *auc;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_serviceName)
    {
        _serviceName = [[NSBundle mainBundle] bundleIdentifier];
    }
    
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
    [self.navigationItem setTitle:@"系统设置"];
    [self layoutTableView];
    [self setButton];
    [self make_layout];
}

-(void)setButton
{
    if ([userManager loadUserInfo])
    {
        if (!_logoutBtn) {
            _logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        }
        self.logoutBtn.layer.cornerRadius = 5.f;
        self.logoutBtn.layer.masksToBounds = YES;
        self.logoutBtn.backgroundColor = [UIColor colorWithRed:33.0/255 green:91.0/255 blue:1 alpha:1.0];
        self.logoutBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.logoutBtn addTarget:self action:@selector(logoutAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [self.view addSubview:self.logoutBtn];
    }
}

- (void)make_layout{
    [self.logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kMaxW);
        make.height.mas_equalTo(kBtnH);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(_myTableView.mas_bottom).with.offset(15);
    }];
}

- (void)logoutAction:(UIButton *)sender
{
    [userManager logout:^(BOOL success, NSString * _Nonnull des) {
        if (success) {
            NSLog(@"退出成功");
        }
        
    }];
    self.logoutBtn.hidden = YES;
}

-(void)layoutTableView
{
    
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, WIDTH, 220) style:UITableViewStyleGrouped];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.rowHeight = 50;
        _myTableView.scrollEnabled = NO;
        [self.view addSubview:_myTableView];
    }
}


-(void)backBtnClicked:(UIButton*)sender
{
    NSDictionary *titleTextAttDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil, NSShadowAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:titleTextAttDict];
    [self.navigationController.navigationBar setBarTintColor:CNavBgColor];
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

#pragma mark ---- UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingFormCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SettingFormCell"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];

    cell.textLabel.font = [UIFont systemFontOfSize:18];
    NSInteger row = indexPath.row;
    cell.indentationLevel = 0;
    switch (row) {
        case 0:
            cell.textLabel.text = @"评价";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 1:
            cell.textLabel.text = @"关于我们";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 2:
            cell.textLabel.text = @"微信订阅号";
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.detailTextLabel.text = configInstance.weixin;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            cell.detailTextLabel.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
            break;
        case 3:
            cell.textLabel.text = @"清除缓存";
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.detailTextLabel.text = @"0Mb";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            cell.detailTextLabel.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
            break;
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSLog(@"点击了 %ld, %ld", (long)section, (long)row);
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    switch (row) {
        case 0:
            
            break;
        case 1:
            _auc = [[AboutUsController alloc] init];
            [self.navigationController pushViewController:_auc animated:YES];
            break;
        case 2:
            [self hudAction:@"微信订阅号已复制"];
            pasteboard.string = @"daikuanshop";
            break;
        case 3:
            [self hudAction:@"清除了0Mb缓存"];
            break;
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 10)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)hudAction:(NSString*)str
{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    
    _HUD.labelText = str;
    _HUD.mode = MBProgressHUDModeText;
    
    [_HUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    }
       completionBlock:^{
           [_HUD removeFromSuperview];
           _HUD = nil;
       }];
}


@end
