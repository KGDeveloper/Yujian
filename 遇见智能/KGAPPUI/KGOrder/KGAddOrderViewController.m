//
//  KGAddOrderViewController.m
//  遇见智能
//
//  Created by KG on 2018/1/18.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import "KGAddOrderViewController.h"
#import "KGHotel+RoomType.h"
#import "KGOrderHotellModel.h"
#import "KGRoomTypeModel.h"
#import "KGDayPickView.h"
#import "KGCustomInfoView.h"

@interface KGAddOrderViewController ()<KGHotel_RoomTypeDelegate,KGDayPickViewDelegate,KGCustomInfoViewDelegate,UITextFieldDelegate>{
    NSInteger navHight;
}

@property (nonatomic,strong) UILabel *hotelName;//显示酒店名称的label
@property (nonatomic,strong) UILabel *roomType;//显示房型的label
@property (nonatomic,strong) UILabel *intoTime;//显示入住时间的label
@property (nonatomic,strong) UILabel *outTime;//显示退房时间的label
@property (nonatomic,strong) UILabel *waitTime;//住几天label

@property (nonatomic,strong) UILabel *customName;//显示用户名的label
@property (nonatomic,strong) UILabel *customPhone;//显示用户联系方式的label

@property (nonatomic,strong) UITextField *priceText;//设置用户需要提交的押金金额

@property (nonatomic,strong) KGHotel_RoomType *myPickView;//选择酒店名称和房型的选择器
@property (nonatomic,strong) KGDayPickView *dayPickView;//选择时间的时间选择器
@property (nonatomic,strong) KGCustomInfoView *customInfo;//填写订单的时候用户信息填写页面

@property (nonatomic,copy) NSString *hotelIdStr;//酒店id
@property (nonatomic,copy) NSString *hotelNameStr;//酒店名称
@property (nonatomic,copy) NSString *roomTypeStr;//房型
@property (nonatomic,strong) NSMutableArray *hotelArr;//保存酒店的数组
@property (nonatomic,strong) NSMutableArray *roomArr;//保存房型的数组

@end

@implementation KGAddOrderViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KGcolor(244, 246, 244, 1);
    [self setUpLeftNavButtonItmeTitle:@"" icon:@"Return"];
    [self setUpRightNavButtonItmeTitle:@"提交" icon:nil];
    
    _hotelArr = [NSMutableArray array];
    _roomArr = [NSMutableArray array];
    
    if (KGDevice_Is_iPhoneX == YES) {
        navHight = 90;
    }else{
        navHight = 66;
    }
    
    [self setHotellDataArr];
    [self initHotelLabel];
    [self initRoomTypeLabel];
    [self initTimeLabel];
    [self initUserLabel];
//    [self setRoomPrice];
    [self initPickView];
    [self initCustomInfo];
    
}

//- (void)setRoomPrice{
//    KGCustomLabel *price = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0, navHight + 580,100, 60)];
//    price.text = @"设置押金";
//    price.backgroundColor = [UIColor whiteColor];
//    price.textColor = [UIColor blackColor];
//    price.textAlignment = NSTextAlignmentLeft;
//    price.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
//    [self.view addSubview:price];
//
//    _priceText = [[UITextField alloc]initWithFrame:CGRectMake(100, navHight + 580,KGscreenWidth - 100, 60)];
//    _priceText.delegate = self;
//    _priceText.placeholder = @"请设置押金金额,注:不填视为不需要押金";
//    _priceText.font = KGFont(15);
//    _priceText.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_priceText];
//
//}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self deptNumInputShouldNumber:textField.text] == YES) {
        return YES;
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请输入数字";
        hud.minShowTime = 2;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        return NO;
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

- (void)rightBarItmeClick:(UIButton *)sender{
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    BOOL writeMsg = NO;
    /*
     *判断是否选择酒店名称
     */
    if (_hotelName.text.length > 0) {
        writeMsg = YES;
    }else{
        writeMsg = NO;
    }
    /*
     *判断是否选择酒店房型
     */
    if (_roomType.text.length > 0) {
        writeMsg = YES;
    }else{
        writeMsg = NO;
    }
    /*
     *判断是否选择入住时间
     */
    if (_intoTime.text.length > 0) {
        writeMsg = YES;
    }else{
        writeMsg = NO;
    }
    /*
     *判断是否选择退房时间
     */
    if (_outTime.text.length > 0) {
        writeMsg = YES;
    }else{
        writeMsg = NO;
    }
    /*
     *判断是否选择住店时间
     */
    if (_waitTime.text.length > 0) {
        writeMsg = YES;
    }else{
        writeMsg = NO;
    }
    /*
     *判断是否填写住户姓名
     */
    if (_customName.text.length > 0) {
        writeMsg = YES;
    }else{
        writeMsg = NO;
    }
    /*
     *判断是否填写住户手机号
     */
    if (_customPhone.text.length > 0) {
        writeMsg = YES;
    }else{
        writeMsg = NO;
    }
    
    //****
    //*****提交订单，直接传字典过去，因为参数太多
    //*****
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (writeMsg == YES) {
    
        [parameters setObject:_hotelIdStr forKey:@"hotelId"];
        [parameters setObject:_roomTypeStr forKey:@"roomType"];
        [parameters setObject:_intoTime.text forKey:@"intoTime"];
        [parameters setObject:_outTime.text forKey:@"outTime"];
        [parameters setObject:_customName.text forKey:@"customName"];
        [parameters setObject:_customPhone.text forKey:@"customPhone"];
        NSString *waitStr = [[_waitTime.text componentsSeparatedByString:@"晚"] firstObject];
        [parameters setObject:waitStr forKey:@"waitTime"];
        __weak typeof(self) MySelf = self;
        [[KGRequest sharedInstance] addOrderWithDictionary:parameters succ:^(NSString *msg, id data) {
//            [MBProgressHUD hideHUDForView:MySelf.view animated:YES];
            [MySelf alertViewControllerTitle:@"提示" message:@"添加成功" name:@"确认" type:0 preferredStyle:1];
        } fail:^(NSString *error) {
            [MySelf alertViewControllerTitle:@"提示" message:error name:@"确认" type:0 preferredStyle:1];
        }];
        
//        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请填写完整的订单信息";
        hud.minShowTime = 2;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}

/**
 创建选择酒店和房型的pickview
 */
- (void)initPickView{
    _myPickView = [[KGHotel_RoomType alloc]initWithFrame:CGRectMake(0, KGscreenHeight - 300, KGscreenWidth, 300)];
    _myPickView.myDelegate = self;
    _myPickView.hidden = YES;
    [self.view addSubview:_myPickView];
    
    _dayPickView = [[KGDayPickView alloc]initWithFrame:CGRectMake(0, KGscreenHeight - 300, KGscreenWidth, 300)];
    _dayPickView.hidden = YES;
    _dayPickView.myDelegate = self;
    [self.view addSubview:_dayPickView];
}

/**
 代理返回的酒店id以及酒店名称

 @param hotelName 酒店 名称
 @param hotelId 酒店 id
 */
- (void)sendRoomModelToView:(NSString *)hotelName hotelId:(NSString *)hotelId{
    _hotelIdStr = hotelId;
    _hotelName.text = hotelName;
}

- (void)setRoomTypeDataArr{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_roomArr removeAllObjects];
    __weak typeof(self) MySelf = self;
    [[KGRequest sharedInstance] hotelAllRoomType:_hotelIdStr succ:^(NSString *msg, id data) {
        NSArray *dataArr = data;
        for (int i = 0; i < dataArr.count; i++) {
            
            NSDictionary *dic = dataArr[i];
            
            KGRoomTypeModel *model = [[KGRoomTypeModel alloc]initWithDictionary:dic];
            [MySelf.roomArr addObject:model];
        }
        MySelf.myPickView.hidden = NO;
        MySelf.myPickView.hotelOrRoomType = NO;
        [MySelf.myPickView sendArrayToView:MySelf.roomArr];
        [MBProgressHUD hideHUDForView:MySelf.view animated:YES];
    } fail:^(NSString *error) {
        
    }];

}

/**
 代理返回的房型名称

 @param roomType 房型 名称
 */
- (void)sendHotelModelToView:(NSString *)roomType{
    _roomTypeStr = roomType;
    _roomType.text = roomType;
}

- (void)initHotelLabel{
    
    KGCustomLabel *hotelInfo = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight , 100, 50)];
    hotelInfo.text = @"入住信息";
    hotelInfo.textAlignment = NSTextAlignmentLeft;
    hotelInfo.textColor = [UIColor blackColor];
    hotelInfo.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:hotelInfo];
    
    KGCustomLabel *hotelLab = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight + 50, 100, 60)];
    hotelLab.text = @"选择酒店";
    hotelLab.backgroundColor = [UIColor whiteColor];
    hotelLab.textAlignment = NSTextAlignmentLeft;
    hotelLab.textColor = [UIColor blackColor];
    hotelLab.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:hotelLab];
    
    _hotelName = [[UILabel alloc]initWithFrame:CGRectMake(100,navHight + 50,KGscreenWidth - 100, 60)];
    _hotelName.text = @"天龙大酒店";
    _hotelName.backgroundColor = [UIColor whiteColor];
    _hotelName.textAlignment = NSTextAlignmentLeft;
    _hotelName.textColor = KGcolor(231, 99, 40, 1);
    [self.view addSubview:_hotelName];
    
    UIButton *hotelClick = [[UIButton alloc]initWithFrame:CGRectMake(0, navHight + 50, KGscreenWidth, 60)];
    [hotelClick setImage:KGImage(@"下一个") forState:UIControlStateNormal];
    [hotelClick setImageEdgeInsets:UIEdgeInsetsMake(20, hotelClick.frame.size.width - 40, 20, 20)];
    [hotelClick addTarget:self action:@selector(hotelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hotelClick];
    
}

- (void)hotelClick:(UIButton *)sender{
    _myPickView.hidden = NO;
    _myPickView.hotelOrRoomType = YES;
    [_myPickView sendArrayToView:_hotelArr];
}

- (void)initRoomTypeLabel{
    
    KGCustomLabel *roomLab = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight +112, 100, 60)];
    roomLab.text = @"选择房型";
    roomLab.backgroundColor = [UIColor whiteColor];
    roomLab.textAlignment = NSTextAlignmentLeft;
    roomLab.textColor = [UIColor blackColor];
    roomLab.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:roomLab];
    
    _roomType = [[UILabel alloc]initWithFrame:CGRectMake(100,navHight +112,KGscreenWidth - 100, 60)];
    _roomType.text = @"大床房";
    _roomType.backgroundColor = [UIColor whiteColor];
    _roomType.textAlignment = NSTextAlignmentLeft;
    _roomType.textColor = KGcolor(231, 99, 40, 1);
    [self.view addSubview:_roomType];
    
    UIButton *roomClick = [[UIButton alloc]initWithFrame:CGRectMake(0, navHight +112, KGscreenWidth, 60)];
    [roomClick setImage:KGImage(@"下一个") forState:UIControlStateNormal];
    [roomClick setImageEdgeInsets:UIEdgeInsetsMake(20, roomClick.frame.size.width - 40, 20, 20)];
    [roomClick addTarget:self action:@selector(roomClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:roomClick];
    
}

- (void)roomClick:(UIButton *)sender{
    if (_hotelIdStr == NULL) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请先选择酒店";
        hud.minShowTime = 2;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }else{
        [self setRoomTypeDataArr];
    }
}

- (void)initTimeLabel{
    
    KGCustomLabel *timeLabl = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight  + 172, 100, 50)];
    timeLabl.text = @"入离时间";
    timeLabl.textAlignment = NSTextAlignmentLeft;
    timeLabl.textColor = [UIColor blackColor];
    timeLabl.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:timeLabl];
    
    KGCustomLabel *joinTime = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight + 222, 100, 60)];
    joinTime.text = @"入住时间";
    joinTime.backgroundColor = [UIColor whiteColor];
    joinTime.textAlignment = NSTextAlignmentLeft;
    joinTime.textColor = [UIColor blackColor];
    joinTime.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:joinTime];
    
    _intoTime = [[UILabel alloc]initWithFrame:CGRectMake(100, navHight + 222, KGscreenWidth - 100, 60)];
    _intoTime.backgroundColor = [UIColor whiteColor];
    _intoTime.textColor = [UIColor blackColor];
    _intoTime.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_intoTime];
    
    UIButton *intoTimeBut = [[UIButton alloc]initWithFrame:CGRectMake(100, navHight + 222, KGscreenWidth - 100, 60)];
    [intoTimeBut setImage:KGImage(@"下一个") forState:UIControlStateNormal];
    [intoTimeBut setImageEdgeInsets:UIEdgeInsetsMake(20, intoTimeBut.frame.size.width - 40, 20, 20)];
    [intoTimeBut addTarget:self action:@selector(intoTimeBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:intoTimeBut];
    
    KGCustomLabel *joinOut = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight + 284, 100, 60)];
    joinOut.text = @"退房时间";
    joinOut.backgroundColor = [UIColor whiteColor];
    joinOut.textAlignment = NSTextAlignmentLeft;
    joinOut.textColor = [UIColor blackColor];
    joinOut.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:joinOut];
    
    _outTime = [[UILabel alloc]initWithFrame:CGRectMake(100, navHight + 284, KGscreenWidth - 100, 60)];
    _outTime.backgroundColor = [UIColor whiteColor];
    _outTime.textColor = [UIColor blackColor];
    _outTime.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_outTime];
    
    UIButton *outTimeBtu = [[UIButton alloc]initWithFrame:CGRectMake(100, navHight + 284, KGscreenWidth - 100, 60)];
    [outTimeBtu setImage:KGImage(@"下一个") forState:UIControlStateNormal];
    [outTimeBtu setImageEdgeInsets:UIEdgeInsetsMake(20, outTimeBtu.frame.size.width - 40, 20, 20)];
    [outTimeBtu addTarget:self action:@selector(outTimeBtu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:outTimeBtu];
    
    KGCustomLabel *waitDay = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight + 346, 100, 60)];
    waitDay.text = @"住房时间";
    waitDay.backgroundColor = [UIColor whiteColor];
    waitDay.textAlignment = NSTextAlignmentLeft;
    waitDay.textColor = [UIColor blackColor];
    waitDay.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:waitDay];
    
    _waitTime = [[UILabel alloc]initWithFrame:CGRectMake(100, navHight + 346, KGscreenWidth - 100, 60)];
    _waitTime.backgroundColor = [UIColor whiteColor];
    _waitTime.textColor = [UIColor blackColor];
    _waitTime.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_waitTime];
    
    UIButton *waitBtu = [[UIButton alloc]initWithFrame:CGRectMake(100, navHight + 346, KGscreenWidth - 100, 60)];
    [waitBtu setImage:KGImage(@"下一个") forState:UIControlStateNormal];
    [waitBtu setImageEdgeInsets:UIEdgeInsetsMake(20, waitBtu.frame.size.width - 40, 20, 20)];
    [waitBtu addTarget:self action:@selector(waitBtu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:waitBtu];
    
}

/**
 选择入住时间

 @param sender 入住时间
 */
- (void)intoTimeBut:(UIButton *)sender{
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"yyyy-MM-dd";
    [MOFSPickerManager shareManger].datePicker.toolBar.cancelBarTintColor = [UIColor redColor];
    [MOFSPickerManager shareManger].datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    [[MOFSPickerManager shareManger] showDatePickerWithTag:1 commitBlock:^(NSDate *date) {
        _intoTime.text = [df stringFromDate:date];
    } cancelBlock:^{
        
    }];
}

/**
 选择退房时间
 
 @param sender 退房时间
 */
- (void)outTimeBtu:(UIButton *)sender{
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"yyyy-MM-dd";
    [MOFSPickerManager shareManger].datePicker.toolBar.cancelBarTintColor = [UIColor redColor];
    [MOFSPickerManager shareManger].datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    [[MOFSPickerManager shareManger] showDatePickerWithTag:1 commitBlock:^(NSDate *date) {
        _outTime.text = [df stringFromDate:date];
    } cancelBlock:^{
        
    }];
}

- (void)waitBtu:(UIButton *)sender{
    _dayPickView.hidden = NO;
}

- (void)giveDayTime:(NSString *)dayTime{
    _waitTime.text = dayTime;
}

- (void)initUserLabel{
    
    KGCustomLabel *userInfo = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight  + 406, 100, 50)];
    userInfo.text = @"住户信息";
    userInfo.textAlignment = NSTextAlignmentLeft;
    userInfo.textColor = [UIColor blackColor];
    userInfo.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:userInfo];
    
    KGCustomLabel *userName = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight + 456, 100, 60)];
    userName.text = @"住户姓名";
    userName.backgroundColor = [UIColor whiteColor];
    userName.textAlignment = NSTextAlignmentLeft;
    userName.textColor = [UIColor blackColor];
    userName.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:userName];
    
    _customName = [[UILabel alloc]initWithFrame:CGRectMake(100, navHight + 456, KGscreenWidth - 100, 60)];
    _customName.backgroundColor = [UIColor whiteColor];
    _customName.textColor = [UIColor blackColor];
    _customName.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_customName];
    
    UIButton *customNameBtu = [[UIButton alloc]initWithFrame:CGRectMake(100, navHight + 456, KGscreenWidth - 100, 60)];
    [customNameBtu setImage:KGImage(@"下一个") forState:UIControlStateNormal];
    [customNameBtu setImageEdgeInsets:UIEdgeInsetsMake(20, customNameBtu.frame.size.width - 40, 20, 20)];
    [customNameBtu addTarget:self action:@selector(customNameBtu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customNameBtu];
    
    KGCustomLabel *userPhone = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight + 518, 100, 60)];
    userPhone.text = @"联系方式";
    userPhone.backgroundColor = [UIColor whiteColor];
    userPhone.textAlignment = NSTextAlignmentLeft;
    userPhone.textColor = [UIColor blackColor];
    userPhone.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:userPhone];
    
    _customPhone = [[UILabel alloc]initWithFrame:CGRectMake(100, navHight + 518, KGscreenWidth - 100, 60)];
    _customPhone.backgroundColor = [UIColor whiteColor];
    _customPhone.textColor = [UIColor blackColor];
    _customPhone.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_customPhone];
    
}

- (void)initCustomInfo{
    _customInfo = [[KGCustomInfoView alloc]initWithFrame:self.view.frame];
    _customInfo.hidden = YES;
    _customInfo.myDelegate = self;
    [self.view addSubview:_customInfo];
}

- (void)customNameBtu:(UIButton *)sender{
    _customInfo.hidden = NO;
}

- (void)sendUsername:(NSString *)userName userPhone:(NSString *)userPhone{
    _customName.text = userName;
    _customPhone.text = userPhone;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_priceText resignFirstResponder];
}

- (void)setHotellDataArr{
    __weak typeof(self) MySelf = self;
    [[KGRequest sharedInstance] allHodel:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] succ:^(NSString *msg, id data) {
        NSArray *arr = data;
        for (int i = 0; i < arr.count ; i++) {
            NSDictionary *dic = arr[i];
            KGOrderHotellModel *model = [[KGOrderHotellModel alloc]initWithDictionary:dic];
            [MySelf.hotelArr addObject:model];
        }
    } fail:^(NSString *error) {
        
    }];
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
