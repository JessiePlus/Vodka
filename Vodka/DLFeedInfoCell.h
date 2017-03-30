//
//  DLFeedInfoCell.h
//  Vodka
//
//  Created by dinglin on 2017/3/25.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLFeedInfoCell : UITableViewCell

@property (nonatomic) UILabel *itemTitleLab;//文章名称
@property (nonatomic) UILabel *itemDateLab;//文章时间
@property (nonatomic) UILabel *infoTitleLab;//博客名称

@property (nonatomic) UIButton *likeBtn;//点赞
@property (nonatomic) UILabel *likeNumLab;//点赞个数

@property (nonatomic) UIButton *commentBtn;//评论
@property (nonatomic) UILabel *commentNumLab;//评论个数


@end
