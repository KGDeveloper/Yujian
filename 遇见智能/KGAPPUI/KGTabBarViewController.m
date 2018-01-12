 //
//  KGTabBarViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGTabBarViewController.h"
#import "KGHomeViewController.h"
#import "KGMineViewController.h"
#import "KGOrderViewController.h"
#import "KGRubbishViewController.h"

@interface KGTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation KGTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    [self initTabbar];
}

#pragma mark -创建tabbar控制器-
- (void)initTabbar{
    
    //酒店页面
    KGHomeViewController *home = [[KGHomeViewController alloc]init];
    UINavigationController *homeNv = [[UINavigationController alloc]initWithRootViewController:home];
    
    //订单页面
    KGOrderViewController *order = [[KGOrderViewController alloc]init];
    UINavigationController *orderNv = [[UINavigationController alloc]initWithRootViewController:order];
    
    KGRubbishViewController *rubbish = [[KGRubbishViewController alloc]init];
    UINavigationController *rubbishNv = [[UINavigationController alloc]initWithRootViewController:rubbish];
    
    //个人信息页面
    KGMineViewController *mine = [[KGMineViewController alloc]init];
    UINavigationController *mineNv = [[UINavigationController alloc]initWithRootViewController:mine];
    
    self.viewControllers = [NSArray arrayWithObjects:homeNv,orderNv,rubbishNv,mineNv, nil];
    
    self.delegate = self;
    
    UITabBarItem *homeItme = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *orderItme = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *rubbishItem = [self.tabBar.items objectAtIndex:2];
    UITabBarItem *mineItme = [self.tabBar.items objectAtIndex:3];
    
    [self setTabBarItem:homeItme withNormalImageName:@"Hotel" andSelectedImageName:@"Hotel1" andTitle:@"酒店"];
    [self setTabBarItem:orderItme withNormalImageName:@"Order1" andSelectedImageName:@"Order" andTitle:@"订单"];
    [self setTabBarItem:rubbishItem withNormalImageName:@"垃圾-2" andSelectedImageName:@"垃圾" andTitle:@"回收"];
    [self setTabBarItem:mineItme withNormalImageName:@"My1" andSelectedImageName:@"My" andTitle:@"个人"];
    
    //设置tabbar选中和正常状态下的字体大小和颜色
    [[UITabBarItem appearance] setTitleTextAttributes:KGAttributesFont(12.0f, KGCellDont) forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:KGAttributesFont(12.0f, KGCellHave) forState:UIControlStateSelected];

}

/**
 设置tabbar选中和正常状态下的图片
 
 @param tabBarItem 当前tabbarItem
 @param normalImageName 正常状态下的图标
 @param selectedImageName 选中状态下的图标
 @param title tabbar的标题
 */
- (void)setTabBarItem:(UITabBarItem *) tabBarItem withNormalImageName:(NSString *)normalImageName andSelectedImageName:(NSString *)selectedImageName andTitle:(NSString *)title
{
    //设置正常显示的图片
    [tabBarItem setImage:[[UIImage imageNamed:normalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //设置选中状态下的图片
    [tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //设置标题
    [tabBarItem setTitle:title];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
