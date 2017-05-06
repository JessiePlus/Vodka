//
//  DLFeedItem.m
//  Vodka
//
//  Created by DingLin on 17/4/1.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLFeedItem.h"
#import <DLDBTool.h>

@implementation DLFeedItem
//必须重写此方法
+ (NSDictionary *)describeColumnDict{
    
    DLDBColumnDes *pk_id = [[DLDBColumnDes alloc] initWithAuto:YES isNotNull:NO check:nil defaultVa:nil];
    pk_id.primaryKey = YES;
    pk_id.columnName = @"pk_id";
    
    DLDBColumnDes *url = [[DLDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:YES isNotNull:NO check:nil defaultVa:nil];
    url.columnName = @"url";
    
    DLDBColumnDes *title = [[DLDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    title.columnName = @"title";
    
    DLDBColumnDes *date = [[DLDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    date.columnName = @"date";
    
    
    DLDBColumnDes *content = [[DLDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    content.columnName = @"content";
    
    DLDBColumnDes *fi_feedUrl_fk = [[DLDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    fi_feedUrl_fk.columnName = @"fi_feedUrl_fk";
    
    return @{@"pk_id":pk_id,@"url":url,@"title":title,@"date":date,@"content":content,@"fi_feedUrl_fk":fi_feedUrl_fk};
}

@end
