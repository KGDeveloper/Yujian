//
//  KGBaseViewController.m
//  KGLeftBox
//
//  Created by KG on 2017/11/14.
//  Copyright © 2017年 KG. All rights reserved.
//

#import "KGBaseViewController.h"

@interface KGBaseViewController ()

@end

@implementation KGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏状态
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    //设置view的背景色
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    //设置导航栏的颜色
    [self.navigationController.navigationBar setBarTintColor:KGOrangeColor];
    
    //设置导航栏的字体大小以及颜色，是一个字典类型
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    
    //绑定到导航栏左侧按钮
    self.navigationItem.leftBarButtonItem = [self setUpLeftNavButtonItmeTitle:nil icon:@"返回"];
}


/**
 导航栏左侧按钮

 @param title 如若是显示文字填写title，否则填写nil
 @param icon 如若是显示图片填写icon，否则填写nil
 */
- (UIBarButtonItem *)setUpLeftNavButtonItmeTitle:(NSString *)title icon:(NSString *)icon{
    
    //规定按钮风格
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置按钮大小
    leftButton.frame = CGRectMake(0, 0, 30, 30);
    //设置按钮标题
    [leftButton setTitle:title forState:UIControlStateNormal];
    //设置按钮背景图
    [leftButton setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    //设置按钮点击事件
    [leftButton addTarget:self action:@selector(leftBarItmeClick:) forControlEvents:UIControlEventTouchUpInside];
    //绑定按钮，即替换系统的返回按钮
    UIBarButtonItem *leftItme = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    return leftItme;
}

/**
 导航栏左侧按钮

 @param sender 按钮，UIButton *类型
 */
- (void)leftBarItmeClick:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 导航栏右侧按钮
 
 @param title 如若是显示文字填写title，否则填写nil
 @param icon 如若是显示图片填写icon，否则填写nil
 */
- (void)setUpRightNavButtonItmeTitle:(NSString *)title icon:(NSString *)icon{
    //规定按钮风格
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置按钮大小
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    //设置按钮标题
    [rightButton setTitle:title forState:UIControlStateNormal];
    //设置按钮背景图
    [rightButton setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    //设置按钮点击事件
    [rightButton addTarget:self action:@selector(rightBarItmeClick:) forControlEvents:UIControlEventTouchUpInside];
    //绑定按钮，即替换系统的返回按钮
    UIBarButtonItem *rightItme = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    //绑定到导航栏右侧按钮
    self.navigationItem.rightBarButtonItem = rightItme;
    
}

/**
 导航栏右侧按钮
 
 @param sender 按钮，UIButton *类型
 */
- (void)rightBarItmeClick:(UIButton *)sender{
    
}

/**
 警告框

 @param title 显示警告框标题
 @param message 显示警告框信息
 @param name 按钮显示信息
 */
- (void)alertViewControllerTitle:(NSString *)title message:(NSString *)message name:(NSString *)name type:(NSInteger)type preferredStyle:(UIAlertControllerStyle)preferredStyle{
    //创建警告框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    //如果参数是0表示只有一个按钮点击后警告框消失
    if (type == 0) {
        //创建单按钮警告框
        UIAlertAction *action = [UIAlertAction actionWithTitle:name style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:action];
    }else{
        //创建多按钮警告
        UIAlertAction *sureAct = [UIAlertAction actionWithTitle:name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self alertControllerAction];
        }];
        
        UIAlertAction *canalAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:sureAct];
        [alert addAction:canalAct];
    }
    //显示警告框
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - 警告框点击按钮后要执行的方法在这里实现-
- (void)alertControllerAction{
    
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
