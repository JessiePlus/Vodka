//
//  TableSectionTitleView.m
//  Vodka
//
//  Created by dinglin on 2017/3/25.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLGoodsInfoSectionTitleView.h"
#import <Masonry.h>

@implementation DLGoodsInfoSectionTitleView


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    
    return self;

}

-(void)makeUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.titleLab];

    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@180);
        make.height.equalTo(@24);
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView);
    }];
    
    
}

-(UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textColor = [UIColor blackColor];
    }
    
    return _titleLab;
}
@end
