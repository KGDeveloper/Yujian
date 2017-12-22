//
//  KGAddHomeViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/20.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGAddHomeViewController.h"
#import "KGAddRomeViewController.h"

@interface KGAddHomeViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) KGRoomTextField *infoTextField;
@property (nonatomic,strong) UIButton *finishButton;
@property (nonatomic,assign) BOOL isWrite;

@end

@implementation KGAddHomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加门店";
    self.view.backgroundColor = [UIColor whiteColor];
    _isWrite = NO;
    
    UILabel *LabelName = [[UILabel alloc]initWithFrame:CGRectMake(30, 165,KGscreenWidth - 50, 270)];
    LabelName.backgroundColor = KGcolor(201, 216, 223, 1);
    LabelName.layer.borderWidth = 1.0f;
    LabelName.layer.borderColor = [UIColor grayColor].CGColor;
    LabelName.layer.cornerRadius = 5.0f;
    LabelName.layer.masksToBounds = YES;
    [self.view addSubview:LabelName];
    
    [self setLabelFromArray];
    [self setTextFieldFromArray];
    [self setFinishButton];

}


#pragma mark -创建添加门店提示语-
- (void)setLabelFromArray{
    NSArray *titleArr = @[@"门店名称",@"所在省份",@"所在城市",@"详细地址",@"前台电话"];
    for (int i = 0; i < titleArr.count ; i++) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        titleLabel.center = CGPointMake(KGscreenWidth/4, 200 + 50 * i);
        titleLabel.text = titleArr[i];
        titleLabel.tintColor = [UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.view addSubview:titleLabel];
    }
}

#pragma mark -创建输入框-
- (void)setTextFieldFromArray{
    
    NSArray *placeholderArr = @[@"请填写您的门店名称",@"请填写门店所在省份",@"请填写门店所在市区",@"请填写门店详细地址",@"请填写前台电话"];
    for (int i = 0; i < placeholderArr.count; i++) {
        _infoTextField = [[KGRoomTextField alloc]initWithFrame:CGRectMake(KGscreenWidth/4 + 20,  185 + 50 * i, KGscreenWidth - KGscreenWidth/4 - 50, 30)];
        _infoTextField.placeholder = placeholderArr[i];
        _infoTextField.textColor = [UIColor grayColor];
        _infoTextField.font = [UIFont systemFontOfSize:15.0f];
        _infoTextField.delegate = self;
        _infoTextField.tag = 101 + i;
        _infoTextField.layer.cornerRadius = 5.0f;
        _infoTextField.layer.borderWidth = 1.0f;
        _infoTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _infoTextField.layer.masksToBounds = YES;
        [self.view addSubview:_infoTextField];
    }
}

#pragma mark -完成按钮-
- (void)setFinishButton{
    _finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _finishButton.frame = CGRectMake(50, KGscreenHeight - 200, KGscreenWidth - 100, 30);
    [_finishButton setTitle:@"确定添加" forState:UIControlStateNormal];
    _finishButton.backgroundColor = KGOrangeColor;
    [_finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_finishButton addTarget:self action:@selector(finishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _finishButton.layer.cornerRadius = 5.0f;
    _finishButton.layer.masksToBounds = YES;
    [self.view addSubview:_finishButton];
    
}

#pragma mark -确定按钮的点击事件-
- (void)finishButtonClick:(UIButton *)sender{
    for (UITextField *textField in self.view.subviews) {
        if (textField.tag >= 101) {
            if ([textField.text isEqualToString: @""]) {
                [self alertViewControllerTitle:@"提示" message:@"请认真填写信息，信息不完整！" name:@"确定" type:0 preferredStyle:1];
                _isWrite = NO;
            }else{
                _isWrite = YES;
            }
        }
    }
    if (_isWrite == YES) {
        KGAddRomeViewController *rome = [[KGAddRomeViewController alloc]init];
        [self.navigationController pushViewController:rome animated:YES];
    }
}

#pragma mark -警告框-
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
    for (UITextField *textField in self.view.subviews) {
        if (textField.tag >= 101 ) {
            [textField resignFirstResponder];
        }
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
