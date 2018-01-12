//
//  KGPhoneViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGPhoneViewController.h"

@interface KGPhoneViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) KGPriceTextField *phoneTextField;
@property (nonatomic,strong) KGPriceTextField *oldPhone;
@property (nonatomic,strong) KGPriceTextField *phoneText;
@property (nonatomic,strong) KGPriceTextField *phoneTest;
@property (nonatomic,strong) UIButton *oldBtu;
@property (nonatomic,strong) UIButton *sendBtu;
@property (nonatomic,assign) BOOL oldSend;
@property (nonatomic,assign) BOOL send;
@property (nonatomic,assign) BOOL firstSucc;
@property (nonatomic,assign) BOOL sencedSucc;
@property (nonatomic,assign) NSInteger one;
@property (nonatomic,assign) NSInteger two;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation KGPhoneViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改手机";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _oldSend = NO;
    _send = NO;
    _firstSucc = NO;
    _sencedSucc = NO;
    _one = 60;
    _two = 60;
    
    [self setOldPhone];
    [self setOldPhoneTest];
    [self newPhoneTextField];
    [self newTestText];
    [self initJoinOutBtu];
    
    [self sendTestTimer];
    
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

#pragma mark -旧手机号-
- (void)setOldPhone{
    _phoneTextField = [[KGPriceTextField alloc]initWithFrame:CGRectMake(80, 200, KGscreenWidth - 100, 30)];
    _phoneTextField.placeholder = @"请输入旧手机号";
    _phoneTextField.textColor = [UIColor grayColor];
    _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneTextField.delegate = self;
    _phoneTextField.font = [UIFont systemFontOfSize:13.0f];
    _phoneTextField.returnKeyType = UIReturnKeyGo;
    _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
    _phoneTextField.layer.cornerRadius = 5.0f;
    _phoneTextField.layer.masksToBounds = YES;
    [self.view addSubview:_phoneTextField];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 200, 50, 30)];
    titleLabel.textColor = KGcolor(101, 101, 101, 1);
    titleLabel.text = @"手   机";
    titleLabel.font = KGFont(13);
    [self.view addSubview:titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 230, KGscreenWidth - 40, 1)];
    lineLabel.backgroundColor = KGcolor(200, 200, 200, 1);
    [self.view addSubview:lineLabel];
}

#pragma mark -旧手机号验证-
- (void)setOldPhoneTest{
    _oldPhone = [[KGPriceTextField alloc]initWithFrame:CGRectMake(80, 250, KGscreenWidth - 230, 30)];
    _oldPhone.placeholder = @"请输入验证码";
    _oldPhone.textColor = [UIColor grayColor];
    _oldPhone.keyboardType = UIKeyboardTypePhonePad;
    _oldPhone.delegate = self;
    _oldPhone.font = [UIFont systemFontOfSize:13.0f];
    _oldPhone.returnKeyType = UIReturnKeyGo;
    _oldPhone.clearButtonMode = UITextFieldViewModeAlways;
    _oldPhone.layer.cornerRadius = 5.0f;
    _oldPhone.layer.masksToBounds = YES;
    [self.view addSubview:_oldPhone];
    
    _oldBtu = [[UIButton alloc]initWithFrame:CGRectMake(KGscreenWidth - 120, 245, 100, 30)];
    [_oldBtu setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_oldBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _oldBtu.backgroundColor = KGcolor(231, 99, 40, 1);
    _oldBtu.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    _oldBtu.layer.cornerRadius = 5.0f;
    _oldBtu.layer.borderColor = [UIColor clearColor].CGColor;
    _oldBtu.layer.borderWidth = 1.0f;
    _oldBtu.layer.masksToBounds = YES;
    [_oldBtu addTarget:self action:@selector(buttonNameClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_oldBtu];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 250, 50, 30)];
    titleLabel.textColor = KGcolor(101, 101, 101, 1);
    titleLabel.text = @"验证码";
    titleLabel.font = KGFont(13);
    [self.view addSubview:titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 280, KGscreenWidth - 40, 1)];
    lineLabel.backgroundColor = KGcolor(200, 200, 200, 1);
    [self.view addSubview:lineLabel];
}

#pragma mark -输入新手机号-
- (void)newPhoneTextField{
    _phoneText = [[KGPriceTextField alloc]initWithFrame:CGRectMake(80, 300, KGscreenWidth - 100, 30)];
    _phoneText.placeholder = @"请输入新手机号";
    _phoneText.textColor = [UIColor grayColor];
    _phoneText.keyboardType = UIKeyboardTypePhonePad;
    _phoneText.delegate = self;
    _phoneText.font = [UIFont systemFontOfSize:13.0f];
    _phoneText.returnKeyType = UIReturnKeyGo;
    _phoneText.clearButtonMode = UITextFieldViewModeAlways;
    _phoneText.layer.cornerRadius = 5.0f;
    _phoneText.layer.masksToBounds = YES;
    [self.view addSubview:_phoneText];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 300, 50, 30)];
    titleLabel.textColor = KGcolor(101, 101, 101, 1);
    titleLabel.text = @"手  机";
    titleLabel.font = KGFont(13);
    [self.view addSubview:titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 330, KGscreenWidth - 40, 1)];
    lineLabel.backgroundColor = KGcolor(200, 200, 200, 1);
    [self.view addSubview:lineLabel];
}

#pragma mark -新手机号验证码-
- (void)newTestText{
    _phoneTest = [[KGPriceTextField alloc]initWithFrame:CGRectMake(80, 350, KGscreenWidth - 230, 30)];
    _phoneTest.placeholder = @"请输入验证码";
    _phoneTest.textColor = [UIColor grayColor];
    _phoneTest.keyboardType = UIKeyboardTypePhonePad;
    _phoneTest.delegate = self;
    _phoneTest.font = [UIFont systemFontOfSize:13.0f];
    _phoneTest.returnKeyType = UIReturnKeyGo;
    _phoneTest.clearButtonMode = UITextFieldViewModeAlways;
    _phoneTest.layer.cornerRadius = 5.0f;
    _phoneTest.layer.masksToBounds = YES;
    [self.view addSubview:_phoneTest];
    
    _sendBtu = [[UIButton alloc]initWithFrame:CGRectMake(KGscreenWidth - 120, 345, 100, 30)];
    [_sendBtu setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_sendBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sendBtu.backgroundColor = KGcolor(231, 99, 40, 1);
    _sendBtu.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    _sendBtu.layer.cornerRadius = 5.0f;
    _sendBtu.layer.borderColor = [UIColor clearColor].CGColor;
    _sendBtu.layer.borderWidth = 1.0f;
    _sendBtu.layer.masksToBounds = YES;
    [_sendBtu addTarget:self action:@selector(sendBtuClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendBtu];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 350, 50, 30)];
    titleLabel.textColor = KGcolor(101, 101, 101, 1);
    titleLabel.text = @"验证码";
    titleLabel.font = KGFont(13);
    [self.view addSubview:titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 380, KGscreenWidth - 40, 1)];
    lineLabel.backgroundColor = KGcolor(200, 200, 200, 1);
    [self.view addSubview:lineLabel];
}


#pragma mark -提交按钮点击事件-
- (void)jionOutClick:(UIButton *)sender{
    [self sendSMSFrameText:_oldPhone.text phone:_phoneTextField.text];
    [self sendSMSFrameText:_phoneTest.text phone:_phoneText.text];
    
    if (_firstSucc == YES && _sencedSucc == YES) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (_firstSucc == NO){
        [self alertViewControllerTitle:@"提示" message:@"旧手机号码验证码错误" name:@"确定" type:0 preferredStyle:1];
    }else{
        [self alertViewControllerTitle:@"提示" message:@"新手机号码验证码错误" name:@"确定" type:0 preferredStyle:1];
    }
}

#pragma mark -旧手机号发送验证码-
- (void)buttonNameClick:(UIButton *)sender{
    if (_phoneTextField.text.length == 11) {
        [self sendSMS:_phoneTextField.text];
        _oldSend = YES;
        //开启定时器
        [_timer setFireDate:[NSDate distantPast]];
    }else{
        [self alertViewControllerTitle:@"提示" message:@"请输入正确的手机号" name:@"确定" type:0 preferredStyle:1];
    }
}

#pragma mark -新手机号发送验证码-
- (void)sendBtuClick:(UIButton *)sender{
    if (_phoneText.text.length == 11) {
        [self sendSMS:_phoneText.text];
        _send = YES;
        [_timer setFireDate:[NSDate distantPast]];
    }else{
        [self alertViewControllerTitle:@"提示" message:@"请输入正确的手机号" name:@"确定" type:0 preferredStyle:1];
    }
    
}

#pragma mark -发送验证码倒计时-
- (void)sendTestTimer{
    //定时器(第一中创建方法)
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerUser) userInfo:nil repeats:YES];
    
    //把定时器加到运行循环里面()
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

#pragma mark -定时器的方法-
- (void)timerUser{
    if (_oldSend == YES) {
        [_oldBtu setTitle:[NSString stringWithFormat:@"倒计时:%ld",(long)_one] forState:UIControlStateNormal];
        _oldBtu.backgroundColor = [UIColor grayColor];
        _oldBtu.enabled = NO;
        _one --;
        if (_one == 0) {
            [_oldBtu setTitle:@"发送验证码" forState:UIControlStateNormal];
            _oldBtu.backgroundColor = KGOrangeColor;
            _oldBtu.enabled = YES;
            _oldSend = NO;
        }
    }
    if (_send == YES) {
        [_sendBtu setTitle:[NSString stringWithFormat:@"倒计时:%ld",(long)_two] forState:UIControlStateNormal];
        _sendBtu.backgroundColor = [UIColor grayColor];
        _sendBtu.enabled = NO;
        _two --;
        if (_two == 0) {
            [_sendBtu setTitle:@"发送验证码" forState:UIControlStateNormal];
            _sendBtu.backgroundColor = KGOrangeColor;
            _sendBtu.enabled = YES;
            _send = NO;
        }
    }
    if (_one == 0 && _two == 0) {
        [_timer setFireDate:[NSDate distantFuture]];
        _one = 60;
        _two = 60;
    }
}

#pragma mark -发送验证码-
- (void)sendSMS:(NSString *)phone{
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phone zone:@"86"  result:^(NSError *error) {
        if (!error)
        {
            // 请求成功
        }
        else
        {
            // error
        }
    }];
}

#pragma mark -验证码验证-
- (void)sendSMSFrameText:(NSString *)message phone:(NSString *)phone{
    [SMSSDK commitVerificationCode:message phoneNumber:phone zone:@"86" result:^(NSError *error) {
        if (!error)
        {
            // 验证成功
            if ([phone isEqualToString:_phoneTextField.text]) {
                _firstSucc = YES;
            }else{
                _sencedSucc = YES;
            }
        }
        else
        {
            // error
        }
    }];
}

#pragma mark -收件盘-
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_phoneTextField resignFirstResponder];
    [_oldPhone resignFirstResponder];
    [_phoneText resignFirstResponder];
    [_phoneTest resignFirstResponder];

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
