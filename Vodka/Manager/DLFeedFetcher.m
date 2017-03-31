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

//加载RSS列表，并缓存
-(void)loadRSSList {
    //请求RSS的种类
    [XMCenter sendRequest:^(XMRequest *request) {
        request.api = @"classes/DLRSS";
        request.parameters = @{};
        request.headers = @{};
        request.httpMethod = kXMHTTPMethodGET;
        request.requestSerializerType = kXMRequestSerializerJSON;
    } onSuccess:^(id responseObject) {
        
        NSError *error;
        NSArray <DLRSS *>*RSSList = [DLRSS arrayOfModelsFromDictionaries:responseObject[@"results"] error:&error];
        
        //缓存到sqlite，findOrCreate
        dispatch_async(_sqliteQueue, ^{
        
            
            
        });
        
        
    } onFailure:^(NSError *error) {
        NSLog(@"onFailure: %@", error);
    } onFinished:^(id responseObject, NSError *error) {
        NSLog(@"onFinished");
    }];


}

//加载feeds
-(void)loadFeeds {

    if (self.onStartLoadFeeds) {
        self.onStartLoadFeeds();
    }
    
    //加载RSS列表，并缓存到数据库
    [self loadRSSList];
    
    //遍历RSS,请求相应的feeds
    dispatch_async(_sqliteQueue, ^{
        
        //查询数据库，获取RSSList
        
        
        //根据RSS，创建NSOperation，请求相应的feeds
        
        
        
        
        
        
        
    });
    


}

@end
