//
//  AppUtil.m
//  Vodka
//
//  Created by dinglin on 2017/3/30.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "AppUtil.h"

@interface AppUtil ()

@property (nonatomic) NSDateFormatter *dateFormatter;


@end

@implementation AppUtil

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

+ (AppUtil *)util{
    static AppUtil *o;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        o = [[AppUtil alloc] init];
    });
    return o;
}

-(NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc]init];
        [_dateFormatter setDateFormat:@"yyyy/MM/dd"];
    }

    return _dateFormatter;
}

- (NSString *)formatDate:(NSDate *)date{
    if(!date)return @"";
    return [self.dateFormatter stringFromDate:date];
}

+(NSString *)notificationNameSignIn {
    return @"Vodka.Notification.signIn";
}

+(NSString *)appGroupID {
    return @"com.Vodka.Newsmore";
}

@end
