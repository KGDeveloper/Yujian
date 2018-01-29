//
//  KGAddHomeViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/20.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGAddHomeViewController.h"
#import "KGAddRomeViewController.h"

@interface KGAddHomeViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate>

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
    
    self.title = @"添加门店";
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
        NSString *imageData = [UIImageJPEGRepresentation(_pictureImage.image, 1) base64Encoding];
        NSString *province = [[_cityBut.titleLabel.text componentsSeparatedByString:@"-"] firstObject];
        NSArray *cityArr = [_cityBut.titleLabel.text componentsSeparatedByString:@"-"];
        NSString *city = [cityArr[1] stringByAppendingString:[NSString stringWithFormat:@"-%@",cityArr[2]]];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"] forKey:@"phoneNo"];
        [dic setObject:imageData forKey:@"hotelPict"];
        [dic setObject:province forKey:@"province"];
        [dic setObject:city forKey:@"city"];
        
        for (UITextField *tmp in self.view.subviews) {
            if (tmp.tag == 101) {
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
                    [weakSelf alertViewControllerTitle:@"提示" message:@"添加成功" name:@"确定" type:0 preferredStyle:1];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else{
                    [weakSelf alertViewControllerTitle:@"提示" message:@"添加失败" name:@"确定" type:0 preferredStyle:1];
                }
            } fail:^(NSString *error) {
                [weakSelf alertViewControllerTitle:@"提示" message:@"网络出错，请重试" name:@"确定" type:0 preferredStyle:1];
            }];
        }else{
            [dic setObject:_hotelId forKey:@"hotelId"];
            [[KGRequest sharedInstance] changeHotelWithDictionary:dic succ:^(NSString *msg, id data) {
                
            } fail:^(NSString *error) {
                
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
