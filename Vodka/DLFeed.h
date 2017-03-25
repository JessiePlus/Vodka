//
//  DLFeed.h
//  Vodka
//
//  Created by dinglin on 2017/3/25.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLFeed : NSObject

@property (nonatomic, assign) int mid;

@property (nonatomic, copy) NSString *objectId;

@property (nonatomic) NSURL *avatarImageUrl;//头像
@property (nonatomic, copy) NSString *nickName;//昵称
@property (nonatomic, copy) NSString *msgContent;//消息正文

@end
