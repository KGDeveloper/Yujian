//
//  KGAddRoomTypeViewController.m
//  遇见智能
//
//  Created by KG on 2018/1/13.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import "KGAddRoomTypeViewController.h"
#import "KGRoomTextField.h"
#import "KGRoomTypeTableViewCell.h"
#import "KGAddRomeViewController.h"

@interface KGAddRoomTypeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,KGRoomTypeTableViewCellDelegate>

@property (nonatomic,strong) UITableView *roomType;
@property (nonatomic,strong) NSMutableArray *roomArr;
@property (nonatomic,strong) KGRoomTextField *addRoom;

@end

@implementation KGAddRoomTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLeftNavButtonItmeTitle:@"" icon:@"Return"];
    [self setUpRightNavButtonItmeTitle:@"确定" icon:nil];
    
    _roomArr = [NSMutableArray array];
    [self initTableView];
}

- (void)rightBarItmeClick:(UIButton *)sender{
    if (_roomArr.count > 0) {
        KGAddRomeViewController *addRoom = [[KGAddRomeViewController alloc]init];
        addRoom.typeArr = _roomArr;
        addRoom.hotellId = _hotellId;
        [self.navigationController pushViewController:addRoom animated:YES];
    }else{
        [self alertViewControllerTitle:@"提示" message:@"请先添加房型" name:@"确定" type:0 preferredStyle:1];
    }
}

- (void)initTableView{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGscreenWidth, 110)];
    headerView.backgroundColor = [UIColor whiteColor];
    _addRoom = [[KGRoomTextField alloc]initWithFrame:CGRectMake(20,0, KGscreenWidth - 40, 50)];
    _addRoom.textColor = [UIColor grayColor];
    _addRoom.placeholder = @"请输入房型";
    _addRoom.font = [UIFont systemFontOfSize:15.0f];
    _addRoom.clearsOnBeginEditing = YES;
    _addRoom.delegate = self;
    UIButton *close = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    [close setImage:[UIImage imageNamed:@"添加-3"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
    _addRoom.rightView = close;
    _addRoom.rightViewMode = UITextFieldViewModeAlways;
    [headerView addSubview:_addRoom];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, KGscreenWidth - 40, 20)];
    topLabel.text = @"*请在输入框内输入房型，点击右侧添加按钮添加！";
    topLabel.textColor = KGCellDont;
    topLabel.font = KGFont(12);
    [headerView addSubview:topLabel];
    
    UILabel *centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, KGscreenWidth - 40, 20)];
    centerLabel.text = @"*请不要输入除汉字以外的特殊字符!";
    centerLabel.textColor = KGCellDont;
    centerLabel.font = KGFont(12);
    [headerView addSubview:centerLabel];
    
    UILabel *buttomLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 90, KGscreenWidth - 40, 20)];
    buttomLabel.text = @"*您可以最多创建12个房型！";
    buttomLabel.textColor = KGCellDont;
    buttomLabel.font = KGFont(12);
    [headerView addSubview:buttomLabel];
    
    if (KGDevice_Is_iPhoneX == YES) {
        _roomType = [[UITableView alloc]initWithFrame:CGRectMake(0, 88, KGscreenWidth, KGscreenHeight - 88)];
    }else{
        _roomType = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KGscreenWidth, KGscreenHeight - 64)];
    }
    _roomType.delegate = self;
    _roomType.dataSource = self;
    _roomType.tableHeaderView = headerView;
    _roomType.tableFooterView = [UIView new];
    _roomType.rowHeight = 50;
    _roomType.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.view addSubview:_roomType];
}

- (void)closeClick:(UIButton *)sender{
    [_addRoom resignFirstResponder];
    if ([self isChineseStr:_addRoom.text] == YES) {
        if (_roomArr.count > 12) {
            [self alertViewControllerTitle:@"提示" message:@"您创建的房型数目已达上限！" name:@"确定" type:0 preferredStyle:1];
        }else{
            [_roomArr addObject:_addRoom.text];
            [_roomType reloadData];
        }
    }else{
        [self alertViewControllerTitle:@"提示" message:@"您输入汉字以外的文字，请修改！" name:@"确定" type:0 preferredStyle:1];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _roomArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGRoomTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KGRoomTypeTableViewCell" owner:self options:nil] lastObject];
    }
    cell.Mydelegate = self;
    if (_roomArr.count > 0 ) {
        cell.namelabel.text = _roomArr[indexPath.row];
    }
    return cell;
}

- (void)deleteArray:(NSString *)roomName{
    
    [_roomArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:roomName]) {
            *stop = YES;
            if (*stop == YES) {
                [_roomArr removeObject:roomName];
                [_roomType reloadData];
            }
        }
    }];
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

- (BOOL)isChineseStr:(NSString *)str
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
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
