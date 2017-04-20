//
//  UserInfoCell.m
//  Vodka
//
//  Created by dinglin on 2017/3/24.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLFeedbackContentCell.h"
#import <Masonry.h>

@interface DLFeedbackContentCell ()



@end

@implementation DLFeedbackContentCell

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
    
    [self.contentView addSubview:self.contentTF];
    
    
    [self.contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@180);
        make.height.equalTo(@24);
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
    }];
    
    
}

-(UITextField *)contentTF {
    if (!_contentTF) {
        _contentTF = [[UITextField alloc] init];
        _contentTF.font = [UIFont systemFontOfSize:15 weight:UIFontWeightLight];
    }
    
    return _contentTF;
}







@end
