//
//  JYGradeTable.m
//  JYDatabase - OC
//
//  Created by weijingyun on 16/11/21.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "DLFeedInfoTable.h"
#import "DLFeedInfo.h"
#import "DLFeedItemTable.h"
#import "JYDBService.h"
#import "DLVodkaDB.h"

@implementation DLFeedInfoTable

- (void)configTableName{
    
    self.contentClass = [DLFeedInfo class];
    self.tableName = @"DLFeedInfoTable";
}

- (NSString *)contentId{
    return @"feedUrl";
}

- (NSArray<NSString *> *)getContentField{
    return @[@"title"];
}

// 设置关联的表
- (NSDictionary<NSString *, NSDictionary *> *)associativeTableField{
    
    DLFeedItemTable *table = [JYDBService shared].vodkaDB.feedItemTable;
    return @{
             @"allFeedItem" : @{
                     tableContentObject : table,
                     tableViceKey       : @"feedInfoID"
                     }
             };
}

- (NSDictionary*)fieldStorageType{
    return @{
             @"feedUrl" : @"TEXT",
             };
}

@end
