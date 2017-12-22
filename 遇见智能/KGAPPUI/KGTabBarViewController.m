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

@interface KGTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation KGTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTabbar];
}

#pragma mark -创建tabbar控制器-
- (void)initTabbar{
    
    //酒店页面
    KGHomeViewController *home = [[KGHomeViewController alloc]init];
    home.title = @"酒店";
    UINavigationController *homeNv = [[UINavigationController alloc]initWithRootViewController:home];
    
    //订单页面
    KGOrderViewController *order = [[KGOrderViewController alloc]init];
    order.title = @"订单";
    UINavigationController *orderNv = [[UINavigationController alloc]initWithRootViewController:order];
    
    //个人信息页面
    KGMineViewController *mine = [[KGMineViewController alloc]init];
//    mine.title = @"个人中心";
    UINavigationController *mineNv = [[UINavigationController alloc]initWithRootViewController:mine];
    
    self.viewControllers = [NSArray arrayWithObjects:homeNv,orderNv,mineNv, nil];
    
    self.delegate = self;
    
    UITabBarItem *homeItme = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *orderItme = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *mineItme = [self.tabBar.items objectAtIndex:2];
    
    [self setTabBarItem:homeItme withNormalImageName:@"酒店" andSelectedImageName:@"酒店light" andTitle:@"酒店"];
    [self setTabBarItem:orderItme withNormalImageName:@"订单" andSelectedImageName:@"订单light" andTitle:@"订单"];
    [self setTabBarItem:mineItme withNormalImageName:@"个人" andSelectedImageName:@"个人light" andTitle:@"个人"];
    
    //设置tabbar选中和正常状态下的字体大小和颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName :[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"Marion-Italic" size:12.0]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:34/255.0 green:116/255.0 blue:255/255.0 alpha:1],NSFontAttributeName:[UIFont fontWithName:@"Marion-Italic" size:12.0]} forState:UIControlStateSelected];
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
