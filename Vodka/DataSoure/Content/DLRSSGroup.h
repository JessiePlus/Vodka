//
//  DLNewsCategory.h
//  Vodka
//
//  Created by dinglin on 2017/3/29.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Realm/Realm.h>
#import "DLRSS.h"

RLM_ARRAY_TYPE(DLRSS) // 定义RLMArray<DLRSS>

@interface DLRSSGroup : RLMObject

//对象编号
@property NSString *objectId;

@property NSDate *createdAt;
@property NSDate *updatedAt;

//分组的名称
@property NSString *name;

//分组下的所有RSS
@property RLMArray<DLRSS> *allRSS;

@end

