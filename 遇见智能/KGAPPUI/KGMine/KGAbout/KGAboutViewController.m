//
//  KGAboutViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGAboutViewController.h"

@interface KGAboutViewController ()<UITextViewDelegate>

@end

@implementation KGAboutViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //自定义背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //消除阴影
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpLeftNavButtonItmeTitle:@"" icon:@"Return"];
    
    [self createLabel];
}

#pragma mark -关于我们-
- (void)createLabel{
    /*
     *背景图
     */
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    backImage.image = KGImage(@"bg");
    [self.view addSubview:backImage];
    
    /*
     *图标
     */
    UIImageView *logImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    logImage.center = CGPointMake(KGscreenWidth/2, KGscreenHeight/2 + 100);
    logImage.image = KGImage(@"meeting");
    [self.view addSubview:logImage];
    
    /***此处注释的是显示关于我们的一些文本，可以使用可变字符串去编译**
    UITextView *text = [[UITextView alloc]initWithFrame:CGRectMake(50, 100, KGscreenWidth - 100, KGscreenHeight - 150)];
    text.text = @"";
    text.textColor = KGcolor(231, 99, 40, 1);
    text.backgroundColor = [UIColor clearColor];
    text.font = [UIFont fontWithName:@"Arial" size:15.0f];
    text.textAlignment = NSTextAlignmentCenter;
    text.delegate         = self;
    text.editable         = YES;

    [self.view addSubview:text];
     **********/
}

/**UItextView不允许编译，只显示文本，可以复制**/
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
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
