//
//  KGOrderListViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGOrderListViewController.h"
#import "KGTableView.h"
#import "KGOrderDetaialViewController.h"
#import "KGAddOrderViewController.h"
#import "KGOrderInfoModel.h"

@interface KGOrderListViewController ()<KGtableviewDelegate>{
    NSInteger page;
    NSInteger pageSize;
}

@property (nonatomic,strong) KGTableView *listView;

@property (nonatomic,strong) UISegmentedControl *finishOrWait;
@property (nonatomic,strong) NSMutableArray *waitArr;
@property (nonatomic,strong) NSMutableArray *finishArr;
@property (nonatomic,strong) NSMutableArray *allArr;
@property (nonatomic,strong) UIButton *addHotell;

@end

@implementation KGOrderListViewController
/*
 *****************订房页面*****************
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KGOrangeColor;
    
    _waitArr = [NSMutableArray array];
    _finishArr = [NSMutableArray array];
    _allArr = [NSMutableArray array];
    page = 0;
    pageSize = 10;
    [self setDataArr];
    [self.view addSubview:[self setFinishOrWait]];
    [self setTableView];
    [self initAddHotellBut];
    
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
    KGAddOrderViewController *addOrder = [[KGAddOrderViewController alloc]init];
    [[self viewController].navigationController pushViewController:addOrder animated:YES];
}


- (void)setDataArr{
    
    __weak typeof(self) MySelf = self;
    [[KGRequest sharedInstance] hotelAllOrder:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] queryType:@"0" succ:^(NSString *msg, id data) {
        NSArray *arr = data;
        for (int i = 0; i < arr.count; i++) {
            NSDictionary *dic = arr[i];
            if ([dic[@"hotelCheckStatus"] isEqualToString:@"未处理"]) {
                NSArray *waitArray = dic[@"data"];
                for (int j = 0; j < waitArray.count; j++) {
                    NSDictionary *waitDic = waitArray[j];
                    KGOrderInfoModel *model = [[KGOrderInfoModel alloc]initWithDictionary:waitDic];
                    [MySelf.waitArr addObject:model];
                }
            }else{
                NSArray *waitArray = dic[@"data"];
                for (int j = 0; j < waitArray.count; j++) {
                    NSDictionary *waitDic = waitArray[j];
                    KGOrderInfoModel *model = [[KGOrderInfoModel alloc]initWithDictionary:waitDic];
                    [MySelf.finishArr addObject:model];
                }
            }
        }
        [MySelf hide];
        [MySelf.listView.listView.mj_header endRefreshing];
        [MySelf.listView.listView.mj_footer endRefreshing];
        [_listView.listView reloadData];
    } fail:^(NSString *error) {
        
    }];
}


#pragma mark -导航栏订房退房标签-
- (UISegmentedControl *)setFinishOrWait{
    NSArray *titleArr = @[@"未完成",@"已完成",@"全部"];
    _finishOrWait = [[UISegmentedControl alloc]initWithItems:titleArr];
    if (KGDevice_Is_iPhoneX == YES) {
        _finishOrWait.frame = CGRectMake(0, 88, KGscreenWidth, 30);
    }else{
        _finishOrWait.frame = CGRectMake(0, 64, KGscreenWidth, 30);
    }
    _finishOrWait.selectedSegmentIndex = 0;
    _finishOrWait.tintColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    _finishOrWait.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:KGcolor(231, 99, 40, 1),
                         NSForegroundColorAttributeName,
                         [UIFont systemFontOfSize:17],
                         NSFontAttributeName,nil];
    
    [_finishOrWait setTitleTextAttributes:dic forState:UIControlStateSelected];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:KGCellDont,
                          NSForegroundColorAttributeName,
                          [UIFont systemFontOfSize:17],
                          NSFontAttributeName,nil];
    
    [_finishOrWait setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    [_finishOrWait addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    return _finishOrWait;
}

#pragma mark -分类按钮点击事件-
- (void)segmentValueChanged:(UISegmentedControl *)sender{
    NSMutableArray *arr = [NSMutableArray array];
    switch (sender.selectedSegmentIndex) {
        case 0:
            _listView.titleArr = _waitArr;
            [_listView.listView reloadData];
            break;
        case 1:
            _listView.titleArr = _finishArr;
            [_listView.listView reloadData];
            break;
        default:
            
            [arr addObjectsFromArray:_waitArr];
            [arr addObjectsFromArray:_finishArr];
            _listView.titleArr = arr;
            [_listView.listView reloadData];
            break;
    }
}

#pragma mark -创建tableView-
- (void)setTableView{
    if (KGDevice_Is_iPhoneX == YES) {
        _listView = [[KGTableView alloc]initWithFrame:CGRectMake(0, 118, KGscreenWidth, KGscreenHeight - 118 - 49)];
    }else{
        _listView = [[KGTableView alloc]initWithFrame:CGRectMake(0, 94, KGscreenWidth, KGscreenHeight - 94 - 49)];
    }
    _listView.Mydelegate = self;
    __weak typeof(self) MySelf = self;
    _listView.listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 0;
        [MySelf.waitArr removeAllObjects];
        [MySelf.finishArr removeAllObjects];
        [MySelf.allArr removeAllObjects];
        [MySelf.listView.listView.mj_header beginRefreshing];
        [MySelf show];
        [MySelf setDataArr];
    }];
    
    _listView.listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [MySelf.waitArr removeAllObjects];
        [MySelf.finishArr removeAllObjects];
        [MySelf.allArr removeAllObjects];
        [MySelf.listView.listView.mj_footer beginRefreshing];
        [MySelf show];
        [MySelf setDataArr];
    }];
    
    [self.view addSubview:_listView];
}

- (void)show{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hide{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)pushToDetaialController:(NSString *)order{
    
    KGOrderDetaialViewController *orderDetaial = [[KGOrderDetaialViewController alloc]init];
    orderDetaial.order = order;
    [[self viewController].navigationController pushViewController:orderDetaial animated:YES];
}

- (UIViewController *)viewController {
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

//- (void)reloadTableViewData{
//    [self setDataArr];
//}

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
