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
    return @[@"name",@"updatedAt",@"createdAt"];
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
             @"createdAt" : @"TEXT",
             @"updatedAt" : @"TEXT"

             };
}

- (NSDictionary *)fieldLenght{
    return @{
             @"createdAt" : @"128",
             @"updatedAt" : @"128"
             };
}

@end
