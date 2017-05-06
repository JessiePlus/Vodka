//
//  DLNewsCategory.m
//  Vodka
//
//  Created by dinglin on 2017/3/29.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLRSSGroup.h"
#import <DLDBTool.h>

@implementation DLRSSGroup

//必须重写此方法
+ (NSDictionary *)describeColumnDict{
   
    DLDBColumnDes *pk_id = [[DLDBColumnDes alloc] initWithAuto:YES isNotNull:NO check:nil defaultVa:nil];
    pk_id.primaryKey = YES;
    pk_id.columnName = @"pk_id";
    
    DLDBColumnDes *rg_id = [[DLDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:YES isNotNull:NO check:nil defaultVa:nil];
    rg_id.columnName = @"rg_id";
    
    DLDBColumnDes *name = [[DLDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    name.columnName = @"name";
    
    DLDBColumnDes *u_id_fk = [[DLDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    u_id_fk.columnName = @"u_id_fk";
    
    return @{@"pk_id":pk_id,@"rg_id":rg_id,@"name":name,@"u_id_fk":u_id_fk};
}
@end
