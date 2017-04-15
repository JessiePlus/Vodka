//
//  DLNewsCategory.h
//  Vodka
//
//  Created by dinglin on 2017/3/29.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "LKDBModel.h"

@interface DLRSSGroup : LKDBModel

@property (nonatomic, assign) int pk_id;

@property (nonatomic, copy) NSString *rg_id;

//分组的名称
@property (nonatomic, copy) NSString *name;

@end

