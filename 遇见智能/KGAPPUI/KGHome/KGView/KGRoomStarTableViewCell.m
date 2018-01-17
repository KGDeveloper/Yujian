//
//  KGRoomStarTableViewCell.m
//  遇见智能
//
//  Created by KG on 2018/1/16.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import "KGRoomStarTableViewCell.h"

@implementation KGRoomStarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
