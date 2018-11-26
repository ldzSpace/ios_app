//
//  PersonPageController.m
//  全送超人
//
//  Created by admin on 2018/11/6.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "PersonPageController.h"
#import "FeedbackController.h"
#import "FontAndColorMacros.h"
#import "RootNavigationController.h"
#import "LoginViewController.h"
#import "UtilsMacros.h"
#import "SettingViewController.h"
#import "ConfigModle.h"
#import "WebViewController.h"
#import "UserManager.h"
#import "BrowserHistoryViewController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface PersonPageController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *_headerImg;
    UILabel *_nameLabel;
    
}
@property(nonatomic,strong)UIView *backgroundImgV;
@property(nonatomic,assign)float backImgHeight;
@property(nonatomic,assign)float backImgWidth;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)SettingViewController * settingVC;
@property(nonatomic,strong)LoginViewController * loginVC;
@end


@implementation PersonPageController

@synthesize tableView=_tableView;

- (void)viewWillAppear:(BOOL)animated{
      [super viewWillAppear:animated];
    if(_nameLabel && userManager.curUserInfo && userManager.curUserInfo.telephone){
        _nameLabel.text = userManager.curUserInfo.telephone;
    } else {
        _nameLabel.text = @"登录 / 注册";
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self backImageView];
    [self layoutTableView];
}



-(void)backImageView{
    _backgroundImgV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 180.5)];
    _backgroundImgV.backgroundColor = [UIColor colorWithRed:33.0/255 green:91.0/255 blue:1.0 alpha:1.0];
    _backgroundImgV.userInteractionEnabled=YES;
    [self.view addSubview:_backgroundImgV];
    _backImgHeight=_backgroundImgV.frame.size.height;
    _backImgWidth=_backgroundImgV.frame.size.width;
}

-(void)layoutTableView
{
    if (!_myTableView) {
        _myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
        _myTableView.backgroundColor=CViewBgColor;
        _myTableView.showsVerticalScrollIndicator=NO;
        _myTableView.dataSource=self;
        _myTableView.delegate=self;
        _myTableView.rowHeight = 50;
        [self.view addSubview:_myTableView];
    }
    [_myTableView setTableHeaderView:[self headImageView]];
    _loginVC = [[LoginViewController alloc]init];

    self.isHidenNaviBar =YES;
}

-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView=[[UIImageView alloc] init];
        _headImageView.frame=CGRectMake(0, 64, WIDTH, 185.5);
        _headImageView.backgroundColor = CNavBgColor;
        _headImageView.userInteractionEnabled = YES;
        _headerImg=[[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/2-38.5, 80, 77, 77)];
        _headerImg.center=CGPointMake(WIDTH/2, 78.5);
        [_headerImg setImage:[UIImage imageNamed:@"icon_user_defaultheader"]];
        [_headerImg.layer setMasksToBounds:YES];
        [_headerImg.layer setCornerRadius:37.5];
        _headerImg.backgroundColor=[UIColor whiteColor];
        _headerImg.userInteractionEnabled=YES;
        UITapGestureRecognizer *header_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(header_tap_Click:)];
        [_headerImg addGestureRecognizer:header_tap];
        [_headImageView addSubview:_headerImg];
        
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(147, 130, 150, 20)];
        _nameLabel.center = CGPointMake(WIDTH/2, 144);
    
        _nameLabel.font = [UIFont systemFontOfSize:18];
        _nameLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *nick_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nick_tap_Click:)];
        [_nameLabel addGestureRecognizer:nick_tap];
        _nameLabel.textColor=[UIColor whiteColor];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        if(_nameLabel && userManager.loadUserInfo && userManager.curUserInfo.telephone){
            _nameLabel.text = userManager.curUserInfo.telephone;
        }else{
            _nameLabel.text = @"登录 / 注册";
        }
        [_headImageView addSubview:_nameLabel];
    }
    return _headImageView;
}

//头像的点击事件
-(void)header_tap_Click:(UITapGestureRecognizer *)tap
{
    NSLog(@"头像");
}
//昵称的点击事件
-(void)nick_tap_Click:(UIButton *)item
{
    [self.navigationController presentViewController:_loginVC  animated:NO completion:nil];
}


#pragma mark ---- UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"formCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"formCell"];
        cell.textLabel.text = @"monalisa";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSInteger section = indexPath.section;
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    NSInteger row = indexPath.row;
    cell.indentationLevel = 0;
    switch (section) {
        case 0:
            if (row == 0)
            {
                cell.textLabel.text = @"我浏览的产品";
            }
            break;
        case 1:
            if (row == 0)
            {
                cell.textLabel.text = @"帮助中心";
            }
            else if (row == 1)
            {
                cell.textLabel.text = @"意见反馈";
            }
            break;
        case 2:
            if (row == 0)
            {
                cell.textLabel.text = @"系统设置";
            }
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
    NSLog(@"section = %d ,row = %d",section, row);
    id  pushView;
    if(section == 0){
        if(![userManager loadUserInfo]){
            pushView = [[LoginViewController alloc]init];
        } else {
            pushView = [[BrowserHistoryViewController alloc] init];
        }
    }else if(section == 1){
        if(row == 0){
            pushView = [[WebViewController alloc] initWithUrl:configInstance.helpUrl];
        } else {
            if(![userManager loadUserInfo]){
                pushView = [[LoginViewController alloc]init];
            } else {
               pushView = [[FeedbackController alloc] init];
            }
        }
    }else if(section == 2){
        pushView = [[SettingViewController alloc] init];
    }
     [self.navigationController pushViewController:pushView animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffsety = scrollView.contentOffset.y;
    
    if (contentOffsety<0) {
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight-contentOffsety;
        rect.size.width = _backImgWidth* (_backImgHeight-contentOffsety)/_backImgHeight;
        rect.origin.x =  -(rect.size.width-_backImgWidth)/2;
        rect.origin.y = 0;
        _backgroundImgV.frame = rect;
    }else{
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight;
        rect.size.width = _backImgWidth;
        rect.origin.x = 0;
        rect.origin.y = -contentOffsety;
        _backgroundImgV.frame = rect;
    }
}

@end
