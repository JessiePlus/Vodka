//
//  DLRSS.m
//  Vodka
//
//  Created by dinglin on 2017/3/29.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLRSS.h"
#import "LKDBTool.h"

@implementation DLRSS

//必须重写此方法
+ (NSDictionary *)describeColumnDict{
    
    LKDBColumnDes *pk_id = [[LKDBColumnDes alloc] initWithAuto:YES isNotNull:NO check:nil defaultVa:nil];
    pk_id.primaryKey = YES;
    pk_id.columnName = @"pk_id";
    
    LKDBColumnDes *r_id = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:YES isNotNull:NO check:nil defaultVa:nil];
    r_id.columnName = @"r_id";
    
    LKDBColumnDes *name = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    name.columnName = @"name";
    
    LKDBColumnDes *iconUrl = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    iconUrl.columnName = @"iconUrl";
    
    LKDBColumnDes *feedUrl = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    feedUrl.columnName = @"feedUrl";
    
    LKDBColumnDes *linkUrl = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    linkUrl.columnName = @"linkUrl";
    
    LKDBColumnDes *rg_id_fk = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    rg_id_fk.columnName = @"rg_id_fk";
    
    LKDBColumnDes *u_id_fk = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    u_id_fk.columnName = @"u_id_fk";
    
    LKDBColumnDes *open = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    open.columnName = @"open";

    return @{@"pk_id":pk_id,@"r_id":r_id,@"name":name,@"iconUrl":iconUrl,@"feedUrl":feedUrl,@"linkUrl":linkUrl,@"rg_id_fk":rg_id_fk,@"u_id_fk":u_id_fk,@"open":open};
}
@end
