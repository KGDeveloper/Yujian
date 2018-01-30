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
#import "KGRoomTextView.h"

@interface KGAddRomeViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,KGRoomTextViewDelegate>

@property (nonatomic,strong) UIButton *roomType;
@property (nonatomic,strong) KGPriceTextField *priceTextField;
@property (nonatomic,strong) KGPriceTextField *priceHotel;
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
@property (nonatomic,strong) NSMutableDictionary *postDic;
@property (nonatomic,strong) KGRoomTextView *roomDetaile;
@property (nonatomic,assign) BOOL isWrite;
@property (nonatomic,assign) BOOL isChoose;

@end

@implementation KGAddRomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加房型";
    self.view.backgroundColor = KGcolor(244, 246, 244, 1);
    _roomData = [NSMutableArray array];
    _postDic = [NSMutableDictionary dictionary];
    _toilet = NO;
    _refrigerator = NO;
    _wifi = NO;
    _breakfast = NO;
    _isWrite = NO;
    _isChoose = NO;
    
    [self setUpRightNavButtonItmeTitle:@"提交" icon:nil];
    [self setUpLeftNavButtonItmeTitle:@"" icon:@"Return"];
    [self pictureBtuAndImage];
    [self setLabelFromArray];
    [self setRoomNameTextField];
    [self setPriceTextFieldUI];
    [self setRoomButton];
    if ([_type isEqualToString:@"修改"]) {
        
    }else{
        [self setRoomText];
    }
    [self initButton];
    [self initPickView];
    [self initRoomDetaial];
}

#pragma mark -设置附加信息等参数View-
- (void)initRoomDetaial{
    _roomDetaile = [[KGRoomTextView alloc]initWithFrame:self.view.frame];
    _roomDetaile.hidden = YES;
    _roomDetaile.Mydelegate = self;
    [self.view insertSubview:_roomDetaile atIndex:999];
}

#pragma mark -设置附加信息等参数按钮-
- (void)initButton{
    
    NSInteger width = (KGscreenWidth - 40)/3;

 #pragma mark -设置附加信息等参数-
    _toiletBtu = [[UIButton alloc]initWithFrame:CGRectMake(10, 310,width, 30)];
    [_toiletBtu setTitle:@"独立卫浴" forState:UIControlStateNormal];
    _toiletBtu.backgroundColor = [UIColor grayColor];
    _toiletBtu.titleLabel.font = KGFont(11);
    [_toiletBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_toiletBtu addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_toiletBtu];
#pragma mark -设置附加信息等参数-
    _refrigeratorBtu = [[UIButton alloc]initWithFrame:CGRectMake(20 + width, 310,width, 30)];
    [_refrigeratorBtu setTitle:@"有无冰箱" forState:UIControlStateNormal];
    _refrigeratorBtu.backgroundColor = [UIColor grayColor];
    _refrigeratorBtu.titleLabel.font = KGFont(11);
    [_refrigeratorBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_refrigeratorBtu addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refrigeratorBtu];
#pragma mark -设置附加信息等参数-
    _wifiBtu = [[UIButton alloc]initWithFrame:CGRectMake(30 + width*2, 310,width, 30)];
    [_wifiBtu setTitle:@"有无wifi" forState:UIControlStateNormal];
    _wifiBtu.backgroundColor = [UIColor grayColor];
    _wifiBtu.titleLabel.font = KGFont(11);
    [_wifiBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_wifiBtu addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wifiBtu];
#pragma mark -设置附加信息等参数-
    _breakfastBtu = [[UIButton alloc]initWithFrame:CGRectMake(10, 350,width, 30)];
    [_breakfastBtu setTitle:@"有无早餐" forState:UIControlStateNormal];
    _breakfastBtu.backgroundColor = [UIColor grayColor];
    _breakfastBtu.titleLabel.font = KGFont(11);
    [_breakfastBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_breakfastBtu addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_breakfastBtu];
#pragma mark -设置附加信息等参数-
    _additionalInformationBtu = [[UIButton alloc]initWithFrame:CGRectMake(20 + width, 350,width, 30)];
    [_additionalInformationBtu setTitle:@"附加信息" forState:UIControlStateNormal];
    _additionalInformationBtu.backgroundColor = [UIColor grayColor];
    _additionalInformationBtu.titleLabel.font = KGFont(11);
    [_additionalInformationBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_additionalInformationBtu addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_additionalInformationBtu];
#pragma mark -设置附加信息等参数-
    _bedTypeBtu = [[UIButton alloc]initWithFrame:CGRectMake(30 + width*2, 350,width, 30)];
    [_bedTypeBtu setTitle:@"设置床型" forState:UIControlStateNormal];
    _bedTypeBtu.backgroundColor = [UIColor grayColor];
    _bedTypeBtu.titleLabel.font = KGFont(11);
    [_bedTypeBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_bedTypeBtu addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bedTypeBtu];
#pragma mark -设置附加信息等参数-
    _captaionBtu = [[UIButton alloc]initWithFrame:CGRectMake(10, 390,width, 30)];
    [_captaionBtu setTitle:@"设置人数(*必填)" forState:UIControlStateNormal];
    _captaionBtu.backgroundColor = [UIColor grayColor];
    _captaionBtu.titleLabel.font = KGFont(11);
    [_captaionBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_captaionBtu addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_captaionBtu];
}

#pragma mark -设置附加信息等参数的点击事件-
- (void)buttonClick:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"独立卫浴"]) {
        if (_toilet == YES) {
            sender.backgroundColor = [UIColor grayColor];
            _toilet = NO;
        }else{
            sender.backgroundColor = KGcolor(231, 99, 40, 1);
            _toilet = YES;
        }
    }else if ([sender.titleLabel.text isEqualToString:@"有无冰箱"]){
        if (_refrigerator == YES) {
            sender.backgroundColor = [UIColor grayColor];
            _refrigerator = NO;
        }else{
            sender.backgroundColor = KGcolor(231, 99, 40, 1);
            _refrigerator = YES;
        }
    }else if ([sender.titleLabel.text isEqualToString:@"有无wifi"]){
        if (_wifi == YES) {
            sender.backgroundColor = [UIColor grayColor];
            _wifi = NO;
        }else{
            sender.backgroundColor = KGcolor(231, 99, 40, 1);
            _wifi = YES;
        }
    }else if ([sender.titleLabel.text isEqualToString:@"有无早餐"]){
        if (_breakfast == YES) {
            sender.backgroundColor = [UIColor grayColor];
            _breakfast = NO;
        }else{
            sender.backgroundColor = KGcolor(231, 99, 40, 1);
            _breakfast = YES;
        }
    }else if ([sender.titleLabel.text isEqualToString:@"附加信息"]){
        sender.backgroundColor = KGcolor(231, 99, 40, 1);
        _roomDetaile.hidden = NO;
        [_roomDetaile showTextViewtype:300];
    }else if ([sender.titleLabel.text isEqualToString:@"设置床型"]){
        sender.backgroundColor = KGcolor(231, 99, 40, 1);
        _roomDetaile.hidden = NO;
        [_roomDetaile showTextFieldtype:400];
    }else{
        sender.backgroundColor = KGcolor(231, 99, 40, 1);
        _roomDetaile.hidden = NO;
        [_roomDetaile showPickViewtype:500];
    }
}

#pragma mark -右侧确认创建房间按钮点击事件-
- (void)rightBarItmeClick:(UIButton *)sender{
    
    for (UITextField *obj in self.view.subviews) {
        switch (obj.tag) {
            case 101:
                if (obj.text.length > 0) {
                    [_postDic setObject:obj.text forKey:@"defaultPrice"];
                    _isWrite = YES;
                }else{
                    _isWrite = NO;
                }
                break;
            case 102:
                if (obj.text.length > 0) {
                    _isWrite = YES;
                    [_postDic setObject:obj.text forKey:@"deposit"];
                }else{
                    [_postDic setObject:@"0" forKey:@"deposit"];
                }
                break;
            default:
                break;
        }
    }
    if (_isChoose == NO) {
        [self alertViewControllerTitle:@"提示" message:@"请选择房型" name:@"确定" type:0 preferredStyle:1];
    }else if (_isWrite == NO){
        [self alertViewControllerTitle:@"提示" message:@"请填写价格" name:@"确定" type:0 preferredStyle:1];
    }else if (_toilet == NO && _breakfast == NO && _wifi == NO && _refrigerator == NO){
        [self alertViewControllerTitle:@"提示" message:@"请在左下角设置附加信息" name:@"确定" type:0 preferredStyle:1];
    }else{
        if (_toilet == YES) {
            [_postDic setObject:@"0" forKey:@"toilet"];
        }else{
            [_postDic setObject:@"1" forKey:@"toilet"];
        }
        if (_breakfast == YES ) {
            [_postDic setObject:@"0" forKey:@"breakfast"];
        }else{
            [_postDic setObject:@"1" forKey:@"breakfast"];
        }
        if (_wifi == YES) {
            [_postDic setObject:@"0" forKey:@"wifi"];
        }else{
            [_postDic setObject:@"1" forKey:@"wifi"];
        }
        if (_refrigerator == YES ) {
            [_postDic setObject:@"0" forKey:@"refrigerator"];
        }else{
            [_postDic setObject:@"1" forKey:@"refrigerator"];
        }
        [_postDic setObject:@"" forKey:@"roomDetailAddress"];
        if ([_type isEqualToString:@"修改"]) {
            [_postDic setObject:_roomNo forKey:@"roomNo"];
        }else{
            NSString *roomNo = @"";
            for (NSString *obj in _roomData) {
                if ([roomNo isEqualToString:@""]) {
                    roomNo = obj;
                }else{
                    roomNo = [[NSString stringWithFormat:@"%@,",roomNo] stringByAppendingString:obj];
                }
            }
            [_postDic setObject:roomNo forKey:@"roomNo"];
        }
        
        NSData *imageData = UIImageJPEGRepresentation(_pictureImage.image, 1);
        NSString *imageStr = [imageData base64Encoding];
        [_postDic setObject:@"0" forKey:@"weekdaysPrice"];
        [_postDic setObject:@"0" forKey:@"hourPrice"];
        [_postDic setObject:imageStr forKey:@"roomPictureAddr"];
        [_postDic setObject:@"1" forKey:@"count"];
        [_postDic setObject:_hotellId forKey:@"hotelId"];
        __weak typeof(self) MySelf = self;
        if ([_type isEqualToString:@"修改"]) {
            [_postDic removeObjectForKey:@"hotelId"];
            [_postDic setObject:_roomId forKey:@"roomId"];
            
            [[KGRequest sharedInstance] changeHotelRoomWithDictionary:_postDic succ:^(NSString *msg, id data) {
                if ([msg isEqualToString:@"修改房间信息成功"]) {
                    [self alertViewTitle:msg];
                }
            } fail:^(NSString *error) {
                [MySelf alertViewControllerTitle:@"提示" message:error name:@"确定" type:0 preferredStyle:1];
            }];
        }else{
            [[KGRequest sharedInstance] addRoomWithDictionary:_postDic succ:^(NSString *msg, id data) {
                [self alertViewTitle:msg];
            } fail:^(NSString *error) {
                [self alertViewControllerTitle:@"提示" message:error name:@"确定" type:0 preferredStyle:1];
            }];
        }
    }
}

#pragma mark -设置房型pickview-
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
    _roomAdd = [[KGRoomTextField alloc]initWithFrame:CGRectMake(100,490, KGscreenWidth - 100, 40)];
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
    [self.view addSubview:_roomAdd];
}

#pragma mark -添加房间点击事件-
- (void)closeClick:(UIButton *)sender{
    if ([self deptNumInputShouldNumber:_roomAdd.text] == YES) {
        [_roomData addObject:_roomAdd.text];
        _room.dataArr = _roomData;
        _room.roomView.frame = CGRectMake(0, 0, _room.frame.size.width, _roomData.count * 50);
        [_room.roomView reloadData];
    }else{
        [self alertViewControllerTitle:@"提示" message:@"请输入数字" name:@"确定" type:0 preferredStyle:1];
    }
}

#pragma mark -判断输入是否是数字-
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
    _room = [[KGRoomView alloc]initWithFrame:CGRectMake(100, 540, KGscreenWidth - 100, KGscreenHeight - 540)];
    [self.view addSubview:_room];
}

#pragma mark -删除房间号代理事件-
- (void)deleteTextField:(NSArray *)arr{
    _roomData = [NSMutableArray arrayWithArray:arr];
}

#pragma mark -创建提示标签-
- (void)setLabelFromArray{
    NSArray *titleLabelArr = @[@"房型名称:",@"默认房价:",@"押金金额:",@"房间号码:"];
    if ([_type isEqualToString:@"修改"]) {
        for (int i = 0; i < 5 ; i++) {
            if (i > 1) {
                UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 440 + 50 * (i - 2), 100, 40)];
                titleLabel.text = titleLabelArr[i];
                titleLabel.tintColor = [UIColor grayColor];
                titleLabel.backgroundColor = [UIColor whiteColor];
                titleLabel.textAlignment = NSTextAlignmentRight;
                titleLabel.font = [UIFont systemFontOfSize:13.0f];
                [self.view addSubview:titleLabel];
            }else{
                UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 200 + 50 * i, 100, 40)];
                titleLabel.text = titleLabelArr[i];
                titleLabel.tintColor = [UIColor grayColor];
                titleLabel.backgroundColor = [UIColor whiteColor];
                titleLabel.textAlignment = NSTextAlignmentRight;
                titleLabel.font = [UIFont systemFontOfSize:13.0f];
                [self.view addSubview:titleLabel];
            }
        }
    }else{
        for (int i = 0; i < titleLabelArr.count ; i++) {
            if (i > 1) {
                UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 440 + 50 * (i - 2), 100, 40)];
                titleLabel.text = titleLabelArr[i];
                titleLabel.tintColor = [UIColor grayColor];
                titleLabel.backgroundColor = [UIColor whiteColor];
                titleLabel.textAlignment = NSTextAlignmentRight;
                titleLabel.font = [UIFont systemFontOfSize:13.0f];
                [self.view addSubview:titleLabel];
            }else{
                UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 200 + 50 * i, 100, 40)];
                titleLabel.text = titleLabelArr[i];
                titleLabel.tintColor = [UIColor grayColor];
                titleLabel.backgroundColor = [UIColor whiteColor];
                titleLabel.textAlignment = NSTextAlignmentRight;
                titleLabel.font = [UIFont systemFontOfSize:13.0f];
                [self.view addSubview:titleLabel];
            }
        }
    }
}

#pragma mark -添加房型名称-
- (void)setRoomNameTextField{
    _roomType = [[UIButton alloc]initWithFrame:CGRectMake(100,  200, KGscreenWidth - 100, 40)];
    _roomType.backgroundColor = [UIColor whiteColor];
    [_roomType addTarget:self action:@selector(cityClick:) forControlEvents:UIControlEventTouchUpInside];
    [_roomType setTitle:@"" forState:UIControlStateNormal];
    [self.view addSubview:_roomType];
    _returnImage = [[UIImageView alloc]initWithFrame:CGRectMake(KGscreenWidth - 20, 210, 20, 20)];
    _returnImage.image = [UIImage imageNamed:@"下一个"];
    [self.view addSubview:_returnImage];
}

#pragma mark -选择房型-
- (void)cityClick:(UIButton *)sender{
    if (sender.titleLabel.text.length > 0) {
        _isChoose = YES;
    }else{
        _isChoose = NO;
    }
    _pickerView.hidden = NO;
}

#pragma mark -房价设置UI-
- (void)setPriceTextFieldUI{

    _priceTextField = [[KGPriceTextField alloc]initWithFrame:CGRectMake(100,  250 , KGscreenWidth - 100, 40)];
    _priceTextField.backgroundColor = [UIColor whiteColor];
    _priceTextField.placeholder = @"(必填*)请填写平日价格";
    _priceTextField.textColor = [UIColor grayColor];
    _priceTextField.delegate = self;
    _priceTextField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"人民币"]];
    _priceTextField.leftViewMode = UITextFieldViewModeAlways;
    _priceTextField.rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"元"]];
    _priceTextField.rightViewMode = UITextFieldViewModeAlways;
    _priceTextField.font = [UIFont systemFontOfSize:13.0f];
    _priceTextField.tag = 101;
    [self.view addSubview:_priceTextField];
    
    _priceHotel = [[KGPriceTextField alloc]initWithFrame:CGRectMake(100,440, KGscreenWidth - 100, 40)];
    _priceHotel.backgroundColor = [UIColor whiteColor];
    _priceHotel.placeholder = @"(选填:不填视为0)请填写押金";
    _priceHotel.textColor = [UIColor grayColor];
    _priceHotel.delegate = self;
    _priceHotel.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"人民币"]];
    _priceHotel.leftViewMode = UITextFieldViewModeAlways;
    _priceHotel.rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"元"]];
    _priceHotel.rightViewMode = UITextFieldViewModeAlways;
    _priceHotel.font = [UIFont systemFontOfSize:13.0f];
    _priceHotel.tag = 102;
    [self.view addSubview:_priceHotel];
    
    UILabel *back = [[UILabel alloc]initWithFrame:CGRectMake(0,300 , KGscreenWidth, 130)];
    back.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:back];
}

#pragma mark -收件盘-
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_priceTextField resignFirstResponder];
    [_priceHotel resignFirstResponder];
    [_roomAdd resignFirstResponder];
    _pickerView.hidden = YES;
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
    [_postDic setObject:_typeArr[row] forKey:@"roomName"];
}

#pragma mark -添加房间描述图片-
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

#pragma mark -访问手机相册-
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

#pragma mark -获取手机相册选择的图片-
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //info是所选择照片的信息
    
    //    UIImagePickerControllerEditedImage//编辑过的图片
    //    UIImagePickerControllerOriginalImage//原图
    
    _pictureImage.image = info[@"UIImagePickerControllerEditedImage"];
    
    //使用模态返回到软件界面
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)sendAdditionalInformation:(NSString *)additionalInformation{
    [_postDic setObject:additionalInformation forKey:@"additionalInformation"];
}

- (void)sendBedType:(NSString *)bedType{
    [_postDic setObject:bedType forKey:@"bedType"];
}

- (void)sendCaptaion:(NSString *)captaion{
    [_postDic setObject:captaion forKey:@"captaion"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertViewTitle:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:1];
    UIAlertAction *okact = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    [alert addAction:okact];
    
    [self presentViewController:alert animated:YES completion:nil];
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
