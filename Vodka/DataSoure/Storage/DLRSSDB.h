//
//  JYPersonDB.h
//  JYDatabase - OC
//
//  Created by weijingyun on 16/5/9.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYDataBase.h"

@class DLRSSGroupTable, DLRSSTable;

@interface DLRSSDB : JYDataBase

@property (nonatomic, strong, readonly) NSString      *documentDirectory;
@property (nonatomic, strong, readonly) DLRSSGroupTable  *RSSGroupTable;
@property (nonatomic, strong, readonly) DLRSSTable  *RSSTable;

+ (instancetype)storage;

@end
