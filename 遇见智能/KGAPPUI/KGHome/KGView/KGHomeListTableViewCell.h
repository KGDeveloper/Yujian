//
//  KGHomeListTableViewCell.h
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGHomeListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *homeImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *wifiBtu;
@property (weak, nonatomic) IBOutlet UIButton *tolBtu;
@property (weak, nonatomic) IBOutlet UIButton *refBtu;
@property (weak, nonatomic) IBOutlet UIButton *bxBtu;
@property (weak, nonatomic) IBOutlet UIButton *bfBti;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *wdBtu;

@end
