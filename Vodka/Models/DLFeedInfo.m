//
//  DLFeedInfo.m
//  Vodka
//
//  Created by DingLin on 17/4/1.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLFeedInfo.h"
#import "LKDBTool.h"

@implementation DLFeedInfo

//必须重写此方法
+ (NSDictionary *)describeColumnDict{
    
    LKDBColumnDes *pk_id = [[LKDBColumnDes alloc] initWithAuto:YES isNotNull:NO check:nil defaultVa:nil];
    pk_id.primaryKey = YES;
    pk_id.columnName = @"pk_id";
    
    LKDBColumnDes *feedUrl = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:YES isNotNull:NO check:nil defaultVa:nil];
    feedUrl.columnName = @"feedUrl";
    
    LKDBColumnDes *title = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    title.columnName = @"title";

    return @{@"pk_id":pk_id,@"feedUrl":feedUrl,@"title":title};
}

@end
