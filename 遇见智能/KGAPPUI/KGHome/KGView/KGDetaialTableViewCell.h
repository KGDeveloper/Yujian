//
//  KGDetaialTableViewCell.h
//  遇见智能
//
//  Created by KG on 2017/12/21.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGDetaialTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDLabel;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;

@end
