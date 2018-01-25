//
//  KGWaitViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGWaitViewController.h"
#import "KGTableView.h"
#import "KGOrderDetaialViewController.h"
#import "KGOrderInfoModel.h"
#import "KGorderDetaialModel.h"
#import <MessageUI/MessageUI.h>

@interface KGWaitViewController ()<KGtableviewDelegate,MFMessageComposeViewControllerDelegate>{
    NSInteger page;
    NSInteger pageSize;
}

@property (nonatomic,strong) KGTableView *listView;

@property (nonatomic,strong) UISegmentedControl *finishOrWait;
@property (nonatomic,strong) NSMutableArray *waitArr;
@property (nonatomic,strong) NSMutableArray *finishArr;
@property (nonatomic,strong) NSMutableArray *allArr;


@end

@implementation KGWaitViewController

/*
 
 
 *****************退房页面*****************
 
 
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KGOrangeColor;
    
    _waitArr = [NSMutableArray array];
    _finishArr = [NSMutableArray array];
    _allArr = [NSMutableArray array];
    page = 0;
    pageSize = 10;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationMessage:) name:@"sendMassage" object:nil];
    
    [self setDataArr];
    
    [self.view addSubview:[self setFinishOrWait]];
    
    [self setTableView];
    
}

- (void)notificationMessage:(NSNotification *)notif{
    NSString *orderId = notif.userInfo[@"orderId"];
    __weak typeof(self) MySelf = self;
    [[KGRequest sharedInstance] orderDetaial:orderId succ:^(NSString *msg, id data) {
        if ([msg isEqualToString:@"成功"]) {
            NSDictionary *dic = data;
            KGorderDetaialModel *model = [[KGorderDetaialModel alloc]initWithDictionary:dic];
            NSString *SMS = [NSString stringWithFormat:@"%@您好!/n您的退房订单已确认，如有疑问请联系客服:%@",model.customName,[[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"]];
            [MySelf alertViewControllerTitle:@"是否发送短信通知？" message:SMS name:@"发送" phone:model.customPhoneNo preferredStyle:1];
        }
    } fail:^(NSString *error) {
        
    }];
    
}

-(void)dealloc{
    //移除观察者，Observer不能为nil
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)setDataArr{
    __weak typeof(self) MySelf = self;
    [[KGRequest sharedInstance] hotelAllOrder:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] queryType:@"1" succ:^(NSString *msg, id data) {
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
    _listView.Mydelegate = self;
    _listView.titleArr = [NSMutableArray array];
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

/**
 警告框
 
 @param title 显示警告框标题
 @param message 显示警告框信息
 @param name 按钮显示信息
 */
- (void)alertViewControllerTitle:(NSString *)title message:(NSString *)message name:(NSString *)name phone:(NSString *)phone preferredStyle:(UIAlertControllerStyle)preferredStyle{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    UIAlertAction *sureAct = [UIAlertAction actionWithTitle:name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if( [MFMessageComposeViewController canSendText] )
        {
            MFMessageComposeViewController *messager = [[MFMessageComposeViewController alloc]init];
            messager.body = message;
            messager.recipients = @[phone];
            messager.messageComposeDelegate = self;
            [self presentViewController:messager animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *canalAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:sureAct];
    [alert addAction:canalAct];
    
    [self presentViewController:alert animated:YES completion:nil];
    
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
