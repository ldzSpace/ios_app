//
//  BrowserHistoryViewController.m
//  全送超人
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "BrowserHistoryViewController.h"
#import "BrowerHistoryLogic.h"
#import "LoansCell.h"
#import "UtilsMacros.h"
#import "MJRefresh.h"
#import "FontAndColorMacros.h"
#import "WebViewController.h"
#import "DetailPageController.h"

@interface BrowserHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BrowerHistoryLogic * logic;
@end

@implementation BrowserHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self.navigationItem setTitle:@"历史记录"];
    
    _logic = [[BrowerHistoryLogic alloc]init];
    _logic.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 133.5;
    self.tableView.frame = CGRectMake(0, kTopHeight , KScreenWidth, KScreenHeight - kTopHeight);
    [self.view addSubview: self.tableView];
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark ------ 今日推荐回调----------
- (void)clickWithLoadBtn:(ProductModel*)product{
    id pushView = [[WebViewController alloc] initWithUrl:product.url];
    [self.navigationController pushViewController:pushView animated:NO];
}

- (void)clickWithLoadView:(ProductModel*)product{
    id pushView = [[DetailPageController alloc] initWithProductID:product._id];
    [self.navigationController pushViewController:pushView animated:NO];
}


#pragma mark ————— 下拉刷新 —————
-(void)headerRereshing{
    [self removeAllData];
    [_logic loadData];
}

#pragma mark ------ 清理数据 ----------
-(void) removeAllData{
    [_logic.productArray removeAllObjects];
}


#pragma mark ————— 数据拉取完成 渲染页面 —————
-(void)requestDataCompleted{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
    [UIView performWithoutAnimation:^{
        [self.tableView reloadData];
    }];
}


-(void)backBtnClicked:(UIButton*)sender
{
    NSDictionary *titleTextAttDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil, NSShadowAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:titleTextAttDict];
    [self.navigationController.navigationBar setBarTintColor:CNavBgColor];
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark ---- UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _logic.productArray.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoansCell *cell = [LoansCell cellWithTableView:tableView];
    NSInteger row = indexPath.row;
    cell.delegate = self;
    [cell setData:_logic.productArray[row]];
    return cell;
}


@end
