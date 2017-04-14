//
//  DLNewsCategory.h
//  Vodka
//
//  Created by dinglin on 2017/3/29.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "JKDBModel.h"

@interface DLRSSGroup : JKDBModel

@property (nonatomic, copy) NSString *rg_id;

//分组的名称
@property (nonatomic, copy) NSString *name;

@end

