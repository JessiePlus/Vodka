//
//  DLFeedFetcher.h
//  Vodka
//
//  Created by dinglin on 2017/3/30.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLFeedInfo.h"
#import "DLFeedItem.h"

@interface DLFeedFetcher : NSObject

//开始加载feeds
@property (nonatomic, copy) void (^onStartLoadFeeds)(void);

//停止加载feeds
@property (nonatomic, copy) void (^onStopLoadFeeds)(void);

//解析feeds，并存入数据库
-(void)loadFeeds;


@end
