//
//  DLFeedItem.m
//  Vodka
//
//  Created by DingLin on 17/4/1.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLFeedItem.h"
#import "LKDBTool.h"

@implementation DLFeedItem
//必须重写此方法
+ (NSDictionary *)describeColumnDict{
    
    LKDBColumnDes *pk_id = [[LKDBColumnDes alloc] initWithAuto:YES isNotNull:NO check:nil defaultVa:nil];
    pk_id.primaryKey = YES;
    pk_id.columnName = @"pk_id";
    
    LKDBColumnDes *url = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:YES isNotNull:NO check:nil defaultVa:nil];
    url.columnName = @"url";
    
    LKDBColumnDes *title = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    title.columnName = @"title";
    
    LKDBColumnDes *date = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    date.columnName = @"date";
    
    
    LKDBColumnDes *content = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    content.columnName = @"content";
    
    LKDBColumnDes *fi_feedUrl_fk = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    fi_feedUrl_fk.columnName = @"fi_feedUrl_fk";
    
    return @{@"pk_id":pk_id,@"url":url,@"title":title,@"date":date,@"content":content,@"fi_feedUrl_fk":fi_feedUrl_fk};
}

@end
