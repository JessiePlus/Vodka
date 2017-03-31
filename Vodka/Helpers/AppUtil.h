//
//  AppUtil.h
//  Vodka
//
//  Created by dinglin on 2017/3/30.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUtil : NSObject

+ (AppUtil*)util;
- (NSString *)formatDate:(NSDate *)date;

@end
