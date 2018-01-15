//
//  KGRoomStarViewController.m
//  遇见智能
//
//  Created by KG on 2018/1/12.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import "KGRoomStarViewController.h"
#import "KGDetaialTableViewCell.h"
#import "KGRoomStarDetaialViewController.h"

@interface KGRoomStarViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger page;
    NSInteger pageSize;
}

@property (strong, nonatomic) UITableView *listTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation KGRoomStarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    page = 0;
    pageSize = 10;
    
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
    [self setDataArray];
}

- (void)setDataArray{
    _dataArr = [NSMutableArray array];
//    __weak typeof(self) weakSelf = self;
//    [[KGRequest sharedInstance] roomStareHotellId:_hotellId page:[NSString stringWithFormat:@"%ld",page] pageSize:[NSString stringWithFormat:@"%ld",pageSize] succ:^(NSString *msg, id data) {
//
//    } fail:^(NSString *error) {
//
//    }];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self alertViewControllerTitle:@"提示" message:@"是否删除该房间" name:@"删除" type:0 preferredStyle:1];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGDetaialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KGDetaialTableViewCell" owner:self options:nil] lastObject];
    }
    if (_dataArr.count > 0) {
//        KGRoomModel *model = _dataArr[indexPath.row];
//        NSData *decodedImageData = [[NSData alloc]initWithBase64EncodedString:model.roomPictureAddr options:NSDataBase64DecodingIgnoreUnknownCharacters];
//        UIImage *imageUrl = [UIImage imageWithData:decodedImageData];
//        cell.headerImage.image = imageUrl;
//        cell.nameLabel.text = model.roomName;
//        cell.IDLabel.text = [NSString stringWithFormat:@"%@房间",model.roomNo];
//        cell.starLabel.text = @"未入住";
//        cell.endLabel.text = model.bedType;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KGRoomStarDetaialViewController *star = [[KGRoomStarDetaialViewController alloc]init];
    [self.navigationController pushViewController:star animated:YES];
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
