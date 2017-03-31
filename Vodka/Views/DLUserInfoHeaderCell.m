//
//  UserInfoHeaderView.m
//  Vodka
//
//  Created by dinglin on 2017/3/24.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLUserInfoHeaderCell.h"
#import <Masonry.h>

@implementation DLUserInfoHeaderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    
    return self;
}

-(void)makeUI {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLab];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        make.top.equalTo(self.contentView).offset(10);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@180);
        make.height.equalTo(@24);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
        make.centerX.equalTo(self.iconImageView);
    }];
    
    self.iconImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapiconImageView)];
    [self.iconImageView addGestureRecognizer:tap];
    
}

-(UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    
    return _iconImageView;
}

-(UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
    }
    
    return _titleLab;
}

-(void)tapiconImageView {
    if (self.iconImageViewTapAction) {
        self.iconImageViewTapAction();
    }
}

@end
