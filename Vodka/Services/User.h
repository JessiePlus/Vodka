//
//  User.h
//  Vodka
//
//  Created by dinglin on 2017/3/5.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

/**
 the name of user
 */
@property (nonatomic, copy) NSString *name;

/**
 the accessToken of user
 */
@property (nonatomic, copy) NSString *accessToken;

/**
 the ID of user
 */
@property (nonatomic, copy) NSString *userID;

/**
 create User with name and city.

 @param name the name of user
 @return return an instance of User
 */
-(User *)initWithName:(NSString *)name;
+(User *)userWithName:(NSString *)name;

@end
