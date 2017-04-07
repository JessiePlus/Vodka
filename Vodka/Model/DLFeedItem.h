//
//  DLFeedItem.h
//  Vodka
//
//  Created by DingLin on 17/4/1.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Realm/Realm.h>

@class DLFeedInfo;

@interface DLFeedItem : RLMObject

//feedItem所属的feedInfo
@property DLFeedInfo *feedInfo;

@property NSString *title;
//unique
@property NSString *url;
@property NSString *content;

@end
