//
//  DLRSS.m
//  Vodka
//
//  Created by dinglin on 2017/3/29.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLRSS.h"
#import <DLDBTool.h>

@implementation DLRSS

//必须重写此方法
+ (NSDictionary *)describeColumnDict{
    
    DLDBColumnDes *pk_id = [[DLDBColumnDes alloc] initWithAuto:YES isNotNull:NO check:nil defaultVa:nil];
    pk_id.primaryKey = YES;
    pk_id.columnName = @"pk_id";
    
    DLDBColumnDes *r_id = [[DLDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:YES isNotNull:NO check:nil defaultVa:nil];
    r_id.columnName = @"r_id";
    
    DLDBColumnDes *name = [[DLDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    name.columnName = @"name";
    
    DLDBColumnDes *discrip = [[DLDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    discrip.columnName = @"discrip";
    
    DLDBColumnDes *iconUrl = [[DLDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    iconUrl.columnName = @"iconUrl";
    
    DLDBColumnDes *feedUrl = [[DLDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    feedUrl.columnName = @"feedUrl";
    
    DLDBColumnDes *linkUrl = [[DLDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    linkUrl.columnName = @"linkUrl";
    
    DLDBColumnDes *rg_id_fk = [[DLDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    rg_id_fk.columnName = @"rg_id_fk";
    
    DLDBColumnDes *u_id_fk = [[DLDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    u_id_fk.columnName = @"u_id_fk";
    
    DLDBColumnDes *open = [[DLDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    open.columnName = @"open";

    return @{@"pk_id":pk_id,@"r_id":r_id,@"name":name,@"discrip":discrip,@"iconUrl":iconUrl,@"feedUrl":feedUrl,@"linkUrl":linkUrl,@"rg_id_fk":rg_id_fk,@"u_id_fk":u_id_fk,@"open":open};
}
@end
