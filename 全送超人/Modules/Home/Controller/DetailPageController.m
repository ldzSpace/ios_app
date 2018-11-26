//
//  DetailPageController.m
//  全送超人
//
//  Created by admin on 2018/11/10.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "DetailPageController.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "DetailPageLogic.h"
#import "ProductDetailCell.h"
#import "ProductDetailInfoCell.h"
#import "ProductBaseInfoCell.h"
#import "ZJPickerView.h"
#import "WebViewController.h"
#import "ConfigModle.h"
#import "ProductDetailInfoCellFrame.h"
@interface DetailPageController()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) DetailPageLogic * logic;
@property (strong, nonatomic) ProductDetailCell * productCell;
@property (assign, nonatomic) NSString* productId;
@property (strong, nonatomic) UIView * bottomView;
@property (strong, nonatomic) UITableView * mytableView;
@property (strong, nonatomic) UIView * infoView;
@property (strong, nonatomic) ProductBaseInfoCell * basecell;
@property (strong, nonatomic) ProductDetailInfoCell * inductionView1;
@property (strong, nonatomic) ProductDetailInfoCell * inductionView2;
@property (strong, nonatomic) ProductDetailInfoCell * inductionView3;
@property (assign, nonatomic) int cellHight;
@property (assign, nonatomic) int step;

@end

@implementation DetailPageController

-(id)initWithProductID:(NSString*)productId
{
    self = [self init];
    if(self){
       self.productId = productId;
    }
    return  self;
}

-(void)viewDidLoad{
    // 初始化界面
    [self setupUI];
    
    // 加载数据
    [self loadData];
    
}

-(void)setupUI
{
    
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
    
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 617, KScreenWidth, 50)];
    UIButton * applyBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 0, KScreenWidth - 80, 50)];
    UIButton * serviceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80 , 50)];
    [applyBtn setBackgroundColor : CNavBgColor];
    applyBtn.titleLabel.font = LCMainFont;
    [applyBtn setTitle:@"立即申请" forState:UIControlStateNormal];
    [applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [applyBtn addTarget:self action:@selector(allpyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [serviceBtn setImage:[UIImage imageNamed:@"icon_service"] forState:UIControlStateNormal];
    serviceBtn.titleLabel.font = LCApplyButtonFont;
    [serviceBtn setTitleColor:CNavBgColor forState:UIControlStateNormal];
    [serviceBtn setTitle:@"客服" forState:UIControlStateNormal];
    serviceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    // button标题的偏移量
    serviceBtn.titleEdgeInsets = UIEdgeInsetsMake(serviceBtn.imageView.frame.size.height+5, -serviceBtn.imageView.bounds.size.width, 0,0);
    // button图片的偏移量
    serviceBtn.imageEdgeInsets = UIEdgeInsetsMake(0, serviceBtn.titleLabel.frame.size.width/2, serviceBtn.titleLabel.frame.size.height+5, -serviceBtn.titleLabel.frame.size.width/2);
    [serviceBtn addTarget:self action:@selector(serviceButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [_bottomView addSubview:applyBtn];
    [_bottomView addSubview:serviceBtn];
    
    [self.view addSubview:_bottomView];
    self.view.backgroundColor = [UIColor colorWithRed:241.0/255 green:242.0/255 blue:246.0/255 alpha:1.0];
    [self layoutTableView];
}

-(void)layoutTableView
{
    if (!_mytableView) {
        _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 75, KScreenWidth, KScreenHeight-75-50) style:UITableViewStyleGrouped];
        _mytableView.backgroundColor=[UIColor clearColor];
        _mytableView.showsVerticalScrollIndicator = NO;
        _mytableView.dataSource = self;
        _mytableView.delegate = self;
        [self.view addSubview:_mytableView];
    }
}

-(void)loadData{
    _logic = [[DetailPageLogic alloc] init];
    _logic.delegate = self;
    [_logic loadData: _productId];
}

-(void)backBtnClicked:(UIButton*)sender
{
    NSDictionary *titleTextAttDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil, NSShadowAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:titleTextAttDict];
    [self.navigationController.navigationBar setBarTintColor:CNavBgColor];
    [self.navigationController popViewControllerAnimated:YES];
}

// 数据加载后回调
- (void)updateUI{
    [self.navigationItem setTitle:_logic.product.name];
    [_productCell setProductData:_logic.product];
    [_basecell setInfoData:_logic.product];
    [_inductionView1 setInfoData:_logic.product Type:0];
    [_inductionView2 setInfoData:_logic.product Type:1];
    [_inductionView3 setInfoData:_logic.product Type:2];
}


-(void)allpyButtonClick:(UIButton*)sender
{
    if(_logic.product)
    {
        id pushView = [[WebViewController alloc] initWithUrl:_logic.product.url];;
        [self.navigationController pushViewController:pushView animated:NO];
    }

}

-(void)serviceButtonClick:(UIButton*)sender
{
    id  pushView = [[WebViewController alloc] initWithUrl:configInstance.helpUrl];
    [self.navigationController pushViewController:pushView animated:NO];
}

-(ProductDetailCell*)productVC{
    if (!_productCell) {
        _productCell = [[ProductDetailCell alloc]init];
    }
    return _productCell;
}


-(UIView *)BaseInfoView{
    if(!_infoView){
        _basecell = [[ProductBaseInfoCell alloc]init];
        _infoView = _basecell.infoView;
        _basecell.moneyInput.delegate = self;
        _basecell.dayInput.delegate = self;
        [_basecell.moneyInput addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventTouchDown];
        [_basecell.dayInput addTarget:self action:@selector(textFieldTextChangeDay:) forControlEvents:UIControlEventTouchDown];
    }
    return _infoView;
}

-(UIView*)inductionView_one{
    
    if(!_inductionView1){
       _inductionView1 = [[ProductDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pdif"];
    }
    return  _inductionView1;
}

-(UIView*)inductionView_two{
    
    if(!_inductionView2){
        _inductionView2 = [[ProductDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"p2dif"];
       [_inductionView2 setInfoData:_logic.product Type:1];
    }
    return  _inductionView2;
}

-(UIView*)inductionView_three{
    
    if(!_inductionView3){
        _inductionView3 =[[ProductDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"p3dif"];
       [_inductionView3 setInfoData:_logic.product Type:2];
    }
    return  _inductionView3;
}


#pragma mark ----- 点击回调 ------------

#pragma mark ----- 代理方法 ------------
-(void)textFieldTextChange:(UITextField*)text {
    int maxMoney = _logic.product.maxAmount;
    int minMoney = _logic.product.minAmount;
    NSMutableArray * stepArray = [[NSMutableArray alloc] init];
    [stepArray addObject:[NSString stringWithFormat:@"%d", minMoney]];
    if(maxMoney <= 1000){
        _step = 100;
    }else if(maxMoney <=5000){
        _step = 1000;
    }else if(maxMoney <= 10000){
        _step = 5000;
    }else if(maxMoney <=100000){
        _step = 10000;
    }else if(maxMoney > 100000){
        _step = 50000;
    }
    
    int i;
    if(minMoney < _step){
        i = _step;
    }else{
        int kRate =  minMoney / _step;
        i = _step * (kRate + 1);
        NSLog(@"rate ==%d",kRate);
    }
    NSLog(@"init ==%d",i);
    
    while(i < maxMoney){
        [stepArray addObject:[NSString stringWithFormat:@"%d", i]];
        i+=_step;
    }
    [stepArray addObject:[NSString stringWithFormat:@"%d", maxMoney]];

    NSLog(@"StepArray= %@",stepArray);
    [ZJPickerView zj_showWithDataList:stepArray propertyDict:nil completion:^(NSString *selectcontent){
        _basecell.moneyInput.text = selectcontent;
       _basecell.interstLabel.text = [NSString stringWithFormat:@"%d", [_basecell.moneyInput.text intValue] / [_basecell.dayInput.text intValue]];
    }];
    
}

-(void)textFieldTextChangeDay:(UITextField*)text {
    int maxDay = _logic.product.termMax;
    int minDay = _logic.product.termMin;
    NSMutableArray * dayArray = [[NSMutableArray alloc] init];
    int i = minDay;
    while(i <= maxDay){
        [dayArray addObject:[NSString stringWithFormat:@"%d", i]];
        i++;
    }
    
    [ZJPickerView zj_showWithDataList:dayArray propertyDict:nil completion:^(NSString *selectcontent){
        _basecell.dayInput.text = selectcontent;
        _basecell.interstLabel.text = [NSString stringWithFormat:@"%d", [_basecell.moneyInput.text intValue] / [selectcontent intValue]];
    }];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

#pragma mark - DetailLogic的代理
- (void)requestDataCompleted{
    [self updateUI];
    [UIView performWithoutAnimation:^{
        [self.mytableView reloadData];
    }];
}

#pragma mark - tableView的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 160;
    }
    if(section == 1){
        
        return 200;
    }

    if(section == 2 || section == 3 || section == 4){
        ProductDetailInfoCellFrame* pdFrame = [[ProductDetailInfoCellFrame alloc] init];
        [pdFrame setProductInfoData:_logic.product Type:section - 2];

        return pdFrame.cellHight;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.productVC;
    }
    
    if (section == 1)
    {
        return self.BaseInfoView;
    }
    
    if(section == 2){
        return [self inductionView_one];
    }
    
    if(section == 3){
        
        return [self inductionView_two];
    }
    
    if(section == 4){
        NSLog(@"kkk");
        return [self inductionView_three];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}



//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    // 1.缓存中取数据
//    ProductDetailInfoCellFrame* pdFrame = [[ProductDetailInfoCellFrame alloc] init];
//    [pdFrame setProductInfoData:_logic.product Type:indexPath.row];
//    return pdFrame.cellHight + 20;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section=%@",indexPath);
//    ProductDetailInfoCell * cell = [ProductDetailInfoCell cellWithTableView:(UITableView *)tableView];
//    if(cell){
//        [cell setInfoData:_logic.product Type:indexPath.row];
//    }
    return nil;
}



@end
