//
//  GoodsCateroriesCell.m
//  Vodka
//
//  Created by dinglin on 2017/3/24.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLGoodsCateroriesCell.h"
#import <Masonry.h>

@implementation DLGoodsCateroriesCell

-(instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    
    return self;

}

-(void)makeUI {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLab];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@24);
        make.height.equalTo(@24);
        make.top.equalTo(self.contentView).offset(20);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@24);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(15);
        make.centerX.equalTo(self.iconImageView);
    }];
    
    
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


@end
