//
//  MainTabBarController.m
//  全送超人
//
//  Created by admin on 2018/11/6.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "MainTabBarController.h"
#import "XYTabBar.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "HomePageControllerViewController.h"
#import "LoansPageController.h"
#import "PersonPageController.h"
#import "RootNavigationController.h"
#import "UITabBar+CustomBadge.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>

@property(nonatomic,strong) NSMutableArray *vcs;
@property(nonatomic,strong) UIPanGestureRecognizer * panGestureRecognizer;
@end

@implementation MainTabBarController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    // 初始化tabbar
    [self setUpTabBar];
    [self setUpAllChildViewController];
    
    // 添加手势
//    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
//    [self.view addGestureRecognizer:self.panGestureRecognizer];
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


-(void)setUpTabBar
{
    XYTabBar * tabBar = [XYTabBar new];
    [self setValue:tabBar forKey:@("tabBar")];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundImage:[UIImage new]];
}

#pragma mark --------------- 设置子视图 --------------
-(void)setUpAllChildViewController
{
    _vcs = @[].mutableCopy;

    HomePageControllerViewController *homeVC = [[HomePageControllerViewController alloc]init];
    [self setupChildViewController:homeVC title:@"首页" imageName:@"icon_tabbar_home" seleceImageName:@"icon_tabbar_home_normal"];
    
    //    MakeFriendsViewController *makeFriendVC = [[MakeFriendsViewController alloc]init];
    LoansPageController *loadsVC = [[LoansPageController alloc]init];
    [self setupChildViewController:loadsVC title:@"找贷款" imageName:@"icon_tabbar_load" seleceImageName:@"icon_tabbar_load_normal"];
    
    PersonPageController *mineVC = [[PersonPageController alloc]init];
    [self setupChildViewController:mineVC title:@"个人中心" imageName:@"icon_tabbar_mine" seleceImageName:@"icon_tabbar_mine_normal"];
    
    // 添加到UITabBarController中的viewControllers
    self.viewControllers = _vcs;
    
}

-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName
{
    controller.title = title;
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    // 未选中字体的颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KBlackColor,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateNormal];
    // 选中字体的颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateSelected];
//    if(![controller isKindOfClass:[PersonPageController class]]){
        RootNavigationController *navController = [[RootNavigationController alloc] initWithRootViewController: controller];
         [_vcs addObject:navController];
//    }
//    else
//    {
//         [_vcs addObject:controller];
//    }
    
   
}

-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow
{
    
    
}

//
//-(void)panGestureRecognizer:(UIPanGestureRecognizer *)panGesture{
//    // 如果没有动画控制器，则不执行动画，动画控制器就是用来展示切换动画
//    if (self.transitionCoordinator) {
//        return;
//    }
//
//    // 开始执行动画
//    if (panGesture.state == UIGestureRecognizerStateBegan || panGesture.state == UIGestureRecognizerStateChanged){
//        [self beginInteractiveTransitionIfPossible:panGesture];
//    }
//}
//
//- (void)beginInteractiveTransitionIfPossible:(UIPanGestureRecognizer *)sender{
//    // 通过滑动的方法判断应该像那边跳转
//    CGPoint translation = [sender translationInView:self.view];
//    if (translation.x > 0.f && self.selectedIndex > 0) {
//        self.selectedIndex --;
//    }
//    else if (translation.x < 0.f && self.selectedIndex + 1 < self.viewControllers.count) {
//        self.selectedIndex ++;
//    }
//    else {
//        if (!CGPointEqualToPoint(translation, CGPointZero)) {
//            sender.enabled = NO;
//            sender.enabled = YES;
//        }
//    }
//
//    // 告知动画控制器，开始执行动画，这里需要注意：苹果提供了两个方法，但是我们只有选择这个方法，并且只有这样写才能按我们的预期执行，否则会有BUG，这一点我也不知道原因
//    [self.transitionCoordinator animateAlongsideTransitionInView:self.view animation:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//
//    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//        if ([context isCancelled] && sender.state == UIGestureRecognizerStateChanged){
//            [self beginInteractiveTransitionIfPossible:sender];
//        }
//    }];
//}
//
//
///**
// *  实现该代理，即可以实现自定义的各界面切换时的动画(如平推，缩放，淡入淡出等)
// *  fromVC：当前显示的VC
// *  toVC：将要切换到的VC
// *  返回一个自定义的切换动画，在本例中，我自定义了一个平推效果的动画
// */
//- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
//                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
//                                                       toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0){
//    // 判断是否是通过手势
//    if (self.panGestureRecognizer.state == UIGestureRecognizerStateBegan || self.panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
//        // 判断跳转的方向
//        NSArray *viewControllers = tabBarController.viewControllers;
//        if ([viewControllers indexOfObject:toVC] > [viewControllers indexOfObject:fromVC]) {
//            // 返回的自定义动画
//            return [[TabBarTransitionAnimation alloc] initWithTargetEdge:UIRectEdgeLeft];
//        }
//        else {
//            return [[TabBarTransitionAnimation alloc] initWithTargetEdge:UIRectEdgeRight];
//        }
//    }
//    else{
//        // 返回空，表示用系统的动画
//        return nil;
//    }
//}
//
///**
// *  实现该代理，即可以实现与动画的交互
// *  tabBarController:当前的tabBarController
// *  animationController：动画百分比控制器
// *  返回一个自定义的动画百分比控制器，以控制当前动画进行的百分比。
// */
//- (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
//                               interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController NS_AVAILABLE_IOS(7_0){
//    if (self.panGestureRecognizer.state == UIGestureRecognizerStateBegan || self.panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
//        // 返回自定义的动画百分比控制器
//        return [[TabBarTransitionController alloc] initWithGestureRecognizer:self.panGestureRecognizer];
//    }
//    else {
//        // 返回空，表示用系统的
//        return nil;
//    }
//}


@end
