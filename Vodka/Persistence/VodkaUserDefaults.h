//
//  VodkaUserDefaults.h
//  Vodka
//
//  Created by dinglin on 2017/4/17.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface VodkaUserDefaults : NSObject


+(instancetype)sharedUserDefaults;

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *userID;



@end
