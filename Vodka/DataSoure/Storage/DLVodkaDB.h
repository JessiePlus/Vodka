//
//  JYPersonDB.h
//  JYDatabase - OC
//
//  Created by weijingyun on 16/5/9.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYDataBase.h"

@class DLRSSGroupTable, DLRSSTable, DLFeedInfoTable, DLFeedItemTable;

@interface DLVodkaDB : JYDataBase

@property (nonatomic, strong, readonly) NSString      *documentDirectory;
@property (nonatomic, strong, readonly) DLRSSGroupTable  *RSSGroupTable;
@property (nonatomic, strong, readonly) DLRSSTable  *RSSTable;
@property (nonatomic, strong, readonly) DLFeedInfoTable  *feedInfoTable;
@property (nonatomic, strong, readonly) DLFeedItemTable  *feedItemTable;
+ (instancetype)storage;

@end
