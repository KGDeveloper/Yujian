//
//  KGPassWordViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGPassWordViewController.h"

@interface KGPassWordViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) KGPriceTextField *oldPassWord;
@property (nonatomic,strong) KGPriceTextField *firstPass;
@property (nonatomic,strong) KGPriceTextField *sencedPass;

@end

@implementation KGPassWordViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    
    self.view.backgroundColor = KGOrangeColor;
    [self setUpRightNavButtonItmeTitle:@"修改" icon:nil];
    
    UILabel *LabelName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,KGscreenWidth - 80, 170)];
    LabelName.center = CGPointMake(KGscreenWidth/2, 265);
    LabelName.backgroundColor = [UIColor whiteColor];
    LabelName.layer.borderWidth = 1.0f;
    LabelName.layer.borderColor = [UIColor grayColor].CGColor;
    LabelName.layer.cornerRadius = 5.0f;
    LabelName.layer.masksToBounds = YES;
    [self.view addSubview:LabelName];
    
    [self setOldPass];
    [self setNewPass];
    [self setSureNewPass];
    
}

- (void)rightBarItmeClick:(UIButton *)sender{
    if (_oldPassWord.text.length < 1) {
        [self alertViewControllerTitle:@"提示" message:@"请输入旧密码" name:@"确定" type:0 preferredStyle:1];
    }else if (_firstPass.text.length < 1){
        [self alertViewControllerTitle:@"提示" message:@"请输入新密码" name:@"确定" type:0 preferredStyle:1];
    }else if (_sencedPass.text.length < 1){
        [self alertViewControllerTitle:@"提示" message:@"请再次确认新密码" name:@"确定" type:0 preferredStyle:1];
    }else{
        if ([_firstPass.text isEqualToString:_sencedPass.text]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self alertViewControllerTitle:@"提示" message:@"两次输入的新密码不一样，请查看确认！" name:@"确定" type:0 preferredStyle:1];
        }
    }
}

#pragma mark -创建旧密码-
- (void)setOldPass{
    _oldPassWord = [[KGPriceTextField alloc]initWithFrame:CGRectMake(50, 200, KGscreenWidth - 100, 30)];
    _oldPassWord.placeholder = @"请输入旧密码";
    _oldPassWord.textColor = [UIColor grayColor];
    _oldPassWord.delegate = self;
    _oldPassWord.font = [UIFont systemFontOfSize:13.0f];
    _oldPassWord.returnKeyType = UIReturnKeyGo;
    _oldPassWord.clearButtonMode = UITextFieldViewModeAlways;
    _oldPassWord.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码-2"]];
    _oldPassWord.leftViewMode = UITextFieldViewModeAlways;
    _oldPassWord.layer.cornerRadius = 5.0f;
    _oldPassWord.layer.borderWidth = 1.0f;
    _oldPassWord.layer.borderColor = [UIColor grayColor].CGColor;
    _oldPassWord.layer.masksToBounds = YES;
    [self.view addSubview:_oldPassWord];
}

#pragma mark -创建新密码-
- (void)setNewPass{
    _firstPass = [[KGPriceTextField alloc]initWithFrame:CGRectMake(50, 250, KGscreenWidth - 100, 30)];
    _firstPass.placeholder = @"请输入新密码";
    _firstPass.textColor = [UIColor grayColor];
    _firstPass.delegate = self;
    _firstPass.font = [UIFont systemFontOfSize:13.0f];
    _firstPass.returnKeyType = UIReturnKeyGo;
    _firstPass.clearButtonMode = UITextFieldViewModeAlways;
    _firstPass.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码-2"]];
    _firstPass.leftViewMode = UITextFieldViewModeAlways;
    _firstPass.layer.cornerRadius = 5.0f;
    _firstPass.layer.borderWidth = 1.0f;
    _firstPass.layer.borderColor = [UIColor grayColor].CGColor;
    _firstPass.layer.masksToBounds = YES;
    [self.view addSubview:_firstPass];
}

#pragma mark -确认新密码-
- (void)setSureNewPass{
    _sencedPass = [[KGPriceTextField alloc]initWithFrame:CGRectMake(50, 300, KGscreenWidth - 100, 30)];
    _sencedPass.placeholder = @"请确认新密码";
    _sencedPass.textColor = [UIColor grayColor];
    _sencedPass.delegate = self;
    _sencedPass.font = [UIFont systemFontOfSize:13.0f];
    _sencedPass.returnKeyType = UIReturnKeyGo;
    _sencedPass.clearButtonMode = UITextFieldViewModeAlways;
    _sencedPass.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码-2"]];
    _sencedPass.leftViewMode = UITextFieldViewModeAlways;
    _sencedPass.layer.cornerRadius = 5.0f;
    _sencedPass.layer.borderWidth = 1.0f;
    _sencedPass.layer.borderColor = [UIColor grayColor].CGColor;
    _sencedPass.layer.masksToBounds = YES;
    [self.view addSubview:_sencedPass];
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

#pragma mark -收件盘-
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_oldPassWord resignFirstResponder];
    [_firstPass resignFirstResponder];
    [_sencedPass resignFirstResponder];
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
