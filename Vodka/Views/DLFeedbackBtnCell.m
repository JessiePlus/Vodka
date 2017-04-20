//
//  UserInfoCell.m
//  Vodka
//
//  Created by dinglin on 2017/3/24.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLFeedbackBtnCell.h"
#import <Masonry.h>

@interface DLFeedbackBtnCell ()



@end

@implementation DLFeedbackBtnCell

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
    
    [self.contentView addSubview:self.btn];
    
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    
}

-(UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] init];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightLight];
    }
    
    return _btn;
}







@end
