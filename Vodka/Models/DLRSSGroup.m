//
//  DLNewsCategory.m
//  Vodka
//
//  Created by dinglin on 2017/3/29.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLRSSGroup.h"
#import "LKDBTool.h"

@implementation DLRSSGroup

//必须重写此方法
+ (NSDictionary *)describeColumnDict{
   
    LKDBColumnDes *pk_id = [[LKDBColumnDes alloc] initWithAuto:YES isNotNull:NO check:nil defaultVa:nil];
    pk_id.primaryKey = YES;
    pk_id.columnName = @"pk_id";
    
    LKDBColumnDes *rg_id = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:YES isNotNull:NO check:nil defaultVa:nil];
    rg_id.columnName = @"rg_id";
    
    LKDBColumnDes *name = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:NO check:nil defaultVa:nil];
    name.columnName = @"name";
    
    return @{@"pk_id":pk_id,@"rg_id":rg_id,@"name":name};
}
@end
