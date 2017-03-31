//
//  MobilePhone.h
//  Vodka
//
//  Created by dinglin on 2017/3/5.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobilePhone : NSObject

/**
 the areaCode of MobilePhone
 */
@property (nonatomic, copy) NSString *areaCode;

/**
 the number of MobilePhone
 */
@property (nonatomic, copy) NSString *number;


/**
 fullNumber

 @return return the fullNumber of MobilePhone
 */
-(NSString *)fullNumber;

/**
 create MobilePhone with areaCode and number.
 
 @param areaCode the areaCode of MobilePhone
 @param number the number of MobilePhone
 @return return an instance of MobilePhone
 */
-(MobilePhone *)initWithAreaCode:(NSString *)areaCode andNumber:(NSString *)number;
+(MobilePhone *)mobilePhoneWithAreaCode:(NSString *)areaCode andNumber:(NSString *)number;

@end
