//
//  KGAddRomeViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/20.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGAddRomeViewController.h"
#import "KGRoomView.h"
#import "KGDetaialViewController.h"

@interface KGAddRomeViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIButton *roomType;
@property (nonatomic,strong) KGPriceTextField *priceTextField;
@property (nonatomic,strong) KGRoomView *room;
@property (nonatomic,strong) NSMutableArray *roomData;
@property (nonatomic,strong) KGRoomTextField *roomAdd;
@property (nonatomic,strong) UIImageView *returnImage;
@property (nonatomic,strong) UIPickerView *pickerView;//自定义pickerview
@property (nonatomic,strong) UIImageView *pictureImage;
@property (nonatomic,strong) UIButton *pictureBtu;
@property (nonatomic,strong) UIButton *toiletBtu;
@property (nonatomic,strong) UIButton *refrigeratorBtu;
@property (nonatomic,strong) UIButton *wifiBtu;
@property (nonatomic,strong) UIButton *breakfastBtu;
@property (nonatomic,strong) UIButton *additionalInformationBtu;
@property (nonatomic,strong) UIButton *bedTypeBtu;
@property (nonatomic,strong) UIButton *captaionBtu;
@property (nonatomic,assign) BOOL toilet;
@property (nonatomic,assign) BOOL refrigerator;
@property (nonatomic,assign) BOOL wifi;
@property (nonatomic,assign) BOOL breakfast;

@end

@implementation KGAddRomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加房型";
    self.view.backgroundColor = KGcolor(200, 200, 200, 1);
    _roomData = [NSMutableArray array];
    
    [self setUpRightNavButtonItmeTitle:@"提交" icon:nil];
    [self setUpLeftNavButtonItmeTitle:@"" icon:@"Return"];
    [self pictureBtuAndImage];
    [self initPickView];
    [self setLabelFromArray];
    [self setRoomNameTextField];
    [self setPriceTextFieldUI];
    [self setRoomButton];
    [self setRoomText];
    [self initButton];
}

- (void)initButton{
    _toiletBtu = [[UIButton alloc]initWithFrame:CGRectMake(10, 500,80, 40)];
    [_toiletBtu setTitle:@"独立卫浴" forState:UIControlStateNormal];
    _toiletBtu.backgroundColor = KGcolor(231, 99, 40, 1);
    [_toiletBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_toiletBtu];
    
    _refrigeratorBtu = [[UIButton alloc]initWithFrame:CGRectMake(10, 550,80, 40)];
    [_refrigeratorBtu setTitle:@"有无冰箱" forState:UIControlStateNormal];
    _refrigeratorBtu.backgroundColor = KGcolor(231, 99, 40, 1);
    [_refrigeratorBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_refrigeratorBtu];
    
    _wifiBtu = [[UIButton alloc]initWithFrame:CGRectMake(10, 600,80, 40)];
    [_wifiBtu setTitle:@"有无wifi" forState:UIControlStateNormal];
    _wifiBtu.backgroundColor = KGcolor(231, 99, 40, 1);
    [_wifiBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_wifiBtu];
    
    _breakfastBtu = [[UIButton alloc]initWithFrame:CGRectMake(10, 650,80, 40)];
    [_breakfastBtu setTitle:@"有无早餐" forState:UIControlStateNormal];
    _breakfastBtu.backgroundColor = KGcolor(231, 99, 40, 1);
    [_breakfastBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_breakfastBtu];
    
    _additionalInformationBtu = [[UIButton alloc]initWithFrame:CGRectMake(10, 650,80, 40)];
    [_additionalInformationBtu setTitle:@"附加信息" forState:UIControlStateNormal];
    _additionalInformationBtu.backgroundColor = KGcolor(231, 99, 40, 1);
    [_additionalInformationBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_additionalInformationBtu];
    
    _bedTypeBtu = [[UIButton alloc]initWithFrame:CGRectMake(10, 700,80, 40)];
    [_bedTypeBtu setTitle:@"设置床型" forState:UIControlStateNormal];
    _bedTypeBtu.backgroundColor = KGcolor(231, 99, 40, 1);
    [_bedTypeBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_bedTypeBtu];
    
    _captaionBtu = [[UIButton alloc]initWithFrame:CGRectMake(10, 750,80, 40)];
    [_captaionBtu setTitle:@"设置人数" forState:UIControlStateNormal];
    _captaionBtu.backgroundColor = KGcolor(231, 99, 40, 1);
    [_captaionBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_captaionBtu];
}

- (void)rightBarItmeClick:(UIButton *)sender{
    [self.navigationController popToViewController:[[KGDetaialViewController alloc]init] animated:YES];
}

- (void)initPickView{
    // 初始化pickerView
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, KGscreenHeight - 200, self.view.bounds.size.width, 200)];
    _pickerView.hidden = YES;
    _pickerView.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:_pickerView atIndex:99];
    
    //指定数据源和委托
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}

#pragma mark -添加房间信息-
- (void)setRoomText{
    _roomAdd = [[KGRoomTextField alloc]initWithFrame:CGRectMake(100,450, KGscreenWidth - 100, 40)];
    _roomAdd.textColor = [UIColor grayColor];
    _roomAdd.backgroundColor = [UIColor whiteColor];
    _roomAdd.placeholder = @"请输入房间号点击右侧添加按钮";
    _roomAdd.font = [UIFont systemFontOfSize:13.0f];
    _roomAdd.delegate = self;
    UIButton *close = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 20, 20)];
    [close setImage:[UIImage imageNamed:@"添加-3"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
    _roomAdd.rightView = close;
    _roomAdd.rightViewMode = UITextFieldViewModeAlways;
//    _roomAdd.layer.cornerRadius = 5;
//    _roomAdd.layer.masksToBounds = YES;
    [self.view addSubview:_roomAdd];
}

- (void)closeClick:(UIButton *)sender{
    if ([self deptNumInputShouldNumber:_roomAdd.text] == YES) {
        [_roomData addObject:_roomAdd.text];
        _room.dataArr = _roomData;
        [_room.roomView reloadData];
    }else{
        [self alertViewControllerTitle:@"提示" message:@"请输入数字" name:@"确定" type:0 preferredStyle:1];
    }
}

- (BOOL) deptNumInputShouldNumber:(NSString *)str
{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

#pragma mark -创建房间按钮-
- (void)setRoomButton{
    _room = [[KGRoomView alloc]initWithFrame:CGRectMake(100, 500, KGscreenWidth - 100, KGscreenHeight - 500)];
    [self.view addSubview:_room];
}

- (void)deleteTextField:(NSArray *)arr{
    _roomData = [NSMutableArray arrayWithArray:arr];
//    [self alertViewControllerTitle:@"提示" message:@"确定删除该房型？" name:@"Yes" type:0 preferredStyle:1];
}

#pragma mark -创建提示标签-
- (void)setLabelFromArray{
    NSArray *titleLabelArr = @[@"房型名称:",@"默认房价:",@"周末房价:",@"小时房价:",@"押金金额:",@"房间号码:"];
    for (int i = 0; i < titleLabelArr.count ; i++) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 200 + 50 * i, 100, 40)];
        titleLabel.text = titleLabelArr[i];
        titleLabel.tintColor = [UIColor grayColor];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [self.view addSubview:titleLabel];
    }
}

#pragma mark -添加房型名称-
- (void)setRoomNameTextField{
    _roomType = [[UIButton alloc]initWithFrame:CGRectMake(100,  200, KGscreenWidth - 100, 40)];
    _roomType.backgroundColor = [UIColor whiteColor];
    [_roomType addTarget:self action:@selector(cityClick:) forControlEvents:UIControlEventTouchUpInside];
//    _roomType.layer.cornerRadius = 5;
//    _roomType.layer.masksToBounds = YES;
    [self.view addSubview:_roomType];
    _returnImage = [[UIImageView alloc]initWithFrame:CGRectMake(KGscreenWidth - 20, 210, 20, 20)];
    _returnImage.image = [UIImage imageNamed:@"下一个"];
    [self.view addSubview:_returnImage];
}

- (void)cityClick:(UIButton *)sender{
    _pickerView.hidden = NO;
}

#pragma mark -房价设置UI-
- (void)setPriceTextFieldUI{
    NSArray *placeholderArr = @[@"请填写平日价格",@"请填写周末价格",@"请填写小时房的价格",@"请填写押金"];
    for (int i = 0; i < placeholderArr.count; i++) {
        _priceTextField = [[KGPriceTextField alloc]initWithFrame:CGRectMake(100,  250 + 50 * i, KGscreenWidth - 100, 40)];
        _priceTextField.backgroundColor = [UIColor whiteColor];
        _priceTextField.placeholder = placeholderArr[i];
        _priceTextField.textColor = [UIColor grayColor];
        _priceTextField.delegate = self;
        _priceTextField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"人民币"]];
        _priceTextField.leftViewMode = UITextFieldViewModeAlways;
        _priceTextField.rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"元"]];
        _priceTextField.rightViewMode = UITextFieldViewModeAlways;
        _priceTextField.font = [UIFont systemFontOfSize:13.0f];
        _priceTextField.tag = 101 + i;
//        _priceTextField.layer.cornerRadius = 5;
//        _priceTextField.layer.masksToBounds = YES;
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
    [_roomAdd resignFirstResponder];
    _pickerView.hidden = YES;
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
            
        }];
        
        UIAlertAction *canalAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:sureAct];
        [alert addAction:canalAct];
    }
    [self presentViewController:alert animated:YES completion:nil];
    
}

//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _typeArr.count;
}

//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _typeArr[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _roomType.titleEdgeInsets = UIEdgeInsetsMake(0,20, 0, 0);
    _roomType.titleLabel.font = KGFont(13);
    [_roomType setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _roomType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_roomType setTitle:_typeArr[row] forState:UIControlStateNormal];
}

- (void)pictureBtuAndImage{
    
    UILabel *backLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 66, KGscreenWidth, 130)];
    backLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backLabel];
    NSInteger heightNv;
    if (KGDevice_Is_iPhoneX == YES) {
        heightNv = 88;
    }else{
        heightNv = 64;
    }
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, heightNv + 2, 80, 40)];
    titleLabel.text = @"选择照片";
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentRight;
    titleLabel.tintColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.view addSubview:titleLabel];
    
    _pictureImage = [[UIImageView alloc] initWithFrame:CGRectMake(20,heightNv + 42,100, 60)];
    _pictureImage.image = [UIImage imageNamed:@"添加照片"];
    _pictureImage.layer.cornerRadius = 5;
    _pictureImage.layer.masksToBounds = YES;
    [self.view addSubview:_pictureImage];
    
    _pictureBtu = [[UIButton alloc]initWithFrame:_pictureImage.frame];
    [_pictureBtu addTarget:self action:@selector(pictureClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pictureBtu];
}

- (void)pictureClick:(UIButton *)sender{
    //调用系统相册的类
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    
    
    //设置选取的照片是否可编辑
    pickerController.allowsEditing = YES;
    //设置相册呈现的样式
    pickerController.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;//图片分组列表样式
    //照片的选取样式还有以下两种
    //UIImagePickerControllerSourceTypePhotoLibrary,直接全部呈现系统相册
    //UIImagePickerControllerSourceTypeCamera//调取摄像头
    
    //选择完成图片或者点击取消按钮都是通过代理来操作我们所需要的逻辑过程
    pickerController.delegate = self;
    //使用模态呈现相册
    [self.navigationController presentViewController:pickerController animated:YES completion:^{
        
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //info是所选择照片的信息
    
    //    UIImagePickerControllerEditedImage//编辑过的图片
    //    UIImagePickerControllerOriginalImage//原图
    
    _pictureImage.image = info[@"UIImagePickerControllerEditedImage"];
    
    //使用模态返回到软件界面
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
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
