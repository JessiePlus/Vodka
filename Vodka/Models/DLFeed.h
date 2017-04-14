//
//  DLFeed.h
//  Vodka
//
//  Created by dinglin on 2017/4/14.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLFeedInfo.h"
#import "DLFeedItem.h"

@interface DLFeed : NSObject
@property (nonatomic) DLFeedInfo *feedInfo;
@property (nonatomic) NSArray <DLFeedItem *> *allFeedItems;

@end
