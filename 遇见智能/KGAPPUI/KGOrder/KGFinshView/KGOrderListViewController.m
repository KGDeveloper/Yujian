//
//  KGOrderListViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGOrderListViewController.h"
#import "KGTableView.h"

@interface KGOrderListViewController ()

@property (nonatomic,strong) KGTableView *listView;

@property (nonatomic,strong) UISegmentedControl *finishOrWait;

@end

@implementation KGOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KGOrangeColor;
    
    [self.view addSubview:[self setFinishOrWait]];
    
    [self setTableView];
}

#pragma mark -导航栏订房退房标签-
- (UISegmentedControl *)setFinishOrWait{
    NSArray *titleArr = @[@"已完成",@"未完成",@"全部"];
    _finishOrWait = [[UISegmentedControl alloc]initWithItems:titleArr];
    if (KGDevice_Is_iPhoneX == YES) {
        _finishOrWait.frame = CGRectMake(0, 88, KGscreenWidth, 30);
    }else{
        _finishOrWait.frame = CGRectMake(0, 64, KGscreenWidth, 30);
    }
    _finishOrWait.selectedSegmentIndex = 0;
    _finishOrWait.tintColor = KGcolor(81, 159, 250, 1);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],
                         NSForegroundColorAttributeName,
                         [UIFont systemFontOfSize:12],
                         NSFontAttributeName,nil];
    
    [_finishOrWait setTitleTextAttributes:dic forState:UIControlStateSelected];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:KGcolor(81, 159, 250, 1),
                          NSForegroundColorAttributeName,
                          [UIFont systemFontOfSize:12],
                          NSFontAttributeName,nil];
    
    [_finishOrWait setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    [_finishOrWait addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    return _finishOrWait;
}

#pragma mark -分类按钮点击事件-
- (void)segmentValueChanged:(UISegmentedControl *)sender{
    switch (sender.selectedSegmentIndex) {
        case 0:
            _listView.titleArr = [NSMutableArray arrayWithObjects:@"一", nil];
            [_listView.listView reloadData];
            break;
        case 1:
            _listView.titleArr = [NSMutableArray arrayWithObjects:@"二",@"二", nil];
            [_listView.listView reloadData];
            break;
        default:
            _listView.titleArr = [NSMutableArray arrayWithObjects:@"三",@"三",@"三",nil];
            [_listView.listView reloadData];
            break;
    }
}

#pragma mark -创建tableView-
- (void)setTableView{
    _listView = [[KGTableView alloc]initWithFrame:CGRectMake(0, 118, KGscreenWidth, KGscreenHeight - 118 - 49)];
    _listView.titleArr = [NSMutableArray arrayWithObjects:@"一",nil];
    [self.view addSubview:_listView];
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
