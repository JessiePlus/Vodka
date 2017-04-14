//
//  DLRSS.h
//  Vodka
//
//  Created by dinglin on 2017/3/29.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "JKDBModel.h"


@interface DLRSS : JKDBModel

@property (nonatomic, copy) NSString *r_id;

//RSS的名称
@property (nonatomic, copy) NSString *name;

//RSS的图标
@property (nonatomic, copy) NSString *iconUrl;

//RSS的订阅链接
@property (nonatomic, copy) NSString *feedUrl;

//RSS的访问链接
@property (nonatomic, copy) NSString *linkUrl;

//外键，DLRSSGroup的id
@property (nonatomic, copy) NSString *rg_id_fk;

@end

