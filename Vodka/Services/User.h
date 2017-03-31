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
 the city of user
 */
@property (nonatomic, copy) NSString *city;

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
 @param city the city of user
 @return return an instance of User
 */
-(User *)initWithName:(NSString *)name andCity:(NSString *)city;
+(User *)userWithName:(NSString *)name andCity:(NSString *)city;

@end
