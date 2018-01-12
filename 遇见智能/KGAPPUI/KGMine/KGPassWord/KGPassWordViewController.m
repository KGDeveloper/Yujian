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
    self.view.backgroundColor = [UIColor whiteColor];

    [self setOldPass];
    [self setNewPass];
    [self setSureNewPass];
    [self initJoinOutBtu];
    [self setUpLeftNavButtonItmeTitle:@"" icon:@"Return"];

}

- (void)initJoinOutBtu{
    UIButton *jionOutBtu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, KGscreenWidth - 100, 30)];
    jionOutBtu.center = CGPointMake(KGscreenWidth/2,KGscreenHeight - 100);
    [jionOutBtu setTitle:@"确定" forState:UIControlStateNormal];
    jionOutBtu.backgroundColor = KGcolor(231, 99, 40, 1);
    [jionOutBtu setTitleColor:KGcolor(255, 255, 255, 1) forState:UIControlStateNormal];
    [jionOutBtu addTarget:self action:@selector(jionOutClick:) forControlEvents:UIControlEventTouchUpInside];
    jionOutBtu.layer.cornerRadius = 5;
    jionOutBtu.layer.masksToBounds = YES;
    [self.view addSubview:jionOutBtu];
}

- (void)jionOutClick:(UIButton *)sender{
    if (_oldPassWord.text.length < 1) {
        [self alertViewControllerTitle:@"提示" message:@"请输入旧密码" name:@"确定" type:0 preferredStyle:1];
    }else if (_firstPass.text.length < 1){
        [self alertViewControllerTitle:@"提示" message:@"请输入新密码" name:@"确定" type:0 preferredStyle:1];
    }else if (_sencedPass.text.length < 1){
        [self alertViewControllerTitle:@"提示" message:@"请再次确认新密码" name:@"确定" type:0 preferredStyle:1];
    }else{
        if ([_firstPass.text isEqualToString:_sencedPass.text]) {
            [[KGRequest sharedInstance] updateHotelMessageWithnewPassWord:_firstPass.text userId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] succ:^(NSString *msg, id data) {
                if ([msg isEqualToString:@"修改成功"]) {
                    [self alertViewControllerTitle:@"提示" message:@"修改成功,请返回登录页面,使用新密码登录" name:@"确定" type:0 preferredStyle:1];
                    //                        // 验证成功
                    //                        [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self alertViewControllerTitle:@"提示" message:@"修改失败" name:@"确定" type:0 preferredStyle:1];
                }
            } fail:^(NSString *error) {
                [self alertViewControllerTitle:@"提示" message:@"访问服务器失败" name:@"确定" type:0 preferredStyle:1];
            }];
        }else{
            [self alertViewControllerTitle:@"提示" message:@"两次输入的新密码不一样，请查看确认！" name:@"确定" type:0 preferredStyle:1];
        }
    }
}

#pragma mark -创建旧密码-
- (void)setOldPass{
    _oldPassWord = [[KGPriceTextField alloc]initWithFrame:CGRectMake(90, 200, KGscreenWidth - 130, 30)];
    _oldPassWord.placeholder = @"请输入旧密码";
    _oldPassWord.textColor = [UIColor grayColor];
    _oldPassWord.delegate = self;
    _oldPassWord.font = [UIFont systemFontOfSize:13.0f];
    _oldPassWord.returnKeyType = UIReturnKeyGo;
    _oldPassWord.clearButtonMode = UITextFieldViewModeAlways;
    _oldPassWord.layer.cornerRadius = 5.0f;
    _oldPassWord.layer.masksToBounds = YES;
    [self.view addSubview:_oldPassWord];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 200, 80, 30)];
    titleLabel.textColor = KGcolor(101, 101, 101, 1);
    titleLabel.text = @"原 密 码:";
    titleLabel.font = KGFont(13);
    [self.view addSubview:titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 230, KGscreenWidth - 40, 1)];
    lineLabel.backgroundColor = KGcolor(200, 200, 200, 1);
    [self.view addSubview:lineLabel];
}

#pragma mark -创建新密码-
- (void)setNewPass{
    _firstPass = [[KGPriceTextField alloc]initWithFrame:CGRectMake(90, 250, KGscreenWidth - 130, 30)];
    _firstPass.placeholder = @"请输入新密码";
    _firstPass.textColor = [UIColor grayColor];
    _firstPass.delegate = self;
    _firstPass.font = [UIFont systemFontOfSize:13.0f];
    _firstPass.returnKeyType = UIReturnKeyGo;
    _firstPass.clearButtonMode = UITextFieldViewModeAlways;
    _firstPass.layer.cornerRadius = 5.0f;
    _firstPass.layer.masksToBounds = YES;
    [self.view addSubview:_firstPass];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 250, 80, 30)];
    titleLabel.textColor = KGcolor(101, 101, 101, 1);
    titleLabel.text = @"设置密码:";
    titleLabel.font = KGFont(13);
    [self.view addSubview:titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 280, KGscreenWidth - 40, 1)];
    lineLabel.backgroundColor = KGcolor(200, 200, 200, 1);
    [self.view addSubview:lineLabel];
}

#pragma mark -确认新密码-
- (void)setSureNewPass{
    _sencedPass = [[KGPriceTextField alloc]initWithFrame:CGRectMake(90, 300, KGscreenWidth - 130, 30)];
    _sencedPass.placeholder = @"请确认新密码";
    _sencedPass.textColor = [UIColor grayColor];
    _sencedPass.delegate = self;
    _sencedPass.font = [UIFont systemFontOfSize:13.0f];
    _sencedPass.returnKeyType = UIReturnKeyGo;
    _sencedPass.clearButtonMode = UITextFieldViewModeAlways;
    _sencedPass.layer.cornerRadius = 5.0f;
    _sencedPass.layer.masksToBounds = YES;
    [self.view addSubview:_sencedPass];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 300, 80, 30)];
    titleLabel.textColor = KGcolor(101, 101, 101, 1);
    titleLabel.text = @"再次输入:";
    titleLabel.font = KGFont(13);
    [self.view addSubview:titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 330, KGscreenWidth - 40, 1)];
    lineLabel.backgroundColor = KGcolor(200, 200, 200, 1);
    [self.view addSubview:lineLabel];
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
