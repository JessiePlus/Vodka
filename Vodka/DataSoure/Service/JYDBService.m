//
//  JYDBService.m
//  JYDatabase - OC
//
//  Created by weijingyun on 16/5/9.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYDBService.h"
#import "DLVodkaDB.h"

#import "DLRSSGroupTable.h"
#import "DLRSSGroup.h"
#import "DLRSSTable.h"
#import "DLRSS.h"
#import "DLFeedInfoTable.h"
#import "DLFeedInfo.h"
#import "DLFeedItemTable.h"
#import "DLFeedItem.h"

@interface JYDBService ()

@property (nonatomic, strong) DLVodkaDB *vodkaDB;

@end

@implementation JYDBService

+ (instancetype)shared{
    static JYDBService *globalService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalService = [[JYDBService alloc] init];
        globalService.vodkaDB = [DLVodkaDB storage];
    });
    return globalService;
}

# pragma mark DLRSSGroup operation
- (void)insertRSSGroup:(DLRSSGroup *)aRSSGroup{
    [self.vodkaDB.RSSGroupTable insertContent:aRSSGroup];
}

- (void)insertRSSGroups:(NSArray<DLRSSGroup *> *)aRSSGroups{
    [self.vodkaDB.RSSGroupTable insertContents:aRSSGroups];
}

- (void)insertIndependentRSSGroup:(DLRSSGroup *)aRSSGroup{
    [self.vodkaDB.RSSGroupTable insertIndependentContent:aRSSGroup];
}

- (void)insertIndependentRSSGroups:(NSArray<DLRSSGroup *> *)aRSSGroups{
    [self.vodkaDB.RSSGroupTable insertIndependentContents:aRSSGroups];
}

- (NSArray<DLRSSGroup *> *)getRSSGroupByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.vodkaDB.RSSGroupTable getContentByConditions:block];
}

- (DLRSSGroup *)getRSSGroup:(NSString*)aRSSGroupID{
    return [self.vodkaDB.RSSGroupTable getContentByID:aRSSGroupID];
}

- (NSArray<DLRSSGroup *> *)getRSSGroups:(NSArray<NSString *> *)aRSSGroupIDs{
    return [self.vodkaDB.RSSGroupTable getContentByIDs:aRSSGroupIDs];
}

- (NSArray<DLRSSGroup *> *)getAllRSSGroup{
    return [self.vodkaDB.RSSGroupTable getAllContent];
}

- (void)deleteRSSGroupByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.vodkaDB.RSSGroupTable deleteContentByConditions:block];
}

- (void)deleteRSSGroups:(NSArray<NSString *>*)aRSSGroupIDs{
    [self.vodkaDB.RSSGroupTable deleteContentByIDs:aRSSGroupIDs];
}

- (void)deleteRSSGroup:(NSString *)aRSSGroupID{
    [self.vodkaDB.RSSGroupTable deleteContentByID:aRSSGroupID];
}

- (void)deleteAllRSSGroup{
    [self.vodkaDB.RSSGroupTable deleteAllContent];
}

- (void)cleanRSSGroupBefore:(NSDate*)date{
    [self.vodkaDB.RSSGroupTable cleanContentBefore:date];
}

- (NSInteger)getRSSGroupCountByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.vodkaDB.RSSGroupTable getCountByConditions:block];
}

- (NSInteger)getRSSGroupAllCount{
    return [self.vodkaDB.RSSGroupTable getAllCount];
}

# pragma mark DLRSS operation
- (void)insertRSS:(DLRSS *)aRSS{
    [self.vodkaDB.RSSTable insertContent:aRSS];
}

- (void)insertRSSs:(NSArray<DLRSS *> *)aRSSs{
    [self.vodkaDB.RSSTable insertContents:aRSSs];
}

- (void)insertIndependentRSS:(DLRSS *)aRSS{
    [self.vodkaDB.RSSTable insertIndependentContent:aRSS];
}

- (void)insertIndependentRSSs:(NSArray<DLRSS *> *)aRSSs{
    [self.vodkaDB.RSSTable insertIndependentContents:aRSSs];
}

- (NSArray<DLRSS *> *)getRSSByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.vodkaDB.RSSTable getContentByConditions:block];
}

- (DLRSS *)getRSS:(NSString*)aRSSID{
    return [self.vodkaDB.RSSTable getContentByID:aRSSID];
}

- (NSArray<DLRSS *> *)getRSSs:(NSArray<NSString *> *)aRSSIDs{
    return [self.vodkaDB.RSSTable getContentByIDs:aRSSIDs];
}

- (NSArray<DLRSS *> *)getAllRSS{
    return [self.vodkaDB.RSSTable getAllContent];
}

- (void)deleteRSSByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.vodkaDB.RSSTable deleteContentByConditions:block];
}

- (void)deleteRSSs:(NSArray<NSString *>*)aRSSIDs{
    [self.vodkaDB.RSSTable deleteContentByIDs:aRSSIDs];
}

- (void)deleteRSS:(NSString *)aRSSID{
    [self.vodkaDB.RSSTable deleteContentByID:aRSSID];
}

- (void)deleteAllRSS{
    [self.vodkaDB.RSSTable deleteAllContent];
}

- (void)cleanRSSBefore:(NSDate*)date{
    [self.vodkaDB.RSSTable cleanContentBefore:date];
}

- (NSInteger)getRSSCountByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.vodkaDB.RSSTable getCountByConditions:block];
}

- (NSInteger)getRSSAllCount{
    return [self.vodkaDB.RSSTable getAllCount];
}

# pragma mark DLFeedInfo operation
- (void)insertFeedInfo:(DLFeedInfo *)aFeedInfo{
    [self.vodkaDB.feedInfoTable insertContent:aFeedInfo];
}

- (void)insertFeedInfos:(NSArray<DLFeedInfo *> *)aFeedInfos{
    [self.vodkaDB.feedInfoTable insertContents:aFeedInfos];
}

- (void)insertIndependentFeedInfo:(DLFeedInfo *)aFeedInfo{
    [self.vodkaDB.feedInfoTable insertIndependentContent:aFeedInfo];
}

- (void)insertIndependentFeedInfos:(NSArray<DLFeedInfo *> *)aFeedInfos{
    [self.vodkaDB.feedInfoTable insertIndependentContents:aFeedInfos];
}

- (NSArray<DLFeedInfo *> *)getFeedInfoByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.vodkaDB.feedInfoTable getContentByConditions:block];
}

- (DLFeedInfo *)getFeedInfo:(NSString*)aFeedInfoID{
    return [self.vodkaDB.feedInfoTable getContentByID:aFeedInfoID];
}

- (NSArray<DLFeedInfo *> *)getFeedInfos:(NSArray<NSString *> *)aFeedInfoIDs{
    return [self.vodkaDB.feedInfoTable getContentByIDs:aFeedInfoIDs];
}

- (NSArray<DLFeedInfo *> *)getAllFeedInfo{
    return [self.vodkaDB.feedInfoTable getAllContent];
}

- (void)deleteFeedInfoByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.vodkaDB.feedInfoTable deleteContentByConditions:block];
}

- (void)deleteFeedInfos:(NSArray<NSString *>*)aFeedInfoIDs{
    [self.vodkaDB.feedInfoTable deleteContentByIDs:aFeedInfoIDs];
}

- (void)deleteFeedInfo:(NSString *)aFeedInfoID{
    [self.vodkaDB.feedInfoTable deleteContentByID:aFeedInfoID];
}

- (void)deleteAllFeedInfo{
    [self.vodkaDB.feedInfoTable deleteAllContent];
}

- (void)cleanFeedInfoBefore:(NSDate*)date{
    [self.vodkaDB.feedInfoTable cleanContentBefore:date];
}

- (NSInteger)getFeedInfoCountByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.vodkaDB.feedInfoTable getCountByConditions:block];
}

- (NSInteger)getFeedInfoAllCount{
    return [self.vodkaDB.feedInfoTable getAllCount];
}

# pragma mark DLFeedItem operation
- (void)insertFeedItem:(DLFeedItem *)aFeedItem{
    [self.vodkaDB.feedItemTable insertContent:aFeedItem];
}

- (void)insertFeedItems:(NSArray<DLFeedItem *> *)aFeedItems{
    [self.vodkaDB.feedItemTable insertContents:aFeedItems];
}

- (void)insertIndependentFeedItem:(DLFeedItem *)aFeedItem{
    [self.vodkaDB.feedItemTable insertIndependentContent:aFeedItem];
}

- (void)insertIndependentFeedItems:(NSArray<DLFeedItem *> *)aFeedItems{
    [self.vodkaDB.feedItemTable insertIndependentContents:aFeedItems];
}

- (NSArray<DLFeedItem *> *)getFeedItemByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.vodkaDB.feedItemTable getContentByConditions:block];
}

- (DLFeedItem *)getFeedItem:(NSString*)aFeedItemID{
    return [self.vodkaDB.feedItemTable getContentByID:aFeedItemID];
}

- (NSArray<DLFeedItem *> *)getFeedItems:(NSArray<NSString *> *)aFeedItemIDs{
    return [self.vodkaDB.feedItemTable getContentByIDs:aFeedItemIDs];
}

- (NSArray<DLFeedItem *> *)getAllFeedItem{
    return [self.vodkaDB.feedItemTable getAllContent];
}

- (void)deleteFeedItemByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.vodkaDB.feedItemTable deleteContentByConditions:block];
}

- (void)deleteFeedItems:(NSArray<NSString *>*)aFeedItemIDs{
    [self.vodkaDB.feedItemTable deleteContentByIDs:aFeedItemIDs];
}

- (void)deleteFeedItem:(NSString *)aFeedItemID{
    [self.vodkaDB.feedItemTable deleteContentByID:aFeedItemID];
}

- (void)deleteAllFeedItem{
    [self.vodkaDB.feedItemTable deleteAllContent];
}

- (void)cleanFeedItemBefore:(NSDate*)date{
    [self.vodkaDB.feedItemTable cleanContentBefore:date];
}

- (NSInteger)getFeedItemCountByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.vodkaDB.feedItemTable getCountByConditions:block];
}

- (NSInteger)getFeedItemAllCount{
    return [self.vodkaDB.feedItemTable getAllCount];
}


@end
