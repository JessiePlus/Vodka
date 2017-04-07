//
//  DLRSS.h
//  Vodka
//
//  Created by dinglin on 2017/3/29.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Realm/Realm.h>

@class DLRSSGroup;

@interface DLRSS : RLMObject

//对象编号
@property NSString *objectId;

@property NSDate *createdAt;
@property NSDate *updatedAt;

//RSS所属的分组
@property DLRSSGroup *RSSGroup;

//RSS的名称
@property NSString *name;
//RSS的图标
@property NSString *iconUrl;
//RSS的订阅链接
@property NSString *feedUrl;
//RSS的访问链接
@property NSString *url;

@end

