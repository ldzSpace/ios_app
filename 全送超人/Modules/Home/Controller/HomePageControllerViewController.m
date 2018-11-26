//
//  HomePageControllerViewController.m
//  全送超人
//
//  Created by admin on 2018/11/6.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "HomePageControllerViewController.h"
#import "MenuCollectionViewController.h"
#import "SDCycleScrollView.h"
#import "FontAndColorMacros.h"
#import "HomePageLogic.h"
#import "UIScrollView+MJRefresh.h"
#import "MJRefresh.h"
#import "UtilsMacros.h"
#import "BannerModel.h"
#import "PopupModel.h"
#import "NSString+URL.h"
#import "Masonry.h"
#import "ViewController+MASAdditions.h"
#import "View+MASAdditions.h"
#import "RecommendProductCell.h"
#import "LoansCell.h"
#import "DetailPageController.h"
#import "WebViewController.h"
#import "SpecialLoansController.h"
#import "AdAlertView.h"
#import "UserManager.h"
#import "LoginViewController.h"

#define itemWidthHeight ((kScreenWidth-10)/2)

@interface HomePageControllerViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,AdAlertViewDelegate>

@property (nonatomic, strong) NSArray *localImages;//本地图片

@property (nonatomic, strong) NSMutableArray *netImages;  //网络图片

@property(nonatomic, strong) SDCycleScrollView *bannerAd; //Banner广告

@property(nonatomic, strong) MenuCollectionViewController *menuVC; //九宫格

@property(nonatomic, strong) RecommendProductCell * recommendProductCell; //推荐产品

@property(nonatomic, strong) LoansCell * productCell;

@property(nonatomic, strong) SDCycleScrollView *textAd; //滚动文字广告

@property(nonatomic, strong) NSArray *cellImage;

@property(nonatomic, strong) HomePageLogic *logic;//逻辑层


@end

static  bool isShowAlert = true;
@implementation HomePageControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 初始化界面
    [self setupUI];
    
    //初始化逻辑类
    _logic = [HomePageLogic new];
    _logic.delegate = self;
  
    //开始第一次数据拉取
    [self.tableView.mj_header beginRefreshing];
    
}


- (void)setupUI
{
    self.view.backgroundColor = CViewBgColor;
    self.isShowLiftBack = NO;//每个根视图需要设置该属性为NO，否则会出现导航栏异常
    
    UIView * tvFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 50)];
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 0, 300, 30)];
    [imgView setImage:[UIImage imageNamed:@"icon_tableview_footer"]];
    [tvFootView addSubview:imgView];
    

  
//    NSDictionary *titleTextAttDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil, NSShadowAttributeName, nil];
//    [self.navigationController.navigationBar setTitleTextAttributes:titleTextAttDict];
//    [self.navigationController.navigationBar setBarTintColor:CNavBgColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = tvFootView;
    [self.view addSubview: self.tableView];
}



// 轮播图
-(SDCycleScrollView *)bannerAd{
    CGRect rect = CGRectMake(12,12, 350, 177);
    if(!_bannerAd){
        _bannerAd = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:self placeholderImage:[UIImage imageNamed:@"icon_banner_placeholder"]];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_bannerAd.bounds byRoundingCorners:(UIRectCornerBottomLeft |UIRectCornerBottomRight | UIRectCornerTopLeft |UIRectCornerTopRight) cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _bannerAd.bounds;
        maskLayer.path = maskPath.CGPath;
        _bannerAd.layer.mask = maskLayer;
        _netImages = [[NSMutableArray alloc]init];
  
        //设置网络图片数组
        _bannerAd.imageURLStringsGroup = _netImages;
        
        //设置无线循环
        _bannerAd.infiniteLoop = YES;
    
        //设置图片视图显示类型
        _bannerAd.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    
        //设置轮播视图的分页控件的显示
         _bannerAd.showPageControl = YES;
        
        //设置轮播视图分也控件的位置
        _bannerAd.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    
        //设置轮播图小点颜色
        _bannerAd.currentPageDotColor = [UIColor whiteColor];
    
    
         [_bannerAd setAutoScroll:YES];
    }
    return _bannerAd;
}

-(MenuCollectionViewController*)menuVC{
    if (!_menuVC) {
        _menuVC = [MenuCollectionViewController new];
        _menuVC.delegate = self;
    }
    return _menuVC;
}

-(RecommendProductCell *) recommondProduct{
    if (!_recommendProductCell) {
        _recommendProductCell = [[RecommendProductCell alloc]init];
        _recommendProductCell.delegate = self;
    }
    return _recommendProductCell;
}

// 处理数据
-(void) handleData{
    
    [self.netImages removeAllObjects];
    for(BannerModel * ban in _logic.bannerArray){
        [_netImages addObject: [ban.imgSrc URLEncodedString]];
    }

    _bannerAd.imageURLStringsGroup = _netImages;
    [_menuVC setMenuData:_logic.cateArray];
    for(ProductModel * product in _logic.productArray){
        if(product.recommend){
            [_recommendProductCell setRecommendData:product];
            break;
        }
    }
    
   
}

#pragma mark ----- 弹框的回调------
- (void)clickWithImageBg:(PopupModel *)popup{
    id pushView;
    if(![userManager loadUserInfo]){
        pushView = [[LoginViewController alloc]init];
    } else {
        if(popup.linkType == 1){
            pushView = [[WebViewController alloc] initWithUrl:popup.url];
            
        } else {
            NSLog(@"=%@",popup.jumpProduct);
            pushView = [[DetailPageController alloc] initWithProductID:popup.jumpProduct];
        }
    }
    [self.navigationController pushViewController:pushView animated:NO];
}

#pragma mark ————— 下拉刷新 —————
-(void)headerRereshing{
    [self removeAllData];
    [_logic loadData];
}

#pragma mark ————— 上拉刷新 —————
-(void)footerRereshing{
    [self removeAllData];
    [_logic loadData];
}

#pragma mark ————— 数据拉取完成 渲染页面 —————
-(void)requestDataCompleted{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
    [self handleData];
    [UIView performWithoutAnimation:^{
         [_bannerAd setAutoScroll:YES];
        [self.tableView reloadData];
    }];
    
    if(isShowAlert){
        isShowAlert = false;
        PopupModel * pop = _logic.popUpArray[0];
        NSLog(@"linkurl==%@",pop.url);
        AdAlertView *updateAlert = [[AdAlertView alloc]initWithPopup:pop];
        updateAlert.delegate =self;
        [[UIApplication sharedApplication].delegate.window addSubview:updateAlert];
    }
   
}

#pragma mark ------ 清理数据 ----------
-(void) removeAllData{
    [_menuVC removeMenuData];
    [_logic.cateArray removeAllObjects];
    [_logic.bannerArray removeAllObjects];
    [_logic.productArray removeAllObjects];
}

#pragma mark ------ menu 回调
- (void)popToCateList:(CateModel*)cate{
    id pushView;
    if(![userManager loadUserInfo]){
        pushView = [[LoginViewController alloc]init];
    } else {
        pushView = [[SpecialLoansController alloc] initWithCateID:cate];
    }
    [self.navigationController pushViewController:pushView animated:NO];
}

#pragma mark ------ 推荐回调----------
- (void)clickWithRecommendProductBtn:(NSString*)productId{
    id pushView;
    if(![userManager loadUserInfo]){
        pushView = [[LoginViewController alloc]init];
    } else {
        pushView =  [[DetailPageController alloc] initWithProductID:productId];
    }
    [self.navigationController pushViewController:pushView animated:NO];
}

#pragma mark ------ 今日推荐回调----------
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



#pragma mark - 代理方法
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    BannerModel * banner = _logic.bannerArray[index];
    id pushView;
    if(![userManager loadUserInfo]){
        pushView = [[LoginViewController alloc]init];
    } else {
        if(banner.linkType == 1){
            pushView = [[WebViewController alloc] initWithUrl:banner.url];
            
        } else {
            pushView = [[DetailPageController alloc] initWithProductID:banner.jumpProduct];
        }
    }
    
    [self.navigationController pushViewController:pushView animated:NO];
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}


#pragma mark - tableView的代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 202;
    }
    else if (section == 1) {
        return 205;
    }
    else if (section == 2) {
        return 111;
    }
    else if (section == 3) {
        return 40;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(12,12, 350, 175)];

        [v addSubview:self.bannerAd];
          [_bannerAd setAutoScroll:YES];
        return  v;
    }
    
    if (section == 1) {
        return self.menuVC.view;
    }
    
    if (section == 2){
        
        return self.recommondProduct;
    }

    if (section == 3) {
        UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
        titleView.backgroundColor = [UIColor whiteColor];
        UITextField *text= [[UITextField alloc]initWithFrame:CGRectMake(15, 0, KScreenWidth, 39)];
        text.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [text setText:@"今日推荐"];
        text.textColor = [UIColor blackColor];
        //创建分割线
        UIView *splitLine = [[UIView alloc] initWithFrame:CGRectMake(0, 39, KScreenWidth, 1)];
        splitLine.backgroundColor = [UIColor colorWithRed:232.0/255 green:232.0/255 blue:232.0/255 alpha:1.0];
        splitLine.userInteractionEnabled = YES;
        [titleView addSubview:splitLine];
        [titleView addSubview:text];
        return titleView;
    }
   
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 其他区section的rows数量是0，而section为4的row为4个
    if (section == 4) {
        if(_logic.productArray.count > 0){
            return _logic.productArray.count - 1;
        }
        return 0;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section=%@",indexPath);

    _productCell = [LoansCell cellWithTableView:tableView];
    _productCell.delegate = self;
    
    [_productCell setData:_logic.productArray[indexPath.row + 1 ]];
    return _productCell;
}

@end
