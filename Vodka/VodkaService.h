//
//  VodkaService.h
//  Vodka
//
//  Created by dinglin on 2017/3/5.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VodkaService : NSObject


@property (nonatomic, strong, readonly) NSURL *apiBaseUrl;
@property (nonatomic, strong, readonly) NSString *apiAppID;
@property (nonatomic, strong, readonly) NSString *apiAppKey;
@property (nonatomic, strong, readonly) NSString *apiToken;

+ (instancetype)sharedManager;


@end
