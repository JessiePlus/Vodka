//
//  VodkaService.m
//  Vodka
//
//  Created by dinglin on 2017/3/5.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "VodkaService.h"



@implementation VodkaService

- (NSURL *)apiBaseUrl
{
    return [NSURL URLWithString:@"https://api.leancloud.cn"];
}

-(NSString *)apiAppID {
    return @"x6XqOXajuBXl7KAPgkDGVm2v-gzGzoHsz";
}

-(NSString *)apiAppKey {
    return @"HlGlENGF6ki2CL32REOskquL";
}

-(NSString *)apiToken {
    return @"";
}

+ (instancetype)sharedManager {
    static VodkaService *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

@end
