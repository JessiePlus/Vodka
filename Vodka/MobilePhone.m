//
//  MobilePhone.m
//  Vodka
//
//  Created by dinglin on 2017/3/5.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "MobilePhone.h"

@implementation MobilePhone

-(NSString *)fullNumber {
    return [NSString stringWithFormat:@"+%@ %@",self.areaCode,self.number];
    
    
}

-(MobilePhone *)initWithAreaCode:(NSString *)areaCode andNumber:(NSString *)number {
    if(self=[super init]) {
        self.areaCode = areaCode;
        self.number = number;
    }
    
    return self;
}

+(MobilePhone *)mobilePhoneWithAreaCode:(NSString *)areaCode andNumber:(NSString *)number {
    MobilePhone *mobilePhone = [[MobilePhone alloc] initWithAreaCode:areaCode andNumber:number];
    
    return mobilePhone;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"MobilePhone(areaCode: %@, number: %@)",self.areaCode,self.number];
}

@end
