//
//  KGAboutViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGAboutViewController.h"

@interface KGAboutViewController ()<UITextViewDelegate>

@end

@implementation KGAboutViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于我们";
    
    self.view.backgroundColor = KGOrangeColor;
    [self createLabel];
}

#pragma mark -关于我们-
- (void)createLabel{
    UITextView *text = [[UITextView alloc]initWithFrame:CGRectMake(50, 100, KGscreenWidth - 100, KGscreenHeight - 150)];
    text.text = @"关于创业邦\n创业邦成立于2007年，是全维度创业者服务平台，公司及相关基金先后获得IDG、DCM、红杉、北极光、赛富、腾讯投资、启赋等国内外顶级投资机构投资，为创业者提供跨平台媒体、会展、培训、孵化空间、天使基金全方位服务。\n产品与服务\n创业邦媒体\n包括创业邦杂志、网站、App、微信、微博、头条号、企鹅号、榜单、研究报告、项目库等在内的全平台创业信息服务矩阵，以专业的科技创投视角关注创业相关的资讯与经验、资本与人才、模式与产品，发掘新一代商业领袖并向他们提供全面服务。\n创新中国Demo China\n2006年在北京首秀的创业邦自有品牌活动，创新产品服务和商业模式的展示平台，覆盖全国逾90%的创业群体。每年筛选各领域优质初创企业上台路演展示项目，并吸引熊晓鸽、徐小平、沈南鹏、阎焱、邓锋等超过1500位国内外顶级投资人列席，以连接最优质的资本与最优秀的创业者。截至2017年，累计报名项目超过2.5万家，帮助企业融资超过60亿元。\n创业邦100未来领袖峰会\n中国创业领域最盛大的交流活动之一，是中国新锐商业领袖、高成长企业CEO和顶级投资人共同切磋成长经验、探寻商业机会、展望商业趋势的年度盛会。峰会期间发布的“中国创新企业100强（创业邦100）”榜单，关注最有潜力的创业公司，致力于挖掘具备独角兽潜质的创新公司。此外，还会颁布“年度天使投资人”、“年度创业人物”、“30岁以下创业新贵”等创投领域重要奖项。\n创业邦星际学院\n创业技能和信息补给的在线平台。以最高效快捷的移动互联网方式，每年推出上百款付费产品。产品包含音频节目、直播、微课、报告、文档等产品形态，帮助初阶创业者迅速掌握创业实践中团队组织、资金募集、产品研发及市场推广等方面所需要的实战技能，大幅提升创业成功几率。自2016年7月推出以来，已连接上万名创业者。\n创业邦星际营Bang Camp\n创业邦旗下加速计划。作为创业教育版“Google”，通过与顶级资本和产业公司深度合作，为学员提供“资本＋产业精准对接、商业实战训练、1V1导师辅导、媒体曝光”等全链程服务，助力创业者思维通道和能力结构的快速搭建。截至2017年8月，已加速7期，共351个企业。\n创业邦邦空间Demo Space\n提供优质协同办公空间和全面孵化服务，以专业化的创业及产业服务，集合投资机构、产业资源、地方政府等创业要素，助推优秀企业走向卓越。目前已在北京、上海、深圳、杭州、广州、苏州、南京、无锡、常州、成都、重庆11个城市开放，空间面积共计4万平方。\n创业邦天使基金\n专注于投资具有独角兽潜质的早期创业公司，重点关注前沿科技、文体娱乐、企业服务与消费升级等方向，并为已投企业提供媒体、孵化、投融资及产业资源对接等全维度的投后服务。创业邦天使基金同时拥有美元及人民币基金，现已投资Insta360、礼物说、易思汇、诸葛IO、宜花、冻品在线、水滴互助等40余个项目。";
    text.textColor = [UIColor whiteColor];
    text.backgroundColor = [UIColor clearColor];
    text.font = [UIFont fontWithName:@"Arial" size:15.0f];
    text.textAlignment = NSTextAlignmentCenter;
    text.delegate         = self;
    text.editable         = YES;
    
    [self.view addSubview:text];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
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
