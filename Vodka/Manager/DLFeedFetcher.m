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

    // 查询出全部的RSS
    RLMResults<DLRSS *> *RSSList = [DLRSS allObjects];
    
    self.RSSList = RSSList;
    
    

}

//从数据库中分页取出feeds
-(void)fetchItems:(int)offset limit:(int)limit completion:(void (^)(NSArray <DLFeedItem *>*feedItems))completion {
#if 0
    NSArray<DLFeedItem*>*queryFeedItems = [DLFeedItem findByCriteria:[NSString stringWithFormat:@" WHERE pk > %d limit %d",offset ,limit]];

    if (completion) {
        completion(queryFeedItems);
    }
#endif

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
        operation.onParseFinished = ^(DLFeedInfo *feedInfo) {
            
            DDLogInfo(@"cache the feedInfo: %@", feedInfo);
            //解析完成，缓存到数据库
            
#if 0
            // 获取默认的 Realm 实例
            RLMRealm *realm = [RLMRealm defaultRealm];
            // 每个线程只需要使用一次即可
            
            // 通过事务将数据添加到 Realm 中
            [realm beginWriteTransaction];
            [realm addObject:feedInfo];
            [realm commitWriteTransaction];
#endif
            
        };
        [endOperation addDependency:operation];
        [self.operationQueue addOperation:operation];

    }
    
    [self.operationQueue addOperation:endOperation];



}

@end
