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
    
    self.title = @"关于我们";
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
     *login
     */
    UIImageView *logImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    logImage.center = CGPointMake(KGscreenWidth/2, KGscreenHeight/2);
    logImage.image = KGImage(@"meeting");
    [self.view addSubview:logImage];
    
    
//    UITextView *text = [[UITextView alloc]initWithFrame:CGRectMake(50, 100, KGscreenWidth - 100, KGscreenHeight - 150)];
//    text.text = @"";
//    text.textColor = KGcolor(231, 99, 40, 1);
//    text.backgroundColor = [UIColor clearColor];
//    text.font = [UIFont fontWithName:@"Arial" size:15.0f];
//    text.textAlignment = NSTextAlignmentCenter;
//    text.delegate         = self;
//    text.editable         = YES;
//
//    [self.view addSubview:text];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
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
