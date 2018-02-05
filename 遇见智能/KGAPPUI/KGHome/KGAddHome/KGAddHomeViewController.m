//
//  KGAddHomeViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/20.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGAddHomeViewController.h"
#import "KGAddRomeViewController.h"

@interface KGAddHomeViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) KGRoomTextField *infoTextField;
@property (nonatomic,strong) UIButton *finishButton;
@property (nonatomic,assign) BOOL isWrite;
@property (nonatomic,strong) UIButton *cityBut;
@property (nonatomic,strong) UIButton *pictureBtu;
@property (nonatomic,strong) UIImageView *pictureImage;
@property (nonatomic,strong) UIImageView *returnImage;

@end

@implementation KGAddHomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@门店",_type];
    self.view.backgroundColor = KGcolor(244, 246, 244, 1);
    _isWrite = NO;

    [self setUpLeftNavButtonItmeTitle:nil icon:@"Return"];
    [self pictureBtuAndImage];
    [self setLabelFromArray];
    [self setTextFieldFromArray];
    [self setFinishButton];

}


#pragma mark -创建添加门店提示语-
- (void)setLabelFromArray{
    NSArray *titleArr = @[@"所在城市:",@"门店名称:",@"详细地址:",@"前台电话:",@"店长电话:"];
    for (int i = 0; i < titleArr.count ; i++) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 210 + (50 * i), 80, 40)];
        titleLabel.text = titleArr[i];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.tintColor = [UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.view addSubview:titleLabel];
    }
}

#pragma mark -创建输入框-
- (void)setTextFieldFromArray{
    
    NSArray *placeholderArr = @[@"",@"请填写您的门店名称",@"请填写门店详细地址",@"请填写前台电话",@"请填写店长电话"];
    for (int i = 0; i < placeholderArr.count; i++) {
        if (i == 0) {
            _cityBut = [[UIButton alloc]initWithFrame:CGRectMake(79,  210 + 50 * i, KGscreenWidth - 80, 40)];
            _cityBut.backgroundColor = [UIColor whiteColor];
            [_cityBut addTarget:self action:@selector(cityClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_cityBut];
            _returnImage = [[UIImageView alloc]initWithFrame:CGRectMake(KGscreenWidth - 40, 220 + 50 * i, 20, 20)];
            _returnImage.image = [UIImage imageNamed:@"下一个"];
            [self.view addSubview:_returnImage];
            
        }else{
            _infoTextField = [[KGRoomTextField alloc]initWithFrame:CGRectMake(79,  210 + 50 * i, KGscreenWidth - 80, 40)];
            _infoTextField.placeholder = placeholderArr[i];
            _infoTextField.textColor = [UIColor grayColor];
            _infoTextField.backgroundColor = [UIColor whiteColor];
            _infoTextField.font = KGFont(15);
            _infoTextField.delegate = self;
            _infoTextField.tag = 101 + i;
            [self.view addSubview:_infoTextField];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 104) {
        if ([self userPhoneIsTrueOrFail:textField.text] == NO) {
            [self alertViewControllerTitle:@"提示" message:@"请输入合法手机号" name:@"确定" type:0 preferredStyle:1];
            textField.text = @"";
        }
    }else if (textField.tag == 105){
        if ([self userPhoneIsTrueOrFail:textField.text] == NO) {
            [self alertViewControllerTitle:@"提示" message:@"请输入合法电话号或手机号" name:@"确定" type:0 preferredStyle:1];
            textField.text = @"";
        }
    }else{
        
    }
}


- (BOOL)userPhoneIsTrueOrFail:(NSString *)msg{
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    //   NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:msg] == YES)
        || ([regextestcm evaluateWithObject:msg] == YES)
        || ([regextestct evaluateWithObject:msg] == YES)
        || ([regextestcu evaluateWithObject:msg] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
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

- (void)cityClick:(UIButton *)sender{
    [[MOFSPickerManager shareManger] showMOFSAddressPickerWithTitle:@"选择省市县" cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString *address, NSString *zipcode) {
        sender.titleEdgeInsets = UIEdgeInsetsMake(0,20, 0, 0);
        sender.titleLabel.font = KGFont(15);
        [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        sender.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [sender setTitle:address forState:UIControlStateNormal];
    } cancelBlock:^{
        
    }];
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


#pragma mark -完成按钮-
- (void)setFinishButton{
    _finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _finishButton.frame = CGRectMake(50, KGscreenHeight - 100, KGscreenWidth - 100, 30);
    [_finishButton setTitle:@"确定添加" forState:UIControlStateNormal];
    _finishButton.backgroundColor = KGcolor(231, 99, 40, 1);
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
    if ([_cityBut.titleLabel.text isEqualToString:@"点击选择城市"]) {
        _isWrite = NO;
        [self alertViewControllerTitle:@"提示" message:@"请选择所属城市" name:@"确定" type:0 preferredStyle:1];
    }
    if (_pictureImage.image == NULL) {
        _isWrite = NO;
        [self alertViewControllerTitle:@"提示" message:@"请选择酒店描述照片" name:@"确定" type:0 preferredStyle:1];
    }
    
    if (_isWrite == YES) {
        
        NSString *province = [[_cityBut.titleLabel.text componentsSeparatedByString:@"-"] firstObject];
        NSArray *cityArr = [_cityBut.titleLabel.text componentsSeparatedByString:@"-"];
        NSString *city = [cityArr[1] stringByAppendingString:[NSString stringWithFormat:@"-%@",cityArr[2]]];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if ([UIImagePNGRepresentation(_pictureImage.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"添加照片"])]){
            NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"Bigpicture"], 1);
            NSString *imageStr = [imageData base64EncodedStringWithOptions:0];
            [dic setObject:imageStr forKey:@"hotelPict"];
        }else{
            NSData *imageData = UIImageJPEGRepresentation(_pictureImage.image, 1);
            NSString *imageStr = [imageData base64EncodedStringWithOptions:0];
            [dic setObject:imageStr forKey:@"hotelPict"];
        }
        [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"] forKey:@"phoneNo"];
        [dic setObject:province forKey:@"province"];
        [dic setObject:city forKey:@"city"];
        
        for (UITextField *tmp in self.view.subviews) {
            if (tmp.tag == 102) {
                [dic setObject:tmp.text forKey:@"hotelName"];
            }else if (tmp.tag == 103){
                [dic setObject:tmp.text forKey:@"detailAddress"];
            }else if (tmp.tag == 104){
                [dic setObject:tmp.text forKey:@"customeServicePhoneNo"];
            }else if (tmp.tag == 105){
                [dic setObject:tmp.text forKey:@"hotelPhoneNo"];
            }
        }
        __weak typeof(self) weakSelf = self;
        if ([_type isEqualToString:@"添加"]) {
            [[KGRequest sharedInstance] addHotellMessageWithDictionary:dic succ:^(NSString *msg, id data) {
                if ([msg isEqualToString:@"添加成功"]) {
                    [self alertViewTitle:@"添加成功"];
                }else{
                    [weakSelf alertViewControllerTitle:@"提示" message:@"添加失败" name:@"确定" type:0 preferredStyle:1];
                }
            } fail:^(NSString *error) {
                [weakSelf alertViewControllerTitle:@"提示" message:@"网络出错，请重试" name:@"确定" type:0 preferredStyle:1];
            }];
        }else{
            [dic setObject:_hotelId forKey:@"hotelId"];
            [[KGRequest sharedInstance] changeHotelWithDictionary:dic succ:^(NSString *msg, id data) {
                if ([msg isEqualToString:@"修改酒店信息成功"]) {
                    [self alertViewTitle:@"修改成功"];
                }
            } fail:^(NSString *error) {
                [self alertViewControllerTitle:@"提示" message:@"修改失败" name:@"确定" type:0 preferredStyle:1];
            }];
        }
    }
}


#pragma mark -收件盘-
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITextField *textField in self.view.subviews) {
        if (textField.tag >= 101 ) {
            [textField resignFirstResponder];
        }
    }
    
}

- (void)alertViewTitle:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:1];
    UIAlertAction *okact = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [alert addAction:okact];
    
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
