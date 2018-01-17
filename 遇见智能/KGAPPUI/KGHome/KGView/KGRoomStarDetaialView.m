//
//  KGRoomStarDetaialView.m
//  遇见智能
//
//  Created by KG on 2018/1/16.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import "KGRoomStarDetaialView.h"

@interface KGRoomStarDetaialView ()

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIImageView *faceImage;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *sexLabel;
@property (nonatomic,strong) UILabel *groupLabel;
@property (nonatomic,strong) UILabel *birthdayLabel;
@property (nonatomic,strong) UILabel *homeAddressLabel;
@property (nonatomic,strong) UILabel *IDLabel;

@end

@implementation KGRoomStarDetaialView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KGcolor(210, 226, 226, 0.5);
        [self setUserICMessage];
    }
    return self;
}

- (void)setUserICMessage{
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGscreenWidth - 100, KGscreenHeight - 300)];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.center = CGPointMake(KGscreenWidth/2, KGscreenHeight/2);
    _backView.layer.cornerRadius = 10;
    _backView.layer.masksToBounds = YES;
    [self addSubview:_backView];
    
    _faceImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _backView.frame.size.width/2, _backView.frame.size.height/3)];
    _faceImage.center = CGPointMake(_backView.frame.size.width/2, _backView.frame.size.height/6 + 20);
    _faceImage.image = KGImage(@"Gettheverifyingcode1");
    _faceImage.layer.cornerRadius = 10;
    _faceImage.layer.masksToBounds = YES;
    [_backView addSubview:_faceImage];
    
    NSArray *titleArr = @[@"姓        名:",@"性        别:",@"民        族:",@"出生年月:",@"身份证号:",@"家庭住址:"];
    for (int i = 0; i < titleArr.count ; i++) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, _backView.frame.size.height/3 + 60 + 25 * i, 60, 20)];
        titleLabel.text = titleArr[i];
        titleLabel.textColor = KGCellDont;
        titleLabel.font = KGFont(13);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_backView addSubview:titleLabel];
    }
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, _backView.frame.size.height/3 + 60, _backView.frame.size.width - 100, 20)];
    _nameLabel.text = @"轩哥哥";
    _nameLabel.textColor = KGCellDont;
    _nameLabel.font = KGFont(13);
    [_backView addSubview:_nameLabel];
    
    _sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(85,_nameLabel.frame.origin.y + _nameLabel.frame.size.height + 5, _backView.frame.size.width - 100, 20)];
    _sexLabel.text = @"男";
    _sexLabel.textColor = KGCellDont;
    _sexLabel.font = KGFont(13);
    [_backView addSubview:_sexLabel];
    
    _groupLabel = [[UILabel alloc]initWithFrame:CGRectMake(85,_sexLabel.frame.origin.y + _sexLabel.frame.size.height + 5, _backView.frame.size.width - 100, 20)];
    _groupLabel.text = @"汉";
    _groupLabel.textColor = KGCellDont;
    _groupLabel.font = KGFont(13);
    [_backView addSubview:_groupLabel];
    
    _birthdayLabel = [[UILabel alloc]initWithFrame:CGRectMake(85,_groupLabel.frame.origin.y + _groupLabel.frame.size.height + 5, _backView.frame.size.width - 100, 20)];
    _birthdayLabel.text = @"20180116";
    _birthdayLabel.textColor = KGCellDont;
    _birthdayLabel.font = KGFont(13);
    [_backView addSubview:_birthdayLabel];
    
    _IDLabel = [[UILabel alloc]initWithFrame:CGRectMake(85,_birthdayLabel.frame.origin.y + _birthdayLabel.frame.size.height + 5, _backView.frame.size.width - 100, 20)];
    _IDLabel.text = @"632125201801161132";
    _IDLabel.textColor = KGCellDont;
    _IDLabel.font = KGFont(13);
    [_backView addSubview:_IDLabel];
    
    _homeAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(85,_IDLabel.frame.origin.y + _IDLabel.frame.size.height + 5, _backView.frame.size.width - 100, 20)];
    _homeAddressLabel.text = @"中国北京市海淀区车道沟紫馨大厦A座10层1006室";
    _homeAddressLabel.textColor = KGCellDont;
    _homeAddressLabel.font = KGFont(13);
    _homeAddressLabel.lineBreakMode = NSUnderlineByWord;
    _homeAddressLabel.numberOfLines = 0;
    [_homeAddressLabel sizeToFit];
    [_backView addSubview:_homeAddressLabel];
    
}

- (void)changeMessageWithModel:(KGUserInfoModel *)model{
    
    NSData *decodedImageData = [[NSData alloc]initWithBase64EncodedString:model.customPictureLink options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *imageUrl = [UIImage imageWithData:decodedImageData];
    _faceImage.image = imageUrl;
    _nameLabel.text = model.customName;
    _sexLabel.text = model.customSex;
    _groupLabel.text = model.customNational;
    _birthdayLabel.text = model.customBirthDay;
    _IDLabel.text = model.customIdCard;
    _homeAddressLabel.text = model.customHomeAddr;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.hidden = YES;
}

@end
