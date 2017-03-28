//
//  DLFeedInfoCell.h
//  Vodka
//
//  Created by dinglin on 2017/3/25.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLFeedInfoCell : UITableViewCell

@property (nonatomic) UIImageView *avatarImageView;//头像
@property (nonatomic) UILabel *nickNameLab;//昵称
@property (nonatomic) UILabel *msgContentLab;//消息正文

@property (nonatomic) UIButton *likeBtn;//点赞
@property (nonatomic) UILabel *likeNumLab;//点赞个数

@property (nonatomic) UIButton *commentBtn;//评论
@property (nonatomic) UILabel *commentNumLab;//评论个数


@end
