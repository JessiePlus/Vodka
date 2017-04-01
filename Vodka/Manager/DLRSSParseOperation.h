//
//  DLRSSParseOperation.h
//  Vodka
//
//  Created by DingLin on 17/4/1.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLRSS.h"
#import "DLFeedInfo.h"
#import "DLFeedItem.h"

@interface DLRSSParseOperation : NSOperation

@property (nonatomic) DLRSS *RSS;
@property (nonatomic, copy) void (^onParseFinished)(DLFeedInfo *feedInfo);
@end
