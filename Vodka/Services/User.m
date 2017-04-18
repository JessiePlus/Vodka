//
//  User.m
//  Vodka
//
//  Created by dinglin on 2017/3/5.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "User.h"

@implementation User

-(User *)initWithName:(NSString *)name {
    if(self=[super init]) {
        self.name = name;
    }
    
    return self;
}

+(User *)userWithName:(NSString *)name {
    User *user = [[User alloc] initWithName:name];
    
    return user;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"User(name: %@, accessToken: %@, userID: %@)",self.name, self.accessToken, self.userID];
}

@end
