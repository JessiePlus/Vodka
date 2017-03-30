//
//  DLFeedFetcher.h
//  Vodka
//
//  Created by dinglin on 2017/3/30.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLFeedFetcher : NSObject

//开始加载feeds
@property (nonatomic, copy) void (^onStartLoadFeeds)(void);

//加载feeds
-(void)loadFeeds;


@end
