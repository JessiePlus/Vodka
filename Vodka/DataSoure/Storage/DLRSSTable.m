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
    return @[@"name",@"longlongText"];
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
