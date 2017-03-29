//
//  DLNewsCategory.m
//  Vodka
//
//  Created by dinglin on 2017/3/29.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLRSSCategory.h"

@implementation DLRSSCategory

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"imageUrl": @"image",
                                                                  }];
}

@end
