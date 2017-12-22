//
//  KGAddRomeViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/20.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGAddRomeViewController.h"
#import "KGRoomView.h"

@interface KGAddRomeViewController ()<UITextFieldDelegate,KGRoomViewDelegate>

@property (nonatomic,strong) KGRoomTextField *roomTextField;
@property (nonatomic,strong) KGPriceTextField *priceTextField;
@property (nonatomic,strong) KGRoomView *room;
@property (nonatomic,strong) NSMutableArray *roomData;
@property (nonatomic,strong) KGRoomTextField *roomAdd;

@end

@implementation KGAddRomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加房型";
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *roomArr = @[@"001"];
    _roomData = [NSMutableArray arrayWithArray:roomArr];
    
    [self setUpRightNavButtonItmeTitle:@"提交" icon:nil];
    
    [self setLabelFromArray];
    [self.view addSubview:[self setRoomNameTextField]];
    [self setPriceTextFieldUI];
    [self setRoomButton];
    [self setRoomText];
}

- (void)rightBarItmeClick:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -添加房间信息-
- (void)setRoomText{
    _roomAdd = [[KGRoomTextField alloc]initWithFrame:CGRectMake(KGscreenWidth/4 + 20,385, KGscreenWidth - KGscreenWidth/4 - 50, 30)];
    _roomAdd.textColor = [UIColor grayColor];
    _roomAdd.placeholder = @"请输入房间号点击右侧添加按钮";
    _roomAdd.font = [UIFont systemFontOfSize:12.0f];
    _roomAdd.delegate = self;
    UIButton *close = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    [close setImage:[UIImage imageNamed:@"添加-3"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
    _roomAdd.rightView = close;
    _roomAdd.rightViewMode = UITextFieldViewModeAlways;
    _roomAdd.layer.cornerRadius = 5.0f;
    _roomAdd.layer.borderWidth = 1.0f;
    _roomAdd.layer.borderColor = [UIColor grayColor].CGColor;
    _roomAdd.layer.masksToBounds = YES;
    [self.view addSubview:_roomAdd];
}

- (void)closeClick:(UIButton *)sender{
    [_roomData addObject:_roomAdd.text];
    [_room sendArrayToCreateTextField:_roomData];
}

#pragma mark -创建房间按钮-
- (void)setRoomButton{
    _room = [[KGRoomView alloc]initWithFrame:CGRectMake(KGscreenWidth/4 + 20, 435, KGscreenWidth - KGscreenWidth/4 - 50, KGscreenHeight - 435 - 30)];
    _room.myDelegate = self;
    [_room sendArrayToCreateTextField:_roomData];
    [self.view addSubview:_room];
}

- (void)deleteTextField:(NSArray *)arr{
    _roomData = [NSMutableArray arrayWithArray:arr];
    [self alertViewControllerTitle:@"提示" message:@"确定删除该房型？" name:@"Yes" type:0 preferredStyle:1];
}

#pragma mark -创建提示标签-
- (void)setLabelFromArray{
    NSArray *titleLabelArr = @[@"房型名称",@"默认房价",@"周末房价",@"小时房价",@"房间号码"];
    for (int i = 0; i < titleLabelArr.count ; i++) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        titleLabel.center = CGPointMake(KGscreenWidth/4, 200 + 50 * i);
        titleLabel.text = titleLabelArr[i];
        titleLabel.tintColor = [UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.view addSubview:titleLabel];
    }
}

#pragma mark -添加房型名称-
- (UITextField *)setRoomNameTextField{
    _roomTextField = [[KGRoomTextField alloc]initWithFrame:CGRectMake(KGscreenWidth/4 + 20,  185, KGscreenWidth - KGscreenWidth/4 - 50, 30)];
    _roomTextField.placeholder = @"请填写房型名称";
    _roomTextField.textColor = [UIColor grayColor];
    _roomTextField.delegate = self;
    _roomTextField.font = [UIFont systemFontOfSize:15.0f];
    _roomTextField.layer.cornerRadius = 5.0f;
    _roomTextField.layer.borderWidth = 1.0f;
    _roomTextField.layer.borderColor = [UIColor grayColor].CGColor;
    _roomTextField.layer.masksToBounds = YES;
    return _roomTextField;
}

#pragma mark -房价设置UI-
- (void)setPriceTextFieldUI{
    NSArray *placeholderArr = @[@"请填写平日价格",@"请填写周末价格",@"请填写小时房的价格"];
    for (int i = 0; i < 3; i++) {
        _priceTextField = [[KGPriceTextField alloc]initWithFrame:CGRectMake(KGscreenWidth/4 + 20,  235 + 50 * i, KGscreenWidth - KGscreenWidth/4 - 50, 30)];
        _priceTextField.placeholder = placeholderArr[i];
        _priceTextField.textColor = [UIColor grayColor];
        _priceTextField.delegate = self;
        _priceTextField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"人民币"]];
        _priceTextField.leftViewMode = UITextFieldViewModeAlways;
        _priceTextField.rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"元"]];
        _priceTextField.rightViewMode = UITextFieldViewModeAlways;
        _priceTextField.font = [UIFont systemFontOfSize:15.0f];
        _priceTextField.layer.cornerRadius = 5.0f;
        _priceTextField.tag = 101 + i;
        _priceTextField.layer.borderWidth = 1.0f;
        _priceTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _priceTextField.layer.masksToBounds = YES;
        [self.view addSubview:_priceTextField];
    }
}

#pragma mark -收件盘-
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITextField *textField in self.view.subviews) {
        if (textField.tag >= 101 ) {
            [textField resignFirstResponder];
        }
    }
    for (KGRoomTextField *textField in _room.backView.subviews) {
        if (textField.tag >= 101) {
            [textField resignFirstResponder];
        }
    }
    [_roomTextField resignFirstResponder];
    [_roomAdd resignFirstResponder];
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
            [_room sendArrayToCreateTextField:_roomData];
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
