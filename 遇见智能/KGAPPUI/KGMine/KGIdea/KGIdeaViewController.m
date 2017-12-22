//
//  KGIdeaViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGIdeaViewController.h"

@interface KGIdeaViewController ()<UITextViewDelegate>{
    UITextView *contentTextView;
    //在UITextView上面覆盖个UILable
    UILabel *promptLabel;
}

@end

@implementation KGIdeaViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    contentTextView.text = @"";
    promptLabel.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"投诉建议";
    self.view.backgroundColor = KGOrangeColor;
    [self setUpRightNavButtonItmeTitle:@"提交" icon:nil];
    [self setTextView];
}

- (void)rightBarItmeClick:(UIButton *)sender{
    if (contentTextView.text.length > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self alertViewControllerTitle:@"提示" message:@"请输入您宝贵的意见" name:@"确定" type:0 preferredStyle:1];
    }
}

#pragma mark -创建意见-
- (void)setTextView{
    //意见内容
    contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 44, KGscreenWidth, 350)];
    contentTextView.font = KGFont(13);
    contentTextView.delegate = self;
    [self.view addSubview:contentTextView];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 60, 35)];
    contentLabel.font = KGFont(13);
    contentLabel.text = @"*您的意见";
    [contentTextView addSubview:contentLabel];
    
    //在UITextView上面覆盖个UILable
    promptLabel = [[UILabel alloc] init];
    promptLabel.frame =CGRectMake(5,5,200,25);
    promptLabel.text = @"                         请输入意见";
    promptLabel.enabled = NO;
    promptLabel.backgroundColor = [UIColor clearColor];
    promptLabel.font =  [UIFont systemFontOfSize:13];
    promptLabel.textColor = KGOrangeColor;
    [contentTextView addSubview:promptLabel];
    
    //改变五角星的颜色
    NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc] initWithString:contentLabel.text];
    [contentStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
    contentLabel.attributedText = contentStr;
}

#pragma mark -UITextView的代理方法
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        promptLabel.hidden = NO;
    }else{
        promptLabel.hidden = YES;
    }
    //首行缩进
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;    //行间距
    //    paragraphStyle.maximumLineHeight = 60;   /**最大行高*/
    paragraphStyle.firstLineHeadIndent = 93.f;    /**首行缩进宽度*/
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:13],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [contentTextView resignFirstResponder];
}

/**
 警告框
 
 @param title 显示警告框标题
 @param message 显示警告框信息
 @param name 按钮显示信息
 */
- (void)alertViewControllerTitle:(NSString *)title message:(NSString *)message name:(NSString *)name type:(NSInteger)type preferredStyle:(UIAlertControllerStyle)preferredStyle{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    //如果参数是0表示只有一个按钮点击后警告框消失
    if (type == 0) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:name style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:action];
    }else{
        
        UIAlertAction *sureAct = [UIAlertAction actionWithTitle:name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self alertControllerAction];
        }];
        
        UIAlertAction *canalAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:sureAct];
        [alert addAction:canalAct];
    }
    
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
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
