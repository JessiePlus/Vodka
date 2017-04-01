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

@interface DLFeedFetcher ()

@property (nonatomic) dispatch_queue_t sqliteQueue;

@end

@implementation DLFeedFetcher

-(instancetype)init {
    self =[super init];
    if (self) {
        _sqliteQueue = dispatch_queue_create("com.Vodka.sqliteQueue", DISPATCH_QUEUE_CONCURRENT);

    }
    
    return self;

}

//从缓存中加载RSS列表
-(void)loadRSSList {

    dispatch_async(_sqliteQueue, ^{
        
        
        
    });

}

//加载feeds
-(void)loadFeeds {

    if (self.onStartLoadFeeds) {
        self.onStartLoadFeeds();
    }
    
    [self loadRSSList];
    
    //遍历RSS,请求相应的feeds
    dispatch_async(_sqliteQueue, ^{
        
        //根据RSS，创建NSOperation，请求相应的feeds

    });
    


}

@end
