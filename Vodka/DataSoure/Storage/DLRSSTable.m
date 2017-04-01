//
//  JYGradeTable.m
//  JYDatabase - OC
//
//  Created by weijingyun on 16/11/21.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "DLRSSTable.h"
#import "DLRSS.h"
#import "JYDBService.h"
#import "DLRSSDB.h"

@implementation DLRSSTable

- (void)configTableName{
    
    self.contentClass = [DLRSS class];
    self.tableName = @"DLRSSTable";
}

- (NSString *)contentId{
    return @"objectId";
}

- (NSArray<NSString *> *)getContentField{
    return @[@"name",@"updatedAt",@"createdAt",@"iconUrl",@"feedUrl",@"url"];
}


- (NSDictionary*)fieldStorageType{
    return @{
             @"createdAt" : @"TEXT",
             @"updatedAt" : @"TEXT",
             @"iconUrl" : @"TEXT",
             @"feedUrl" : @"TEXT",
             @"url" : @"TEXT"

             };
}

- (NSDictionary *)fieldLenght{
    return @{
             @"createdAt" : @"128",
             @"updatedAt" : @"128",
             @"iconUrl" : @"128",
             @"feedUrl" : @"128",
             @"url" : @"128"
             };
}

// 为 RSSGroupID 加上索引
- (void)addOtherOperationForTable:(FMDatabase *)aDB{
    [self addDB:aDB uniques:@[@"RSSGroupID"]];
}

@end
