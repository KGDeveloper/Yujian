//
//  KGCustomerViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGCustomerViewController.h"
#import "KGCustomeTableViewCell.h"

@interface KGCustomerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation KGCustomerViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"客服";
    
    [self setUpTableView];
}

// -- 封装一个方法来创建UITableView
- (void) setUpTableView{
    
    // -- 创建UItableView
    _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KGscreenWidth, KGscreenHeight-64) style:UITableViewStylePlain];
    
    // -- 遵守协议，设置代理人
    [_listView setDelegate:self];
    
    [_listView setDataSource:self];
    _listView.backgroundColor = KGOrangeColor;
    _listView.rowHeight = 50;
    _listView.tableFooterView = [UIView new];
    _listView.scrollEnabled = NO;
    
    // -- 添加到父视图
    [self.view addSubview:_listView];
    
    
}

// -- 返回有多少行cell
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    // -- 返回数组的元素个数
    
    return 5;
}

// -- 返回cell
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // -- 创建一个静态的字符串变量
    static NSString *ID = @"ID";
    
    // -- 从tableview里取出标识符为ID的cell
    KGCustomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        /*
         UITableViewCellStyleDefault,   // -- 左侧显示textLabel 的内容（不显示DetailLabel的内容），cell.ImageView可选，显示在最左边
         
         UITableViewCellStyleValue1, // -- 左侧显示textLabel 的内容，右侧显示DetailLabel的内容，cell.ImageView可选，显示在最左边
         
         UITableViewCellStyleValue2,     // -- 左侧依次显示textLabel 和DetailLabel的内容，cell.ImageView不显示
         
         UITableViewCellStyleSubtitle     // -- 左上方显示textLabel 的内容，左下方显示DetailLabel的内容，cell.ImageView可选，显示在最左边
         /
         */
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KGCustomeTableViewCell" owner:self options:nil] lastObject];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    
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
