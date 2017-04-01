//
//  JYDBService.m
//  JYDatabase - OC
//
//  Created by weijingyun on 16/5/9.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYDBService.h"
#import "DLRSSDB.h"
#import "DLRSSGroupTable.h"
#import "DLRSSGroup.h"
#import "DLRSSTable.h"
#import "DLRSS.h"

@interface JYDBService ()

@property (nonatomic, strong) DLRSSDB *RSSDB;

@end

@implementation JYDBService

+ (instancetype)shared{
    static JYDBService *globalService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalService = [[JYDBService alloc] init];
        globalService.RSSDB = [DLRSSDB storage];
    });
    return globalService;
}

# pragma mark DLRSSGroup operation
- (void)insertRSSGroup:(DLRSSGroup *)aRSSGroup{
    [self.RSSDB.RSSGroupTable insertContent:aRSSGroup];
}

- (void)insertRSSGroups:(NSArray<DLRSSGroup *> *)aRSSGroups{
    [self.RSSDB.RSSGroupTable insertContents:aRSSGroups];
}

- (void)insertIndependentRSSGroup:(DLRSSGroup *)aRSSGroup{
    [self.RSSDB.RSSGroupTable insertIndependentContent:aRSSGroup];
}

- (void)insertIndependentRSSGroups:(NSArray<DLRSSGroup *> *)aRSSGroups{
    [self.RSSDB.RSSGroupTable insertIndependentContents:aRSSGroups];
}

- (NSArray<DLRSSGroup *> *)getRSSGroupByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.RSSDB.RSSGroupTable getContentByConditions:block];
}

- (DLRSSGroup *)getRSSGroup:(NSString*)aRSSGroupID{
    return [self.RSSDB.RSSGroupTable getContentByID:aRSSGroupID];
}

- (NSArray<DLRSSGroup *> *)getRSSGroups:(NSArray<NSString *> *)aRSSGroupIDs{
    return [self.RSSDB.RSSGroupTable getContentByIDs:aRSSGroupIDs];
}

- (NSArray<DLRSSGroup *> *)getAllRSSGroup{
    return [self.RSSDB.RSSGroupTable getAllContent];
}

- (void)deleteRSSGroupByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.RSSDB.RSSGroupTable deleteContentByConditions:block];
}

- (void)deleteRSSGroups:(NSArray<NSString *>*)aRSSGroupIDs{
    [self.RSSDB.RSSGroupTable deleteContentByIDs:aRSSGroupIDs];
}

- (void)deleteRSSGroup:(NSString *)aRSSGroupID{
    [self.RSSDB.RSSGroupTable deleteContentByID:aRSSGroupID];
}

- (void)deleteAllRSSGroup{
    [self.RSSDB.RSSGroupTable deleteAllContent];
}

- (void)cleanRSSGroupBefore:(NSDate*)date{
    [self.RSSDB.RSSGroupTable cleanContentBefore:date];
}

- (NSInteger)getRSSGroupCountByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.RSSDB.RSSGroupTable getCountByConditions:block];
}

- (NSInteger)getRSSGroupAllCount{
    return [self.RSSDB.RSSGroupTable getAllCount];
}

# pragma mark DLRSS operation
- (void)insertRSS:(DLRSS *)aRSS{
    [self.RSSDB.RSSTable insertContent:aRSS];
}

- (void)insertRSSs:(NSArray<DLRSS *> *)aRSSs{
    [self.RSSDB.RSSTable insertContents:aRSSs];
}

- (void)insertIndependentRSS:(DLRSS *)aRSS{
    [self.RSSDB.RSSTable insertIndependentContent:aRSS];
}

- (void)insertIndependentRSSs:(NSArray<DLRSS *> *)aRSSs{
    [self.RSSDB.RSSTable insertIndependentContents:aRSSs];
}

- (NSArray<DLRSS *> *)getRSSByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.RSSDB.RSSTable getContentByConditions:block];
}

- (DLRSS *)getRSS:(NSString*)aRSSID{
    return [self.RSSDB.RSSTable getContentByID:aRSSID];
}

- (NSArray<DLRSS *> *)getRSSs:(NSArray<NSString *> *)aRSSIDs{
    return [self.RSSDB.RSSTable getContentByIDs:aRSSIDs];
}

- (NSArray<DLRSS *> *)getAllRSS{
    return [self.RSSDB.RSSTable getAllContent];
}

- (void)deleteRSSByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.RSSDB.RSSTable deleteContentByConditions:block];
}

- (void)deleteRSSs:(NSArray<NSString *>*)aRSSIDs{
    [self.RSSDB.RSSTable deleteContentByIDs:aRSSIDs];
}

- (void)deleteRSS:(NSString *)aRSSID{
    [self.RSSDB.RSSTable deleteContentByID:aRSSID];
}

- (void)deleteAllRSS{
    [self.RSSDB.RSSTable deleteAllContent];
}

- (void)cleanRSSBefore:(NSDate*)date{
    [self.RSSDB.RSSTable cleanContentBefore:date];
}

- (NSInteger)getRSSCountByConditions:(void (^)(JYQueryConditions *make))block{
    return [self.RSSDB.RSSTable getCountByConditions:block];
}

- (NSInteger)getRSSAllCount{
    return [self.RSSDB.RSSTable getAllCount];
}


@end
