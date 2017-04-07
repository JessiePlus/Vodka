//
//  DLFeedInfo.h
//  Vodka
//
//  Created by DingLin on 17/4/1.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Realm/Realm.h>
#import "DLFeedItem.h"
RLM_ARRAY_TYPE(DLFeedItem) // 定义RLMArray<DLFeedItem>

@interface DLFeedInfo : RLMObject

@property NSString *title;

//unique
@property NSString *feedUrl;

//feedInfo下的所有feedItem
@property RLMArray<DLFeedItem> *allFeedItem;

@end
