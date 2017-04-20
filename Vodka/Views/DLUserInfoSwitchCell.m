//
//  UserInfoSliderCell.m
//  Vodka
//
//  Created by dinglin on 2017/3/24.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLUserInfoSwitchCell.h"
#import <Masonry.h>

@implementation DLUserInfoSwitchCell

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
    
    self.accessoryView = self.titleSwitch;
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLab];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@24);
        make.height.equalTo(@24);
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@24);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.titleLab sizeToFit];
    
}

-(UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    
    return _iconImageView;
}

-(UISwitch *)titleSwitch {
    if (!_titleSwitch) {
        _titleSwitch = [[UISwitch alloc] init];
    }
    
    return _titleSwitch;
}

-(UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightLight];
    }
    
    return _titleLab;
}


@end
