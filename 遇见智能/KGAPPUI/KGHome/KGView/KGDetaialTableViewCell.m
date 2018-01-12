//
//  KGDetaialTableViewCell.m
//  遇见智能
//
//  Created by KG on 2017/12/21.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGDetaialTableViewCell.h"

@implementation KGDetaialTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFrame:(CGRect)frame{
    //    frame.origin.y += 10;
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
