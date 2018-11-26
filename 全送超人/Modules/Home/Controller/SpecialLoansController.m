//
//  SpecialLoansController.m
//  dky
//
//  Created by cosmos on 2018/11/7.
//  Copyright © 2018年 cosmos. All rights reserved.
//
#import <SDWebImage/UIImageView+WebCache.h>
#import "SpecialLoansController.h"
#import "LoansCell.h"
#import "UtilsMacros.h"
#import "WebViewController.h"
#import "DetailPageController.h"
#import "FontAndColorMacros.h"
#import "CateModel.h"


@interface SpecialLoansController ()<UITableViewDataSource,UITableViewDelegate,ProductListLogicDelegate>

@property(nonatomic,strong)UITableView * kTableView;
@property(nonatomic,strong)ProductListLogic *logic;
@property(nonatomic,strong)CateModel *cate;
@property(nonatomic,strong)UIImageView *headImageView;

@end

@implementation SpecialLoansController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutTableView];
    

    NSDictionary *titleTextAttDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil, NSShadowAttributeName, nil];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 20, 40);
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    
    [self.navigationItem setLeftBarButtonItem: leftBarButtonItem];
    [self.navigationController.navigationBar setTitleTextAttributes:titleTextAttDict];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
     [self.navigationItem setTitle:_cate.name];
}

-(id)initWithCateID:(CateModel*)cate
{
    self = [super init];
    if (self)
    {
        _logic = [ProductListLogic new];
        _logic.delegate = self;
        _cate = cate;
        [_logic loadData:cate._id Min:0 Max:0];
    }
    return self;
}

-(void)layoutTableView
{
    if (!_kTableView) {
        _kTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 63, KScreenWidth, KScreenHeight - 75) style:UITableViewStyleGrouped];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        //默认【上拉加载】
        //self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
        _kTableView.backgroundColor=[UIColor clearColor];
        _kTableView.showsVerticalScrollIndicator = NO;
        _kTableView.dataSource = self;
        _kTableView.delegate = self;
        _kTableView.rowHeight = 133.5;
        [self.view addSubview:_kTableView];
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    [_kTableView setTableHeaderView:[self headImageView]];
}

-(UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView=[[UIImageView alloc] init];
        _headImageView.frame=CGRectMake(0, 0, KScreenWidth, 150);
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:_cate.bannerImgSrc] placeholderImage:[UIImage imageNamed:@"icon_placeholer"]];
    }
    return _headImageView;
}

-(void)refresh
{
    [_logic loadData:_cate._id Min:0 Max:0];
}

-(void)loadMore
{
    //如果有分页
}

-(void)requestDataCompleted{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
    [UIView performWithoutAnimation:^{
        [self.kTableView reloadData];
    }];
    
}

#pragma mark ------ 列表回调----------
- (void)clickWithLoadBtn:(ProductModel*)product{
    id pushView = [[WebViewController alloc] initWithUrl:product.url];
    [self.navigationController pushViewController:pushView animated:NO];
}

- (void)clickWithLoadView:(ProductModel*)product{
    id pushView = [[DetailPageController alloc] initWithProductID:product._id];
    [self.navigationController pushViewController:pushView animated:NO];
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
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _logic.productList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoansCell *cell = [LoansCell cellWithTableView:tableView];
    cell.delegate = self;
    NSInteger section = indexPath.section;
    [cell setData:_logic.productList[section]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 5)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenHeight, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


@end
