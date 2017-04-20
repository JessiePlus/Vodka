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
    
    [self.contentView addSubview:self.itemTitleLab];
    [self.contentView addSubview:self.itemDateLab];
    [self.contentView addSubview:self.infoTitleLab];


    [self.itemTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    [self.itemDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@24);
        make.top.equalTo(self.itemTitleLab.mas_bottom).offset(10);
        make.left.equalTo(self.itemTitleLab);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.infoTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.itemDateLab);
        make.bottom.equalTo(self.itemDateLab);
        make.left.equalTo(self.itemDateLab.mas_right).offset(10);
    }];

    [self.itemDateLab sizeToFit];

    [self.infoTitleLab sizeToFit];
    
    [self.itemTitleLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
}

-(UILabel *)itemTitleLab {
    if (!_itemTitleLab) {
        _itemTitleLab = [[UILabel alloc] init];
        _itemTitleLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
        _itemTitleLab.numberOfLines = 0;
        _itemTitleLab.preferredMaxLayoutWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 40; // 多行时必须设置
    }
    
    return _itemTitleLab;
}

-(UILabel *)infoTitleLab {
    if (!_infoTitleLab) {
        _infoTitleLab = [[UILabel alloc] init];
        _infoTitleLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
    }
    
    return _infoTitleLab;
}

-(UILabel *)itemDateLab {
    if (!_itemDateLab) {
        _itemDateLab = [[UILabel alloc] init];
        _itemDateLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
    }
    
    return _itemDateLab;
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
        _likeNumLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
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
        _commentNumLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
    }
    
    return _commentNumLab;
}



@end
