//
//  MenuCollectionViewController.m
//  全送超人
//
//  Created by admin on 2018/11/7.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "MenuCollectionViewController.h"
#import "MenuCollectionViewCell.h"
#import "CateModel.h"
#import "SpecialLoansController.h"

@interface MenuCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation MenuCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init{
    _dataArray = @[].mutableCopy;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
  
    // 设置最小行间距
    layout.minimumLineSpacing = 10;
    // 设置垂直间距
    layout.minimumInteritemSpacing = 0;
    // 设置边缘的间距，默认是{0，0，0，0}
    layout.sectionInset = UIEdgeInsetsMake(15, 12, 0, 12);
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.bounces = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.clearsSelectionOnViewWillAppear = NO;
    
    [self.collectionView registerClass:[MenuCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    //4.设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)setMenuData:(NSMutableArray*) dataArray{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

-(void)removeMenuData{
    if (_dataArray) {
        [_dataArray removeAllObjects];
    }
}


#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MenuCollectionViewCell *cell = (MenuCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    int index = indexPath.section*3 + indexPath.row;
    if(_dataArray.count > 0){
        CateModel * cate = (CateModel *)[_dataArray objectAtIndex:index];
        cell.botlabel.text = cate.description;
        cell.toplabel.text = cate.name;
    }
    switch (index) {
        case 0:
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_menu_gray1"]] ;
            break;
        case 1:
            
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_menu_gray2"]] ;
            break;
        case 2:
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_menu_gray3"]] ;
            break;
        case 3:
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_menu_blue1"]] ;
            break;
        case 4:
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_menu_blue2"]] ;
            break;
        case 5:
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_menu_blue3"]] ;
            break;
    }
   
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(110, 80);
}

//设置每个item的UIEdgeInsets
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}



//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
      int index = indexPath.section*3 + indexPath.row;
      CateModel * cate = (CateModel *)[_dataArray objectAtIndex:index];
    if(self.delegate){
       [self.delegate popToCateList:cate];
    }
}


@end
