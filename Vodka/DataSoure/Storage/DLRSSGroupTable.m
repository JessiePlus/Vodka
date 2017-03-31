//
//  JYGradeTable.m
//  JYDatabase - OC
//
//  Created by weijingyun on 16/11/21.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "DLRSSGroupTable.h"
#import "DLRSSGroup.h"
#import "DLRSSTable.h"
#import "JYDBService.h"
#import "DLRSSDB.h"

@implementation DLRSSGroupTable

- (void)configTableName{
    
    self.contentClass = [DLRSSGroup class];
    self.tableName = @"DLRSSGroupTable";
}

- (NSString *)contentId{
    return @"objectId";
}

- (NSArray<NSString *> *)getContentField{
    return @[@"name",@"longlongText"];
}

// 设置关联的表
- (NSDictionary<NSString *, NSDictionary *> *)associativeTableField{
    
    DLRSSTable *table = [JYDBService shared].RSSDB.RSSTable;
    return @{
             @"allRSS" : @{
                     tableContentObject : table,
                     tableViceKey       : @"RSSGroupID"
                     }
             };
}

- (NSDictionary*)fieldStorageType{
    return @{
             @"longlongText" : @"TEXT"
             };
}

- (NSDictionary *)fieldLenght{
    return @{
             @"longlongText" : @"128"
             };
}

// 为 objectId 加上索引
- (void)addOtherOperationForTable:(FMDatabase *)aDB{
    [self addDB:aDB uniques:@[@"objectId"]];
}

@end
