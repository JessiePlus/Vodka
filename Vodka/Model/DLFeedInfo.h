//
//  DLFeedInfo.h
//  Vodka
//
//  Created by DingLin on 17/4/1.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLFeedItem.h"

@interface DLFeedInfo : NSObject

#if 0
//对象编号，主键，自增
@property (nonatomic, assign) NSUInteger mID;
#endif

@property (nonatomic, copy) NSString *title;

//unique
@property (nonatomic) NSString *feedUrl;

//feedInfo下的所有feedItem
@property (nonatomic, strong) NSArray<DLFeedItem *> *allFeedItem;

@end
