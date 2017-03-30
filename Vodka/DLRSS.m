//
//  DLRSS.m
//  Vodka
//
//  Created by dinglin on 2017/3/29.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLRSS.h"

@implementation DLRSS

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"iconUrl": @"icon",
                                                                  @"feedUrl": @"feed_url",
                                                                  }];
}

@end
