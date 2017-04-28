//
//  DLFeedInfoCell.m
//  Vodka
//
//  Created by dinglin on 2017/3/25.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLRSSInfoCell.h"
#import <Masonry.h>

@implementation DLRSSInfoCell
    
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
    
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.discripLab];
    [self.contentView addSubview:self.feedUrlLab];
    
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    [self.discripLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@24);
        make.top.equalTo(self.nameLab.mas_bottom).offset(10);
        make.left.equalTo(self.nameLab);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.feedUrlLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.discripLab);
        make.bottom.equalTo(self.discripLab);
        make.left.equalTo(self.discripLab.mas_right).offset(10);
    }];
    
    [self.discripLab sizeToFit];
    
    [self.feedUrlLab sizeToFit];
    
    [self.nameLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
}
    
-(UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
        _nameLab.numberOfLines = 0;
        _nameLab.preferredMaxLayoutWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 40; // 多行时必须设置
    }
    
    return _nameLab;
}
    
-(UILabel *)feedUrlLab {
    if (!_feedUrlLab) {
        _feedUrlLab = [[UILabel alloc] init];
        _feedUrlLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
    }
    
    return _feedUrlLab;
}
    
-(UILabel *)discripLab {
    if (!_discripLab) {
        _discripLab = [[UILabel alloc] init];
        _discripLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
    }
    
    return _discripLab;
}
    
    @end
