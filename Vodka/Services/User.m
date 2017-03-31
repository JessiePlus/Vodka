//
//  User.m
//  Vodka
//
//  Created by dinglin on 2017/3/5.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "User.h"

@implementation User

-(User *)initWithName:(NSString *)name andCity:(NSString *)city {
    if(self=[super init]) {
        self.name = name;
        self.city = city;
    }
    
    return self;
}

+(User *)userWithName:(NSString *)name andCity:(NSString *)city {
    User *user = [[User alloc] initWithName:name andCity:city];
    
    return user;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"User(name: %@, city: %@, accessToken: %@, userID: %@)",self.name,self.city, self.accessToken, self.userID];
}

@end
