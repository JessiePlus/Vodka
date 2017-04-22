//
//  Logging.h
//  Vodka
//
//  Created by dinglin on 2017/3/28.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#ifndef Logging_h
#define Logging_h

#import <CocoaLumberjack/CocoaLumberjack.h>

#if DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelInfo;
#endif

#endif /* Logging_h */
