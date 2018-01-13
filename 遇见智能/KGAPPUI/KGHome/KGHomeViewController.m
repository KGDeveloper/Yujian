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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"酒店";
    
    page = 0;
    pageSize = 10;
    
    [self setUpRightNavButtonItmeTitle:@"编辑" icon:nil];
    [self setDataArr];
    [self setListView];
    [self initAddHotellBut];
}

- (void)setDataArr{
    _dataArr = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    [[KGRequest sharedInstance] homeUserPhone:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] page:[NSString stringWithFormat:@"%ld",(long)page] pageSize:[NSString stringWithFormat:@"%ld",(long)pageSize] succ:^(NSString *msg, id data) {
        if ([msg isEqualToString:@"成功"]) {
            NSArray *dataArray = data;
            for (int i = 0; i < dataArray.count; i++) {
                NSDictionary *dic = dataArray[i];
                KGHomeModel *model = [[KGHomeModel alloc]initWithDictionary:dic];
                [weakSelf.dataArr addObject:model];
            }
            [weakSelf.listView reloadData];
        }
    } fail:^(NSString *error) {
        
    }];
    
}

- (void)rightBarItmeClick:(UIButton *)sender{
    if (_listView.editing == YES) {
        _listView.editing = NO;
    }else{
        _listView.editing = YES;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self alertViewControllerTitle:@"提示" message:@"是否删除该酒店" name:@"删除" type:0 preferredStyle:1];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
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
    [self.navigationController pushViewController:home animated:YES];
}

#pragma mark -创建显示酒店名称的列表-
- (void)setListView{
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KGscreenWidth, KGscreenHeight - 49 - 64)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    _listView.tableFooterView = [UIView new];
    if (KGDevice_Is_iPhoneX == YES) {
        _listView.rowHeight = 315;
    }else{
        _listView.rowHeight = 340;
    }
    
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
        [cell.homeImage sd_setImageWithURL:[NSURL URLWithString:model.hotelPicture] placeholderImage:[UIImage imageNamed:@"listImage"]];
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
