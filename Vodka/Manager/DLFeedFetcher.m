//
//  DLFeedFetcher.m
//  Vodka
//
//  Created by dinglin on 2017/3/30.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLFeedFetcher.h"
#import <XMNetworking.h>
#import "DLRSS.h"
#import "DLRSSParseOperation.h"
#import "LKDBSQLState.h"

@interface DLFeedFetcher ()

@property (nonatomic) NSArray <DLRSS *>*RSSList;

@property (nonatomic) dispatch_queue_t sqliteQueue;
@property (nonatomic) NSOperationQueue *operationQueue;


@end

@implementation DLFeedFetcher

-(instancetype)init {
    self =[super init];
    if (self) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
        
        _sqliteQueue = dispatch_queue_create("com.Vodka.sqliteQueue", DISPATCH_QUEUE_CONCURRENT);

        
    }
    
    return self;

}

//从缓存中加载RSS列表
-(void)loadRSSList {
    
    LKDBSQLState *query = [[LKDBSQLState alloc] object:[DLRSS class] type:WHERE key:@"open" opt:@"=" value:@1];
    NSArray <DLRSS *>*RSSList = [DLRSS findByCriteria:[query sqlOptionStr]];
    
    self.RSSList = RSSList;

}

//解析feeds，并存入数据库
-(void)loadFeeds {

    if (self.onStartLoadFeeds) {
        self.onStartLoadFeeds();
    }
    
    [self loadRSSList];
    
    //所有RSS解析完成的时候，执行完成回调
    NSOperation *endOperation = [[NSOperation alloc] init];
    endOperation.completionBlock = ^{
        if (self.onStopLoadFeeds) {
            self.onStopLoadFeeds();
        }
    };
    
    //遍历RSS,根据RSS，创建NSOperation，请求相应的feeds
    for (int i = 0; i < self.RSSList.count; i ++) {
        
        DLRSS *RSS = self.RSSList[i];
        
        if (!RSS.feedUrl)
            continue;
        
        DLRSSParseOperation *operation = [[DLRSSParseOperation alloc] init];
        operation.RSS = RSS;
        operation.onParseFinished = ^(DLFeed *feed) {
            
            DDLogInfo(@"cache the feed: %@", feed);
            //解析完成，缓存到数据库
            DLFeedInfo *feedInfo = feed.feedInfo;
            
            dispatch_async(_sqliteQueue, ^{
                [feedInfo saveOrUpdateByColumnName:@"feedUrl" AndColumnValue:feedInfo.feedUrl];
            });
            
            NSArray <DLFeedItem *> *allFeedItems = feed.allFeedItems;
            for (DLFeedItem *feedItem in allFeedItems) {
                dispatch_async(_sqliteQueue, ^{
                    [feedItem saveOrUpdateByColumnName:@"url" AndColumnValue:feedItem.url];
                });
            }
            
        };
        [endOperation addDependency:operation];
        [self.operationQueue addOperation:operation];

    }
    
    [self.operationQueue addOperation:endOperation];



}

@end
