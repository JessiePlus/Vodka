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
    
    [self.contentView addSubview:self.likeBtn];
    [self.contentView addSubview:self.likeNumLab];
    [self.contentView addSubview:self.commentBtn];
    [self.contentView addSubview:self.commentNumLab];

    

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
        make.bottom.equalTo(self.likeBtn.mas_top).offset(-4);
    }];
    [self.msgContentLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];

    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@15);
        make.left.equalTo(self.avatarImageView.mas_right).with.offset(4);
        make.bottom.equalTo(self.contentView).with.offset(-4);
    }];
    
    [self.likeNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@12);
        make.width.equalTo(@60);
        make.left.equalTo(self.likeBtn.mas_right).with.offset(4);
        make.centerY.equalTo(self.likeBtn);
    }];
    
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@15);
        make.left.equalTo(self.likeNumLab.mas_right).offset(4);
        make.centerY.equalTo(self.likeBtn);
    }];
    
    [self.commentNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@12);
        make.width.equalTo(@60);
        make.left.equalTo(self.commentBtn.mas_right).with.offset(4);
        make.centerY.equalTo(self.likeBtn);
    }];
    
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


-(UIButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [[UIButton alloc] init];
        [_likeBtn setImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
    }
    
    return _likeBtn;
}

-(UILabel *)likeNumLab {
    if (!_likeNumLab) {
        _likeNumLab = [[UILabel alloc] init];
        _likeNumLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightLight];
    }
    
    return _likeNumLab;
}

-(UIButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [[UIButton alloc] init];
        [_commentBtn setImage:[UIImage imageNamed:@"icon_comment"] forState:UIControlStateNormal];

    }
    
    return _commentBtn;
}

-(UILabel *)commentNumLab {
    if (!_commentNumLab) {
        _commentNumLab = [[UILabel alloc] init];
        _commentNumLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightLight];
    }
    
    return _commentNumLab;
}



@end
