//
//  KGDetaialViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/21.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGDetaialViewController.h"
#import "KGDetaialTableViewCell.h"
#import "KGAddRoomTypeViewController.h"
#import "KGRoomModel.h"

@interface KGDetaialViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *listTableView;
@property (nonatomic,strong) UIButton *addHotell;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation KGDetaialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"房间信息";
    
    [self setDataArray];

    if (KGDevice_Is_iPhoneX == YES) {
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 88, KGscreenWidth, KGscreenHeight - 88)];
    }else{
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KGscreenWidth, KGscreenHeight - 64)];
    }
    _listTableView.rowHeight = 110.0f;
    _listTableView.tableFooterView = [UIView new];
    _listTableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [self.view addSubview:_listTableView];
    [self initAddHotellBut];
}

- (void)setDataArray{
    _dataArr = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    [[KGRequest sharedInstance] roomHotellId:_hotellId page:@"0" pageSize:@"10" succ:^(NSString *msg, id data) {
        NSArray *dataArray = data;
        for (int i = 0; i < dataArray.count; i++) {
            NSDictionary *dic = dataArray[i];
            KGRoomModel *model = [[KGRoomModel alloc]initWithDictionary:dic];
            [weakSelf.dataArr addObject:model];
        }
        [weakSelf.listTableView reloadData];
    } fail:^(NSString *error) {
        
    }];
}

#pragma mark -添加酒店-
- (void)initAddHotellBut{
    _addHotell = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    _addHotell.center = CGPointMake(KGscreenWidth - 50, KGscreenHeight - 50);
    [_addHotell setImage:[UIImage imageNamed:@"Addto"] forState:UIControlStateNormal];
    [_addHotell addTarget:self action:@selector(addHotell:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:_addHotell atIndex:99];
}

#pragma mark -导航栏右侧添加按钮-
- (void)addHotell:(UIButton *)sender{
    KGAddRoomTypeViewController *addRoom = [[KGAddRoomTypeViewController alloc]init];
    addRoom.hotellId = _hotellId;
    addRoom.type = @"添加";
    [[self navigationController] pushViewController:addRoom animated:YES];
}

//获取导航控制器
- (UINavigationController*)navigationController {
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController*)nextResponder;
        }
    }
    return nil;
}


- (void)rightBarItmeClick:(UIButton *)sender{
    if (_listTableView.editing == YES) {
        _listTableView.editing = NO;
    }else{
        _listTableView.editing = YES;
    }
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) Myself = self;
    KGRoomModel *model = _dataArr[indexPath.row];
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [[KGRequest sharedInstance] deleteRoom:model.roomId succ:^(NSString *msg, id data) {
            if ([msg isEqualToString:@"成功"]) {
                [Myself.dataArr removeObject:model];
                [Myself.listTableView reloadData];
                [Myself alertViewControllerTitle:@"提示" message:@"删除成功" name:@"确定" type:0 preferredStyle:1];
            }
        } fail:^(NSString *error) {
            [Myself alertViewControllerTitle:@"提示" message:error name:@"确定" type:0 preferredStyle:1];
        }];
    }];
    UITableViewRowAction *actionTwo = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"修改" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        KGAddRoomTypeViewController *room = [[KGAddRoomTypeViewController alloc]init];
        room.type = @"修改";
        room.roomId = model.roomId;
        room.hotellId = _hotellId;
        room.roomNo = model.roomNo;
        [Myself.navigationController pushViewController:room animated:YES];
    }];
    actionTwo.backgroundColor = [UIColor grayColor];
    return @[action,actionTwo];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGDetaialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KGDetaialTableViewCell" owner:self options:nil] lastObject];
    }
    if (_dataArr.count > 0) {
        KGRoomModel *model = _dataArr[indexPath.row];
        NSData *decodedImageData = [[NSData alloc]initWithBase64EncodedString:model.roomPictureAddr options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *imageUrl = [UIImage imageWithData:decodedImageData];
        cell.headerImage.image = imageUrl;
        cell.nameLabel.text = model.roomName;
        cell.IDLabel.text = [NSString stringWithFormat:@"%@房间",model.roomNo];
        cell.starLabel.text = @"未入住";
        cell.endLabel.text = model.bedType;
    }
    return cell;
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
