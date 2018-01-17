//
//  KGLoginViewController.m
//  FaceRecognition
//
//  Created by KG on 2017/12/13.
//  Copyright © 2017年 付正. All rights reserved.
//

#import "KGLoginViewController.h"
#import "KGTextField.h"
#import "KGForgetViewController.h"
#import "KGResigetViewController.h"
#import "KGTabBarViewController.h"


@interface KGLoginViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) KGTextField *userName;
@property (nonatomic,strong) KGTextField *passWord;

@end

@implementation KGLoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    iconImage.center = CGPointMake(KGscreenWidth/2, 130);
    iconImage.image = [UIImage imageNamed:@"KG"];
    [self.view addSubview:iconImage];
    
    [self setUserName];
    [self setPassWord];
    [self setButton];
}

#pragma mark -创建账号输入框-
- (void)setUserName{
    
    _userName = [[KGTextField alloc]initWithFrame:CGRectMake(100, 250, KGscreenWidth - 120, 30)];
    _userName.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"手机号" attributes:[self dictionaryWithFont:13 andColor:KGcolor(192, 193, 198, 1)]];
    _userName.font = KGFont(15);
    _userName.keyboardType = UIKeyboardTypePhonePad;
    _userName.delegate = self;
    _userName.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_userName];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,250, 80, 30)];
    titleLabel.text = @"手  机:";
    titleLabel.textAlignment = NSTextAlignmentRight;
    titleLabel.tintColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.view addSubview:titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 280, KGscreenWidth - 40, 1)];
    lineLabel.backgroundColor = KGCellDont;
    [self.view addSubview:lineLabel];
}

#pragma mark -创建密码输入框-
- (void)setPassWord{
    
    _passWord = [[KGTextField alloc]initWithFrame:CGRectMake(100, 290, KGscreenWidth - 120, 30)];
    _passWord.backgroundColor = [UIColor whiteColor];
    _passWord.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"密码" attributes:[self dictionaryWithFont:13 andColor:KGcolor(192, 193, 198, 1)]];
    _passWord.font = KGFont(15);
    _passWord.delegate = self;
    _passWord.secureTextEntry = YES;
    _passWord.rightView = [self setLookButton];
    _passWord.rightViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_passWord];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,290, 80, 30)];
    titleLabel.text = @"密  码:";
    titleLabel.textAlignment = NSTextAlignmentRight;
    titleLabel.tintColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.view addSubview:titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 320, KGscreenWidth - 40, 1)];
    lineLabel.backgroundColor = KGCellDont;
    [self.view addSubview:lineLabel];
}

#pragma mark -创建点击查看密码按钮-
- (UIButton *)setLookButton{
    UIButton *lookBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    lookBtu.frame = CGRectMake(0, 0, 30, 30);
    [lookBtu setImage:[UIImage imageNamed:@"眼睛"] forState:UIControlStateNormal];
    [lookBtu addTarget:self action:@selector(lookBtuClick:) forControlEvents:UIControlEventTouchUpInside];
    return lookBtu;
}

#pragma mark -查看密码按钮点击事件-
- (void)lookBtuClick:(UIButton *)sender{
    if (_passWord.secureTextEntry == NO) {
        _passWord.secureTextEntry = YES;
    }else{
        _passWord.secureTextEntry = NO;
    }
}

#pragma mark -收件盘-
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_userName resignFirstResponder];
    [_passWord resignFirstResponder];
}

#pragma mark -创建按钮-
- (void)setButton{
    
    [self setButtonWithTitle:@"登录" frame:CGRectMake(50,KGscreenHeight - 200,KGscreenWidth - 100,30) action:@selector(loginClick:) addView:self.view color:KGcolor(231, 99, 40, 1) titleColor:[UIColor whiteColor]];
    [self setButtonWithTitle:@"注册" frame:CGRectMake(50,KGscreenHeight - 170,150,30) action:@selector(regsiterClick:) addView:self.view color:[UIColor clearColor] titleColor:KGcolor(231, 99, 40, 1)];
    [self setButtonWithTitle:@"忘记密码" frame:CGRectMake(KGscreenWidth - 200,KGscreenHeight - 170,150,30) action:@selector(forgetClick:) addView:self.view color:[UIColor clearColor] titleColor:KGcolor(231, 99, 40, 1)];
}

#pragma mark -创建公共按钮-
- (void)setButtonWithTitle:(NSString *)title frame:(CGRect)frame action:(SEL)action addView:(UIView *)addview color:(UIColor *)color titleColor:(UIColor *)titleColor{
    
    UIButton *ButtonName = [[UIButton alloc]initWithFrame:frame];
    if ([title isEqualToString:@"注册"]) {
        ButtonName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }else if ([title isEqualToString:@"忘记密码"]){
        ButtonName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }else{
        ButtonName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    ButtonName.backgroundColor = color;
    [ButtonName setTitle:title forState:UIControlStateNormal];
    [ButtonName setTitleColor:titleColor forState:UIControlStateNormal];
    ButtonName.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    ButtonName.layer.cornerRadius = 5.0f;
    ButtonName.layer.borderColor = [UIColor clearColor].CGColor;
    ButtonName.layer.borderWidth = 1.0f;
    ButtonName.layer.masksToBounds = YES;
    [ButtonName addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [addview addSubview:ButtonName];
}

#pragma mark -登录按钮点击事件-
- (void)loginClick:(UIButton *)sender{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [[KGRequest sharedInstance] loginWithPhone:_userName.text passWord:_passWord.text succ:^(NSString *msg, id data) {
        if ([msg isEqualToString:@"登录成功"]) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            //跳转的时候切换Tabbar
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            window.rootViewController = [[KGTabBarViewController alloc] init];
            [[NSUserDefaults standardUserDefaults] setObject:_userName.text forKey:@"userPhone"];
            [[NSUserDefaults standardUserDefaults] setObject:data[@"id"] forKey:@"userId"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [weakSelf alertViewControllerTitle:@"提示" message:@"手机号或密码输入错误，请重新输入！" name:@"确定" type:0 preferredStyle:1];
        }
    } fail:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [weakSelf alertViewControllerTitle:@"提示" message:@"访问失败失败！" name:@"确定" type:0 preferredStyle:1];
    }];
}

#pragma mark -注册按钮点击事件-
- (void)regsiterClick:(UIButton *)sender{
    KGResigetViewController *controller = [[KGResigetViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -忘记密码按钮点击事件-
- (void)forgetClick:(UIButton *)sender{
    KGForgetViewController *controller = [[KGForgetViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -UITextFieldDelegate-
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _userName) {
        if (_userName.text.length >= 11) {
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
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
