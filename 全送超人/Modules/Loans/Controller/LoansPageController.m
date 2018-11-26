//
//  LoansTableController.m
//  dky
//
//  Created by cosmos on 2018/11/7.
//  Copyright © 2018年 cosmos. All rights reserved.
//
#import "LoansPageController.h"
#import "LoansCell.h"
#import "DOPDropDownMenu.h"
#import "UtilsMacros.h"
#import "ProductListArrays.h"
#import "WebViewController.h"
#import "DetailPageController.h"
#import "UserManager.h"
#import "LoginViewController.h"

@interface LoansPageController ()<UITableViewDataSource,UITableViewDelegate,ProductListLogicDelegate,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>

@property(nonatomic,strong)UIView *closeView;
@property(nonatomic,strong)UILabel *closeViewTitle;
@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)UITableView *mytableView;
@property(nonatomic,strong)ProductListLogic *logic;
@property (nonatomic, strong) NSMutableArray *amounts;
@property (nonatomic, strong) NSMutableArray *classify;
@property (nonatomic, weak) DOPDropDownMenu *menu;
@property (assign, nonatomic) unsigned long amountStatus;
@property (assign, nonatomic) unsigned long cateStatus;
@property (assign, nonatomic) BOOL firstBoot;
@end

@implementation LoansPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    _logic = [ProductListLogic new];
    _logic.delegate = self;
    _amountStatus = 0;
    _cateStatus = 0;
    _firstBoot = TRUE;
    [_logic loadData:@"0" Min:0 Max:0];
    [self layoutTableView];
}

-(void)setMenus
{
    _amounts = [[NSMutableArray alloc] init];
    _classify = [[NSMutableArray alloc] init];
    for (CateListData *cate in _logic.cateList)
    {
      
        [self.classify addObject:cate.name];
    }

    for (AmountListData *obj in _logic.amountList)
    {

        [self.amounts addObject:obj.txt];
    }
    
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 65) andHeight:40];
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    _menu = menu;
    [menu selectIndexPath:[DOPIndexPath indexPathWithCol:0 row:0 item:0]];
}

-(void)setCloseView
{
    _closeView = [[UIView alloc] initWithFrame:CGRectMake(0, 105, KScreenWidth, 30)];
    _closeView.backgroundColor = [UIColor colorWithRed:167.0/255 green:167.0/255 blue:167.0/255.0 alpha:1.0];
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont systemFontOfSize:14];
    title.adjustsFontSizeToFitWidth = YES;
    title.textColor = [UIColor whiteColor];
    title.text = @"申请5个产品，可大幅提高贷款成功率";
    title.textAlignment = NSTextAlignmentCenter;
    title.frame = CGRectMake(0, 0, KScreenWidth, 30);
    self.closeViewTitle = title;
    [_closeView addSubview:title];
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(KScreenWidth-30, 6.5, 17, 17);
    
    [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [cancelButton setImage:[UIImage imageNamed:@"cancelbutton.png"] forState:UIControlStateNormal];
    //[cancelButton setImageEdgeInsets:UIEdgeInsetsMake(4, 0, 4, 0)];
    cancelButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.cancelButton = cancelButton;
    [_closeView addSubview:cancelButton];
    
    [self.view addSubview:_closeView];
}

-(void)cancelButtonClick:(UIButton *) button
{
    _closeView.frame = CGRectMake(0, 0, 0, 0);
    
    CGFloat height = 30;
    _mytableView.frame = CGRectMake(_mytableView.frame.origin.x, _mytableView.frame.origin.y - height, _mytableView.frame.size.width, _mytableView.frame.size.height + height);
    _closeViewTitle.hidden = YES;
    _cancelButton.hidden = YES;
    [_closeView removeFromSuperview];
}


-(void)layoutTableView
{
    if (!_mytableView) {
        _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 145, KScreenWidth, KScreenHeight-185) style:UITableViewStyleGrouped];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        _mytableView.backgroundColor=[UIColor clearColor];
        _mytableView.showsVerticalScrollIndicator = NO;
        _mytableView.dataSource = self;
        _mytableView.delegate = self;
        _mytableView.rowHeight = 133.5;
        [self.view addSubview:_mytableView];
    }
}

- (void)menuReloadData
{
    [self.classify removeAllObjects];
    [self.amounts removeAllObjects];
    for (CateListData *cate in _logic.cateList)
    {
        [self.classify addObject:cate.name];
    }

    for (AmountListData *obj in _logic.amountList)
    {
        [self.amounts addObject:obj.txt];
    }
    [_menu reloadData];
}

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 2;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0)
    {
        return self.amounts.count;
    }else
    {
        return self.classify.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0)
    {
        return self.amounts[indexPath.row];
    }
    else
    {
        return self.classify[indexPath.row];
    }
    return nil;
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.item >= 0) {
        NSLog(@"点击了 x%ld - c%ld - v%ld 项目",indexPath.column,indexPath.row,indexPath.item);
    }else {
        NSLog(@"点击了 v%ld - d%ld 项目",indexPath.column,indexPath.row);
        if (indexPath.column == 0)
        {
            _amountStatus = indexPath.row;
        }
        if (indexPath.column == 1)
        {
            _cateStatus = indexPath.row;
        }
        
        [self refresh];
    }
}

-(void)refresh
{
    NSString *cateID = ((CateListData*)_logic.cateList[_cateStatus])._id;
    int min = ((AmountListData*)_logic.amountList[_amountStatus]).min;
    int max = ((AmountListData*)_logic.amountList[_amountStatus]).max;
    [_logic loadData:cateID Min:min Max:max];
}

-(void)loadMore
{
    //如果有分页
}

-(void)requestDataCompleted{
    [_mytableView.mj_footer endRefreshing];
    [_mytableView.mj_header endRefreshing];
    if (_firstBoot)
    {
        [self setMenus];
        [self setCloseView];
        _firstBoot = FALSE;
    }
    [UIView performWithoutAnimation:^{
        [_mytableView reloadData];
    }];
    
}

#pragma mark ------ 列表回调----------
- (void)clickWithLoadBtn:(ProductModel*)product{
    id pushView;
    if(![userManager loadUserInfo]){
        pushView = [[LoginViewController alloc]init];
    } else {
        pushView = [[WebViewController alloc] initWithUrl:product.url];
    }
    [self.navigationController pushViewController:pushView animated:NO];
}

- (void)clickWithLoadView:(ProductModel*)product{
    id pushView;
    if(![userManager loadUserInfo]){
        pushView = [[LoginViewController alloc]init];
    } else {
        pushView = [[DetailPageController alloc] initWithProductID:product._id];
    }
    [self.navigationController pushViewController:pushView animated:NO];
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
    NSInteger section = indexPath.section;
    cell.delegate = self;
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
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


@end
