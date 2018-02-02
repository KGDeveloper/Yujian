//
//  KGHomeViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGHomeViewController.h"
#import "KGHomeListTableViewCell.h"
#import "KGAddHomeViewController.h"
#import "KGRoomViewController.h"
#import "KGHomeModel.h"

@interface KGHomeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger page;
    NSInteger pageSize;
}

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UIButton *addHotell;

@end

@implementation KGHomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [_listView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"酒店";
    
    page = 0;
    pageSize = 10;
    _dataArr = [NSMutableArray array];

    [self setListView];
    [self initAddHotellBut];
}

- (void)setDataArr{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [[KGRequest sharedInstance] homeUserPhone:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] page:[NSString stringWithFormat:@"%ld",(long)page] pageSize:[NSString stringWithFormat:@"%ld",(long)pageSize] succ:^(NSString *msg, id data) {
        if ([msg isEqualToString:@"成功"]) {
            NSArray *dataArray = data;
            for (int i = 0; i < dataArray.count; i++) {
                NSDictionary *dic = dataArray[i];
                KGHomeModel *model = [[KGHomeModel alloc]initWithDictionary:dic];
                [weakSelf.dataArr addObject:model];
            }
            if (weakSelf.dataArr.count > 0) {
                weakSelf.listView.tableFooterView = [UIView new];
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [weakSelf.listView.mj_header endRefreshing];
            [weakSelf.listView.mj_footer endRefreshing];
            [weakSelf.listView reloadData];
        }
    } fail:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [weakSelf.listView.mj_header endRefreshing];
        [weakSelf.listView.mj_footer endRefreshing];
    }];
    
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) Myself = self;
    KGHomeModel *model = _dataArr[indexPath.row];
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[KGRequest sharedInstance] deleteHotell:model.hotelId succ:^(NSString *msg, id data) {
            if ([msg isEqualToString:@"成功"]) {
                [Myself.dataArr removeObject:model];
                [Myself.listView reloadData];
            }else{
                [self alertViewControllerTitle:@"提示" message:@"删除失败" name:@"确定" type:0 preferredStyle:1];
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } fail:^(NSString *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [Myself alertViewControllerTitle:@"提示" message:@"访问服务器失败" name:@"确定" type:0 preferredStyle:1];
        }];
    }];
    UITableViewRowAction *actionTwo = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"修改" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        KGAddHomeViewController *addHotel = [[KGAddHomeViewController alloc]init];
        addHotel.type = @"修改";
        addHotel.hotelId = model.hotelId;
        [Myself.navigationController pushViewController:addHotel animated:YES];
        
    }];
    actionTwo.backgroundColor = [UIColor grayColor];
    return @[action,actionTwo];
}

#pragma mark -添加酒店-
- (void)initAddHotellBut{
    _addHotell = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    _addHotell.center = CGPointMake(KGscreenWidth - 50, KGscreenHeight - 150);
    [_addHotell setImage:[UIImage imageNamed:@"Addto"] forState:UIControlStateNormal];
    [_addHotell addTarget:self action:@selector(addHotell:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:_addHotell atIndex:99];
}

#pragma mark -导航栏右侧添加按钮-
- (void)addHotell:(UIButton *)sender{
    KGAddHomeViewController *home = [[KGAddHomeViewController alloc]init];
    home.type = @"添加";
    [self.navigationController pushViewController:home animated:YES];
}

#pragma mark -创建显示酒店名称的列表-
- (void)setListView{
    
    UIImageView *normalIamge = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KGscreenWidth, KGscreenHeight)];
    normalIamge.image = KGImage(@"zhanwei");
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KGscreenWidth, KGscreenHeight - 49 - 64)];
    _listView.delegate = self;
    _listView.dataSource = self;
    if (_dataArr.count == 0) {
        _listView.tableFooterView = normalIamge;
    }
    _listView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    if (KGDevice_Is_iPhoneX == YES) {
        _listView.rowHeight = 315;
    }else{
        _listView.rowHeight = 340;
    }
    __weak typeof(self) weakSelf = self;
    _listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 0;
        [weakSelf.dataArr removeAllObjects];
        [weakSelf.listView.mj_header beginRefreshing];
        [weakSelf setDataArr];
    }];
    
    _listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [weakSelf.listView.mj_footer beginRefreshing];
        [weakSelf setDataArr];
    }];
    
    [self.view addSubview:_listView];
}

#pragma mark -遵守tableView协议-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGHomeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KGHomeListTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArr.count > 0) {
        KGHomeModel *model = _dataArr[indexPath.row];
        cell.nameLabel.text = model.hotelName;
        cell.priceLabel.text = model.defaultPrice;
        cell.addressLabel.text = model.detailAddress;
        cell.telephoneLabel.text = model.customeServicePhoneNo;
        [cell.homeImage sd_setImageWithURL:[NSURL URLWithString:model.hotelPicture] placeholderImage:[UIImage imageNamed:@"Bigpicture"]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KGRoomViewController *controller = [[KGRoomViewController alloc]init];
    KGHomeModel *model = _dataArr[indexPath.row];
    controller.hotellId = model.hotelId;
    [self.navigationController pushViewController:controller animated:YES];
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
