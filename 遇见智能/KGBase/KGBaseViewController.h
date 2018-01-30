//
//  KGBaseViewController.h
//  KGLeftBox
//
//  Created by KG on 2017/11/14.
//  Copyright © 2017年 KG. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KGscreenWidth [UIScreen mainScreen].bounds.size.width
#define KGscreenHeight [UIScreen mainScreen].bounds.size.height

#define KGYellowColor [UIColor colorWithRed:255/255.0 green:209/255.0 blue:43/255.0 alpha:1]

/**
 自定义颜色

 @param R 红比例
 @param G 绿比例
 @param B 蓝比例
 @param A <#A description#>
 @return <#return value description#>
 */
#define KGcolor(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@interface KGBaseViewController : UIViewController
/**
 导航栏左侧按钮
 
 @param title 如若是显示文字填写title，否则填写nil
 @param icon 如若是显示图片填写icon，否则填写nil
 */
- (void)setUpLeftNavButtonItmeTitle:(NSString *)title icon:(NSString *)icon;
/**
 导航栏右侧按钮
 
 @param title 如若是显示文字填写title，否则填写nil
 @param icon 如若是显示图片填写icon，否则填写nil
 */
- (void)setUpRightNavButtonItmeTitle:(NSString *)title icon:(NSString *)icon;
/**
 导航栏左侧按钮
 
 @param sender 按钮，UIButton *类型
 */
- (void)leftBarItmeClick:(UIButton *)sender;
/**
 导航栏右侧按钮
 
 @param sender 按钮，UIButton *类型
 */
- (void)rightBarItmeClick:(UIButton *)sender;
/**
 警告框
 
 @param title 显示警告框标题
 @param message 显示警告框信息
 @param name 按钮显示信息
 @param type 控制按钮个数
 @param preferredStyle 设置警告框现实样式
 */
- (void)alertViewControllerTitle:(NSString *)title message:(NSString *)message name:(NSString *)name type:(NSInteger)type preferredStyle:(UIAlertControllerStyle)preferredStyle;
/**
 返回字典

 @param font 字体大小
 @param color 字体颜色
 @return 设置富文本
 */
- (NSDictionary *)dictionaryWithFont:(NSInteger)font andColor:(UIColor *)color;

@end
