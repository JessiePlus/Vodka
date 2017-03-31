//
//  UserInfoHeaderView.h
//  Vodka
//
//  Created by dinglin on 2017/3/24.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLUserInfoHeaderCell : UITableViewCell

@property (nonatomic) UIImageView *iconImageView;
@property (nonatomic) UILabel *titleLab;

@property (nonatomic, copy) void (^iconImageViewTapAction)(void);

@end
