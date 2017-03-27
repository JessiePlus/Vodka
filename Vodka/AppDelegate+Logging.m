//
//  AppDelegate+Logging.m
//  Vodka
//
//  Created by dinglin on 2017/3/27.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "AppDelegate+Logging.h"
#import <CocoaLumberjack/CocoaLumberjack.h>


@implementation AppDelegate (Logging)

- (void)setupLogging
{
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
}

@end
