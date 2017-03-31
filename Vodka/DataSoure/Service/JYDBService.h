//
//  JYDBService.h
//  JYDatabase - OC
//
//  Created by weijingyun on 16/5/9.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DLRSSDB,DLRSSGroup,DLRSS,JYQueryConditions;

@interface JYDBService : NSObject

+ (instancetype)shared;

@property (nonatomic, strong, readonly) DLRSSDB *RSSDB;

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




@end
