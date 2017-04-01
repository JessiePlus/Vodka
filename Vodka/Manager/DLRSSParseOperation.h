//
//  DLRSSParseOperation.h
//  Vodka
//
//  Created by DingLin on 17/4/1.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLRSS.h"
#import "DLFeed.h"
@interface DLRSSParseOperation : NSOperation

@property (nonatomic) DLRSS *RSS;
@property (nonatomic, copy) void (^onParseFinished)(DLFeed *feed);
@end
