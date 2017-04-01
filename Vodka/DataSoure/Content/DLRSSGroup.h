//
//  DLNewsCategory.h
//  Vodka
//
//  Created by dinglin on 2017/3/29.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLRSS.h"


@interface DLRSSGroup : NSObject

//对象编号
@property (nonatomic, copy) NSString *objectId;

@property (nonatomic) NSDate *createdAt;
@property (nonatomic) NSDate *updatedAt;

//分组的名称
@property (nonatomic, copy) NSString *name;

//分组下的所有RSS
@property (nonatomic, strong) NSArray<DLRSS *> *allRSS;

@end
