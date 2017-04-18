//
//  VodkaUserDefaults.m
//  Vodka
//
//  Created by dinglin on 2017/4/17.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "VodkaUserDefaults.h"
#import "AppUtil.h"

NSString * const accessTokenKey = @"accessToken";
NSString * const nameKey = @"name";
NSString * const cityKey = @"city";
NSString * const userIDKey = @"userID";



@interface VodkaUserDefaults ()

@property (nonatomic) NSUserDefaults *userDefaults;

@end

@implementation VodkaUserDefaults

+ (instancetype)sharedUserDefaults {
    static VodkaUserDefaults *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    DDLogInfo(@"VodkaUserDefaults init");

    _userDefaults = [[NSUserDefaults alloc] initWithSuiteName:[AppUtil appGroupID]];
    
    return self;
}

-(void)dealloc {
    DDLogInfo(@"VodkaUserDefaults init");

}

-(NSString *)accessToken {
    return [self.userDefaults valueForKey:accessTokenKey];
}

-(void)setAccessToken:(NSString *)accessToken {
    [self.userDefaults setObject:accessToken forKey:accessTokenKey];
}


-(NSString *)name {
    return [self.userDefaults valueForKey:nameKey];
}

-(void)setName:(NSString *)name {
    [self.userDefaults setObject:name forKey:nameKey];
}

-(NSString *)city {
    return [self.userDefaults valueForKey:cityKey];
}

-(void)setCity:(NSString *)city {
    [self.userDefaults setObject:city forKey:cityKey];
}

-(NSString *)userID {
    return [self.userDefaults valueForKey:userIDKey];
}

-(void)setUserID:(NSString *)userID {
    [self.userDefaults setObject:userID forKey:userIDKey];
}

@end
