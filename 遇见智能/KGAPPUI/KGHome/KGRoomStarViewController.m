//
//  KGRoomStarViewController.m
//  遇见智能
//
//  Created by KG on 2018/1/12.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import "KGRoomStarViewController.h"
#import "KGRoomStarTableViewCell.h"
#import "KGRoomStarDetaialView.h"
#import "KGUserInfo.h"

@interface KGRoomStarViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger page;
    NSInteger pageSize;
}
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) KGRoomStarDetaialView *detaialView;
@property (nonatomic,strong) NSMutableArray *dateArray;

@end

@implementation KGRoomStarViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    page = 0;
    pageSize = 10;
    
    _dateArray = [NSMutableArray array];
    _dataArr = [NSMutableArray array];
    
    if (KGDevice_Is_iPhoneX == YES) {
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 88, KGscreenWidth, KGscreenHeight - 88)];
    }else{
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KGscreenWidth, KGscreenHeight - 64)];
    }
    _listTableView.rowHeight = 100.0f;
    _listTableView.tableFooterView = [UIView new];
    _listTableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    __weak typeof(self) MySelf = self;
    if (_dataArr.count == 0) {
        UIImageView *normalIamge = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KGscreenWidth, KGscreenHeight)];
        normalIamge.image = KGImage(@"zhanwei");
        _listTableView.tableHeaderView = normalIamge;
    }
    _listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 0;
        [MySelf.dataArr removeAllObjects];
        [MySelf.listTableView.mj_header beginRefreshing];
        [MySelf show];
        [MySelf setDataArray];
    }];
    
    _listTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [MySelf.listTableView.mj_footer beginRefreshing];
        [MySelf show];
        [MySelf setDataArray];
    }];
    
    [self.view addSubview:_listTableView];
    [self setDataArray];
    [self setDetaialView];
}

- (void)show{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hide{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)setDataArray{
    
    __weak typeof(self) mySelf = self;
    [[KGRequest sharedInstance] roomStareHotellId:_hotellId page:[NSString stringWithFormat:@"%ld",page] pageSize:[NSString stringWithFormat:@"%ld",pageSize] succ:^(NSString *msg, id data) {
        if ([msg isEqualToString:@"成功"]) {
            NSArray *dateAr = data;
            for (int i = 0; i < dateAr.count; i++) {
                NSDictionary *dateDic = dateAr[i];
                [_dateArray addObject:dateDic[@"checkInTime"]];
                NSArray *userInfoArr = dateDic[@"data"];
                for (int j = 0; j < userInfoArr.count; j++) {
                    NSDictionary *userDic = userInfoArr[j];
                    KGUserInfoModel *model = [[KGUserInfoModel alloc]initWithDictionary:userDic];
                    [_dataArr addObject:model];
                }
            }
            [mySelf hide];
            [mySelf.listTableView.mj_header endRefreshing];
            [mySelf.listTableView.mj_footer endRefreshing];
            if (mySelf.dataArr.count > 0) {
                _listTableView.tableHeaderView = [UIView new];
            }
            [_listTableView reloadData];
        }
    } fail:^(NSString *error) {
        [mySelf alertViewControllerTitle:@"提示" message:error name:@"确定" type:0 preferredStyle:1];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGRoomStarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KGRoomStarTableViewCell" owner:self options:nil] lastObject];
    }
    if (_dataArr.count > 0) {
        KGUserInfoModel *model = _dataArr[indexPath.row];
        cell.namelabel.text = [NSString stringWithFormat:@"姓名:%@",model.customName];
        cell.timeLabel.text = [NSString stringWithFormat:@"住房时间:%@-%@",model.checkInTime,model.checkOutTime];
        cell.orderLabel.text = [NSString stringWithFormat:@"联系方式:%@",model.customPhone];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dateArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _dateArray[section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _detaialView.hidden = NO;
    KGUserInfoModel *model = _dataArr[indexPath.row];
    [_detaialView changeMessageWithModel:model];
}

- (void)setDetaialView{
    _detaialView = [[KGRoomStarDetaialView alloc]initWithFrame:self.view.frame];
    _detaialView.hidden = YES;
    [self.view insertSubview:_detaialView atIndex:99];
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
