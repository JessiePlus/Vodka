//
//  DLRSSParseOperation.m
//  Vodka
//
//  Created by DingLin on 17/4/1.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLRSSParseOperation.h"
#import <MWFeedParser.h>



@interface DLRSSParseOperation () <MWFeedParserDelegate>

@property (nonatomic) MWFeedParser *parser;

@property (nonatomic) DLFeedInfo *feedInfo;

@property (nonatomic) NSMutableArray <DLFeedItem *>*feedItems;

@end

@implementation DLRSSParseOperation

-(instancetype)init {
    self = [super init];
    if (self) {

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
    feedInfo.feedUrl = [info.url absoluteString];
    
    _feedInfo = feedInfo;
}

-(void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    DDLogInfo(@"didParseFeedItem: %@", item);
    DLFeedItem *feedItem = [[DLFeedItem alloc] init];
    feedItem.title = item.title;
    feedItem.url = item.identifier;
    feedItem.content = item.content;
    
    if (!_feedItems) {
        _feedItems = [[NSMutableArray alloc] init];
    }
    
    [_feedItems addObject:feedItem];
}

-(void)feedParserDidFinish:(MWFeedParser *)parser {
    DDLogInfo(@"feedParserDidFinish");

    _feedInfo.allFeedItem = _feedItems;
    
    if (self.onParseFinished) {
        self.onParseFinished(_feedInfo);
    }
    
}

-(void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    DDLogError(@"didFailWithError");
    
    _feedInfo.allFeedItem = _feedItems;

    if (self.onParseFinished) {
        self.onParseFinished(_feedInfo);
    }
    
}




@end
