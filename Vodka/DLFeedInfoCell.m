//
//  DLFeedInfoCell.m
//  Vodka
//
//  Created by dinglin on 2017/3/25.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLFeedInfoCell.h"
#import <Masonry.h>

@implementation DLFeedInfoCell

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
    
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.nickNameLab];
    [self.contentView addSubview:self.msgContentLab];

    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@44);
        make.left.and.top.equalTo(self.contentView).with.offset(4);
    }];
    
    [self.nickNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@22);
        make.top.equalTo(self.contentView).with.offset(4);
        make.left.equalTo(self.avatarImageView.mas_right).with.offset(4);
        make.right.equalTo(self.contentView).with.offset(-4);
    }];
    
    [self.msgContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameLab.mas_bottom).with.offset(4);
        make.left.equalTo(self.avatarImageView.mas_right).with.offset(4);
        make.right.equalTo(self.contentView).with.offset(-4);
        make.bottom.equalTo(self.contentView).with.offset(-4);
    }];
    [self.msgContentLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];

}

-(UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
    }
    
    return _avatarImageView;
}

-(UILabel *)nickNameLab {
    if (!_nickNameLab) {
        _nickNameLab = [[UILabel alloc] init];
        _nickNameLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightLight];
    }
    
    return _nickNameLab;
}

-(UILabel *)msgContentLab {
    if (!_msgContentLab) {
        _msgContentLab = [[UILabel alloc] init];
        _msgContentLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightLight];
        _msgContentLab.numberOfLines = 0;
        _msgContentLab.preferredMaxLayoutWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 44 - 4 * 3; // 多行时必须设置
    }
    
    return _msgContentLab;
}




@end
