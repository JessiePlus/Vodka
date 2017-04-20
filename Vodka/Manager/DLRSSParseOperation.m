//
//  DLRSSParseOperation.m
//  Vodka
//
//  Created by DingLin on 17/4/1.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLRSSParseOperation.h"
#import <MWFeedParser.h>
#import "AppUtil.h"



@interface DLRSSParseOperation () <MWFeedParserDelegate>

@property (nonatomic) MWFeedParser *parser;

@property (nonatomic) DLFeed *feed;

@property (nonatomic) NSMutableArray <DLFeedItem *>*feedItems;

@end

@implementation DLRSSParseOperation

-(instancetype)init {
    self = [super init];
    if (self) {
        _feed = [[DLFeed alloc] init];
    }

    return self;
}

@synthesize finished = _finished;
@synthesize executing = _executing;

-(void)setFinished:(BOOL)finished{
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

-(void)setExecuting:(BOOL)executing{
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isAsynchronous{
    return YES;
}



-(void)start {
    
    if(!self.RSS || [self.RSS.feedUrl isEqualToString:@""]){
        self.finished = YES;
        return;
    }
    
    if(self.isCancelled){
        self.finished = YES;
        return;
    }
    
    self.executing = YES;
    
    _parser = [[MWFeedParser alloc] initWithFeedURL:[NSURL URLWithString:self.RSS.feedUrl]];
    _parser.delegate = self;
    
    if (![_parser parse]) {
        DDLogError(@"run parse failed: %@", self.RSS.feedUrl);
        self.finished = YES;

        return;
    }
    
    [super start];
}

-(void)cancel {
    [_parser stopParsing];
    [super cancel];
}

#pragma mark MWFeedParserDelegate
-(void)feedParserDidStart:(MWFeedParser *)parser {
    DDLogInfo(@"feedParserDidStart");
}

-(void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
    DLFeedInfo *feedInfo = [[DLFeedInfo alloc] init];
    feedInfo.title = info.title;
    feedInfo.feedUrl = [info.url absoluteString];
    
    _feed.feedInfo = feedInfo;
}

-(void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    DLFeedItem *feedItem = [[DLFeedItem alloc] init];
    feedItem.title = item.title;
    
    
    if (item.identifier) {
        feedItem.url = item.identifier;
    } else {
        feedItem.url = item.link;
    }
    
    if (item.content) {
        feedItem.content = item.content;
    } else {
        feedItem.content = item.summary;
    }

    feedItem.date = [[AppUtil util] formatDate:item.date];
    feedItem.fi_feedUrl_fk = _feed.feedInfo.feedUrl;//补上外键
    
    
    
    
    if (!_feedItems) {
        _feedItems = [[NSMutableArray alloc] init];
    }
    
    [_feedItems addObject:feedItem];
}

-(void)feedParserDidFinish:(MWFeedParser *)parser {
    DDLogInfo(@"feedParserDidFinish");

    _feed.allFeedItems = _feedItems;
    
    if (self.onParseFinished) {
        self.onParseFinished(_feed);
    }
    self.finished = YES;

}

-(void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    DDLogError(@"didFailWithError");
    
    _feed.allFeedItems = _feedItems;
    
    if (self.onParseFinished) {
        self.onParseFinished(_feed);
    }
    self.finished = YES;
    
}




@end
