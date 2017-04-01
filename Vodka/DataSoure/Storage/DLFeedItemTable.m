//
//  JYGradeTable.m
//  JYDatabase - OC
//
//  Created by weijingyun on 16/11/21.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "DLFeedItemTable.h"
#import "DLFeedItem.h"
#import "JYDBService.h"
#import "DLVodkaDB.h"

@implementation DLFeedItemTable

- (void)configTableName{
    
    self.contentClass = [DLFeedItem class];
    self.tableName = @"DLFeedItemTable";
}

- (NSString *)contentId{
    return @"url";
}

- (NSArray<NSString *> *)getContentField{
    return @[@"feedInfoID",@"title",@"content"];
}


- (NSDictionary*)fieldStorageType{
    return @{
             @"url" : @"TEXT",
             @"feedInfoID" : @"TEXT",
             @"content" : @"TEXT"
             };
}

// 为 feedInfoID 加上索引
- (void)addOtherOperationForTable:(FMDatabase *)aDB{
    [self addDB:aDB uniques:@[@"feedInfoID"]];
}

@end
