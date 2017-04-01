//
//  JYPersonDB.m
//  JYDatabase - OC
//
//  Created by weijingyun on 16/5/9.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "DLVodkaDB.h"
#import "DLRSSGroupTable.h"
#import "DLRSSTable.h"
#import "DLFeedInfoTable.h"
#import "DLFeedItemTable.h"

#define dataBaseName @"DLVodkaDB.db"

@interface DLVodkaDB()

@property (nonatomic, strong) NSString * documentDirectory ;
@property (nonatomic, strong) DLRSSGroupTable  *RSSGroupTable;
@property (nonatomic, strong) DLRSSTable  *RSSTable;
@property (nonatomic, strong) DLFeedInfoTable  *feedInfoTable;
@property (nonatomic, strong) DLFeedItemTable  *feedItemTable;
@end


@implementation DLVodkaDB
+ (instancetype)storage{
    DLVodkaDB *vodkaDB = [[DLVodkaDB alloc] init];
    [vodkaDB construct];
    return vodkaDB;
}

- (void)construct{
    DDLogInfo(@"%@",self.documentDirectory);
    [self buildWithPath:self.documentDirectory mode:ArtDatabaseModeWrite registTable:^{
        //注册数据表 建议外引出来，用于其它位置调用封装
        self.RSSGroupTable = (DLRSSGroupTable *)[self registTableClass:[DLRSSGroupTable class]];
        self.RSSTable = (DLRSSTable *)[self registTableClass:[DLRSSTable class]];
        self.feedInfoTable = (DLFeedInfoTable *)[self registTableClass:[DLFeedInfoTable class]];
        self.feedItemTable = (DLFeedItemTable *)[self registTableClass:[DLFeedItemTable class]];

    }];
    
}

#pragma mark - 数据库版本
- (NSInteger)getCurrentDBVersion
{
    return 6;
}

#pragma make - 懒加载
- (NSString *)documentDirectory{
    if (!_documentDirectory) {
        NSString *path = [[(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)) lastObject] stringByAppendingPathComponent:@"DLVodkaDB"];
        
        NSFileManager* fm = [NSFileManager defaultManager];
        BOOL isDirectory = NO;
        if (![fm fileExistsAtPath:path isDirectory:&isDirectory] || !isDirectory) {
            [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        _documentDirectory = [path stringByAppendingPathComponent:dataBaseName];
        
    }
    return _documentDirectory;
}

@end
