//
//  DLRSSParseOperation.m
//  Vodka
//
//  Created by DingLin on 17/4/1.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLRSSParseOperation.h"
#import <MWFeedParser.h>
#import "DLFeed.h"

@interface DLRSSParseOperation () <MWFeedParserDelegate>

@property (nonatomic) MWFeedParser *parser;
@property (nonatomic) DLFeed *feed;

@property (nonatomic) NSMutableArray *feedItemList;

@end

@implementation DLRSSParseOperation

-(instancetype)init {
    self = [super init];
    if (self) {
        _feed = [[DLFeed alloc] init];
    }

    return self;
}

-(void)start {
    _parser = [[MWFeedParser alloc] initWithFeedURL:self.RSS.feedUrl];
    _parser.delegate = self;
    
    if (![_parser parse]) {
        DDLogError(@"run parse failed: %@", self.RSS.feedUrl);

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
    DDLogInfo(@"didParseFeedInfo: %@", info);
    DLFeedInfo *feedInfo = [[DLFeedInfo alloc] init];
    feedInfo.title = info.title;
    feedInfo.link = info.link;
    
    _feed.feedInfo = feedInfo;
}

-(void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    DDLogInfo(@"didParseFeedItem: %@", item);
    DLFeedItem *feedItem = [[DLFeedItem alloc] init];
    feedItem.title = item.title;
    feedItem.link = item.link;
    feedItem.content = item.content;
    
    if (!_feedItemList) {
        _feedItemList = [[NSMutableArray alloc] init];
    }
    
    [_feedItemList addObject:feedItem];
}

-(void)feedParserDidFinish:(MWFeedParser *)parser {
    DDLogInfo(@"feedParserDidFinish");
    _feed.allFeedItem = _feedItemList;

    if (self.onParseFinished) {
        self.onParseFinished(_feed);
    }
    
}

-(void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    DDLogError(@"didFailWithError");
    _feed.allFeedItem = _feedItemList;
    
    if (self.onParseFinished) {
        self.onParseFinished(_feed);
    }
    
}




@end
