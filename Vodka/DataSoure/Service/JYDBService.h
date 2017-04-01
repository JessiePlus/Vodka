//
//  JYDBService.h
//  JYDatabase - OC
//
//  Created by weijingyun on 16/5/9.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DLVodkaDB,DLRSSGroup,DLRSS,DLFeedInfo,DLFeedItem,JYQueryConditions;

@interface JYDBService : NSObject

+ (instancetype)shared;

@property (nonatomic, strong, readonly) DLVodkaDB *vodkaDB;

#pragma mark - 以下代码由 DEMO 中 JYGenerationCode 工具生成

# pragma mark DLRSSGroup operation
- (void)insertRSSGroup:(DLRSSGroup *)aRSSGroup;
- (void)insertRSSGroups:(NSArray<DLRSSGroup *> *)aRSSGroups;
- (void)insertIndependentRSSGroup:(DLRSSGroup *)aRSSGroup;
- (void)insertIndependentRSSGroups:(NSArray<DLRSSGroup *> *)aRSSGroups;

- (NSArray<DLRSSGroup *> *)getRSSGroupByConditions:(void (^)(JYQueryConditions *make))block;
- (DLRSSGroup *)getRSSGroup:(NSString*)aRSSGroupID;
- (NSArray<DLRSSGroup *> *)getRSSGroups:(NSArray<NSString *> *)aRSSGroupIDs;
- (NSArray<DLRSSGroup *> *)getAllRSSGroup;

- (void)deleteRSSGroupByConditions:(void (^)(JYQueryConditions *make))block;
- (void)deleteRSSGroups:(NSArray<NSString *>*)aRSSGroupIDs;
- (void)deleteRSSGroup:(NSString *)aRSSGroupID;
- (void)deleteAllRSSGroup;
- (void)cleanRSSGroupBefore:(NSDate*)date;

- (NSInteger)getRSSGroupCountByConditions:(void (^)(JYQueryConditions *make))block;
- (NSInteger)getRSSGroupAllCount;

# pragma mark DLRSS operation
- (void)insertRSS:(DLRSS *)aRSS;
- (void)insertRSSs:(NSArray<DLRSS *> *)aRSSs;
- (void)insertIndependentRSS:(DLRSS *)aRSS;
- (void)insertIndependentRSSs:(NSArray<DLRSS *> *)aRSSs;

- (NSArray<DLRSS *> *)getRSSByConditions:(void (^)(JYQueryConditions *make))block;
- (DLRSS *)getRSS:(NSString*)aRSSID;
- (NSArray<DLRSS *> *)getRSSs:(NSArray<NSString *> *)aRSSIDs;
- (NSArray<DLRSS *> *)getAllRSS;

- (void)deleteRSSByConditions:(void (^)(JYQueryConditions *make))block;
- (void)deleteRSSs:(NSArray<NSString *>*)aRSSIDs;
- (void)deleteRSS:(NSString *)aRSSID;
- (void)deleteAllRSS;
- (void)cleanRSSBefore:(NSDate*)date;

- (NSInteger)getRSSCountByConditions:(void (^)(JYQueryConditions *make))block;
- (NSInteger)getRSSAllCount;

# pragma mark DLFeedInfo operation
- (void)insertFeedInfo:(DLFeedInfo *)aFeedInfo;
- (void)insertFeedInfos:(NSArray<DLFeedInfo *> *)aFeedInfos;
- (void)insertIndependentFeedInfo:(DLFeedInfo *)aFeedInfo;
- (void)insertIndependentFeedInfos:(NSArray<DLFeedInfo *> *)aFeedInfos;

- (NSArray<DLFeedInfo *> *)getFeedInfoByConditions:(void (^)(JYQueryConditions *make))block;
- (DLFeedInfo *)getFeedInfo:(NSString*)aFeedInfoID;
- (NSArray<DLFeedInfo *> *)getFeedInfos:(NSArray<NSString *> *)aFeedInfoIDs;
- (NSArray<DLFeedInfo *> *)getAllFeedInfo;

- (void)deleteFeedInfoByConditions:(void (^)(JYQueryConditions *make))block;
- (void)deleteFeedInfos:(NSArray<NSString *>*)aFeedInfoIDs;
- (void)deleteFeedInfo:(NSString *)aFeedInfoID;
- (void)deleteAllFeedInfo;
- (void)cleanFeedInfoBefore:(NSDate*)date;

- (NSInteger)getFeedInfoCountByConditions:(void (^)(JYQueryConditions *make))block;
- (NSInteger)getFeedInfoAllCount;

# pragma mark DLFeedItem operation
- (void)insertFeedItem:(DLFeedItem *)aFeedItem;
- (void)insertFeedItems:(NSArray<DLFeedItem *> *)aFeedItems;
- (void)insertIndependentFeedItem:(DLFeedItem *)aFeedItem;
- (void)insertIndependentFeedItems:(NSArray<DLFeedItem *> *)aFeedItems;

- (NSArray<DLFeedItem *> *)getFeedItemByConditions:(void (^)(JYQueryConditions *make))block;
- (DLFeedItem *)getFeedItem:(NSString*)aFeedItemID;
- (NSArray<DLFeedItem *> *)getFeedItems:(NSArray<NSString *> *)aFeedItemIDs;
- (NSArray<DLFeedItem *> *)getAllFeedItem;

- (void)deleteFeedItemByConditions:(void (^)(JYQueryConditions *make))block;
- (void)deleteFeedItems:(NSArray<NSString *>*)aFeedItemIDs;
- (void)deleteFeedItem:(NSString *)aFeedItemID;
- (void)deleteAllFeedItem;
- (void)cleanFeedItemBefore:(NSDate*)date;

- (NSInteger)getFeedItemCountByConditions:(void (^)(JYQueryConditions *make))block;
- (NSInteger)getFeedItemAllCount;






@end
